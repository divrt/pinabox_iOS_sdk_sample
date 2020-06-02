//
//  ViewController.swift
//  PinaboxDemoApp2
//
//  Created by Anvesh on 3/5/20.
//  Copyright © 2020 DIVRT. All rights reserved.
//

import UIKit
import DivrtPinabox


class ViewController: UIViewController {
    
    @IBOutlet weak var entryContainerView: UIView!
    @IBOutlet weak var entryLane1SimulationSwitch: UISwitch!
    @IBOutlet weak var entryLane2SimulationSwitch: UISwitch!
    @IBOutlet weak var entryLane3SimulationSwitch: UISwitch!
    
   
    
    @IBOutlet weak var entryLaneInfoTextField: UITextField!
    
    
    
    @IBOutlet weak var entryLaneButton: UIButton!
    
    @IBOutlet weak var exitContainerView: UIView!
    @IBOutlet weak var exitLane1SimulationSwitch: UISwitch!
    @IBOutlet weak var exitLane2SimulationSwitch: UISwitch!
    @IBOutlet weak var exitLane3SimulationSwitch: UISwitch!
    
    
    
    @IBOutlet weak var exitLaneInfoTextField: UITextField!
    
    
    @IBOutlet weak var exitLaneButton: UIButton!
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    

    @IBOutlet weak var entryButton:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        PinaSDK.shared.onSuccess = {(messageDescription, gateType) in
            var message = ""
            switch gateType {
            case .IN:
                    message = "Checked In successfully. Please enter the garage"
                 
                case .OUT:
                 
                    message = "Checked out successfully. Please exit the garage"
                
            default:
                message = "Something went wrong"
            }
         
            let myalert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
            
            myalert.addAction(UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
                print("Cancel")
            })
            
            self.present(myalert, animated: true)
        }
        
        PinaSDK.shared.onFailure = {(messageDescription, gateType) in
         
            let myalert = UIAlertController(title: "Info", message: messageDescription, preferredStyle: .alert)
            
            myalert.addAction(UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
                print("Cancel")
            })
            
            self.present(myalert, animated: true)
        }
    }
    
    
   
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    @IBAction func entryButton(_ sender: Any) {
        
      
        var pinaConfig = PinaConfig()
        pinaConfig.zoneId = "12345"
        pinaConfig.helpText = self.entryLaneInfoTextField.text ?? "Welcome to ABC garage"
        pinaConfig.simulationMode = true
        pinaConfig.inOrOut = .IN
        pinaConfig.divrtClientKey = "CONTACT_US_FOR_KEY" //Please contact us to get your key"
        PinaSDK.shared.pinaInterface(viewController:self, pinaConfig: pinaConfig)
    }
    
    @IBAction func exitButton(_ sender: Any) {
        
      
        
        var pinaConfig = PinaConfig()
        pinaConfig.zoneId = "12345"
        pinaConfig.helpText = self.exitLaneInfoTextField.text ?? "Welcome to ABC garage"
        pinaConfig.simulationMode = true
        pinaConfig.inOrOut = .OUT
        pinaConfig.divrtClientKey = "CONTACT_US_FOR_KEY" //Please contact us to get your key"
        PinaSDK.shared.pinaInterface(viewController:self, pinaConfig: pinaConfig)
    }
   
}

extension ViewController:UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1{
            
        } else if textField.tag == 2{
            NotificationCenter.default.addObserver(self,
                   selector: #selector(self.keyboardNotification(notification:)),
                   name: UIResponder.keyboardWillChangeFrameNotification,
                   object: nil)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            NotificationCenter.default.removeObserver(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        
        return textField.resignFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        
        
        return true
    }
    
}


    
