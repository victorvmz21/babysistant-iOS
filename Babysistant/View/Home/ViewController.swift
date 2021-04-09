//
//  ViewController.swift
//  Babysistant
//
//  Created by Victor Monteiro on 4/8/21.
//

import UIKit
import JOCircularSlider

class ViewController: UIViewController {
    
    
    @IBOutlet weak var sgmtControll: UISegmentedControl!
    @IBOutlet weak var btnActivate: UIButton!
    @IBOutlet weak var timerSlider: CircularSlider!
    
    
    var isTimerActivated: Bool = false
    var viewModel = TimerViewModel()
    var notificationTitle = "Time to feed your baby"
    var notificationBody  = "check if your baby is hungry"
    var notificationTimer: TimeInterval?
    var storage = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
    }
    
    
    
    func setUI() {
        
        btnActivate.roundAllEdges()
        btnActivate.setTitle(storage.string(forKey: "btnTitle") ?? "Activate", for: .normal)
    
        viewModel.requestNotification()
        
        timerSlider.addTarget(self, action: #selector(getTimerValue(timer:)), for: .valueChanged)
        
        //retrieving from userDefauts
        
        notificationTitle = storage.string(forKey: "title") ?? "Time to feed your baby"
        notificationBody = storage.string(forKey: "body") ??  "check if your baby is hungry"
        isTimerActivated = storage.bool(forKey: "isTimerActive") 
        sgmtControll.selectedSegmentIndex = storage.integer(forKey: "sgmtIndex")
        
    }
    
    @objc func getTimerValue(timer: CircularSlider) {
        
        notificationTimer = TimeInterval(timer.value)
        
    }
    
    @IBAction func segmentControllTapped(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            notificationTitle = "Time to feed your baby"
            notificationBody  = "check if your baby is hungry"
            
            storage.setValue(notificationTitle, forKey: "title")
            storage.setValue(notificationBody, forKey: "body")
            storage.setValue(0, forKey: "sgmtIndex")
            
        } else {
            
            notificationTitle = "Time to change your baby's diaper"
            notificationBody  = "check if you baby is hungry."
            
            storage.setValue(notificationTitle, forKey: "title")
            storage.setValue(notificationBody, forKey: "body")
            storage.setValue(1, forKey: "sgmtIndex")
            
        }
        
    }
    
    
    @IBAction func activatedBtnTapped(_ sender: UIButton) {
        
        isTimerActivated.toggle()
        storage.setValue(isTimerActivated, forKey: "isTimerActive")
        
        if isTimerActivated {
            
            viewModel.triggerNotification(title: notificationTitle, body: notificationBody, time: notificationTimer ?? 30.0)
            
            sender.setTitle("Deactivate", for: .normal)
            storage.setValue(sender.currentTitle, forKey: "btnTitle")
            
        } else {
            
            viewModel.deactivateNotification()
            sender.setTitle("Activate", for: .normal)
            storage.setValue(sender.currentTitle, forKey: "btnTitle")
            
        }
        
    }


}

