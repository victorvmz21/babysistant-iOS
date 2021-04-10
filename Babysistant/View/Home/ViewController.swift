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
    var notificationTimer: TimeInterval?
    var storage = UserDefaults.standard
    var notificationTitle = ""
    var notificationBody  = ""
    
    //Localizable String
    var activeButtonLocalizable   = NSLocalizedString("ACTIVATE_BUTTON", comment: "active")
    var unactiveButtonLocalizable = NSLocalizedString("UNACTIVATE_BUTTON", comment: "unactive")
    
    var bottleNotificationTitle   = NSLocalizedString("BOTTLE_NOTIFICATION_TITLE", comment: "bottleTitle")
    var bottlNotificationBody     = NSLocalizedString("BOTTLE_NOTIFICATION_BODY", comment: "bottleBody")
    
    var diaperNotificationTitle   = NSLocalizedString("DIAPER_NOTIFICACTION_TITLE", comment: "diaperTitle")
    var diaperNotificaitionBody   = NSLocalizedString("DIAPER_NOTIFICATION_BODY", comment: "diaperBody")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
    }
    
    func setUI() {
        
        UserDefaults.resetStandardUserDefaults()
        
        btnActivate.roundAllEdges()
        btnActivate.setTitle(storage.string(forKey: "btnTitle") ?? activeButtonLocalizable, for: .normal)
        
        viewModel.requestNotification()
        
        timerSlider.addTarget(self, action: #selector(getTimerValue(timer:)), for: .valueChanged)
        
        //retrieving from userDefauts
        notificationTitle = storage.string(forKey: "title") ?? bottleNotificationTitle
        notificationBody = storage.string(forKey: "body") ??  bottlNotificationBody
        isTimerActivated = storage.bool(forKey: "isTimerActive")
        sgmtControll.setTitleColor(UIColor(named: "customBabyBlue")!)
        sgmtControll.selectedSegmentIndex = storage.integer(forKey: "sgmtIndex")
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
    }
    
    @objc func getTimerValue(timer: CircularSlider) {
        
        notificationTimer = TimeInterval(timer.value)
        
    }
    
    
    @IBAction func segmentControllTapped(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            notificationTitle = bottleNotificationTitle
            notificationBody  = bottlNotificationBody
            
            storage.setValue(notificationTitle, forKey: "title")
            storage.setValue(notificationBody, forKey: "body")
            storage.setValue(0, forKey: "sgmtIndex")
            
        } else {
            
            notificationTitle = diaperNotificationTitle
            notificationBody  = diaperNotificaitionBody
            
            storage.setValue(notificationTitle, forKey: "title")
            storage.setValue(notificationBody, forKey: "body")
            storage.setValue(1, forKey: "sgmtIndex")
            
        }
        
    }
    
    
    @IBAction func activatedBtnTapped(_ sender: UIButton) {
        
        isTimerActivated.toggle()
        storage.setValue(isTimerActivated, forKey: "isTimerActive")
        
        if isTimerActivated {
            
            viewModel.triggerNotification(title: notificationTitle, body: notificationBody, time: notificationTimer ?? 1.0)
            
            sender.setTitle(unactiveButtonLocalizable, for: .normal)
            storage.setValue(sender.currentTitle, forKey: "btnTitle")
            
        } else {
            
            viewModel.deactivateNotification()
            sender.setTitle(activeButtonLocalizable, for: .normal)
            storage.setValue(sender.currentTitle, forKey: "btnTitle")
            
        }
        
    }
    
    
}

