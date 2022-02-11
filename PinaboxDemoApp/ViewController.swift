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
        //ON SUCCESS
            PinaSDK.shared.onSuccess = {(data) in
               //ADD YOUR BUSINESS LOGIC HERE ON SUCCESSFULLY GATE OPENING
                 let messageDescription = data["message"] as? String ?? ""
                   let myalert = UIAlertController(title: "Info", message: messageDescription, preferredStyle: .alert)
                   
                   myalert.addAction(UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
                       print("Cancel")
                   })
                   
                   self.present(myalert, animated: true)
             }
             
             //ON FAILURE
             PinaSDK.shared.onFailure = {(data) in
              
                 let messageDescription = data["message"] as? String ?? ""
                   let myalert = UIAlertController(title: "Info", message: messageDescription, preferredStyle: .alert)
                   
                   myalert.addAction(UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
                       print("Cancel")
                   })
                   
                   self.present(myalert, animated: true)
             }
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            let pinaConfig = getThePinaConfigParams(gateType: "IN") //Change the gateType based on the entry and exit
            PinaSDK.shared.pinaGateHandler(viewController:self, pinaConfig: pinaConfig)
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
        
        let pinaConfig = getThePinaConfigParams(gateType: "IN")
        PinaSDK.shared.pinaInterface(viewController:self, pinaConfig: pinaConfig)
    }
    
    @IBAction func exitButton(_ sender: Any) {
        
        let pinaConfig = getThePinaConfigParams(gateType: "OUT")
        PinaSDK.shared.pinaInterface(viewController:self, pinaConfig: pinaConfig)
    }
    
    func getThePinaConfigParams(gateType: String) -> PinaConfig {
         let pinaConfig = PinaConfig()
         
         pinaConfig.pinaSdkParams = ["helpText":"Welcome to ABC garage",
                                     "moveForwardText":"Move closer to the gate to entry"]
                
         pinaConfig.pinaConfigParams = ["ostype": "IOS",
                                        "simulationMode": true,
                                        "secret_key": "e8f364d7f44a2d380c2bea36c4433614debef99115cd4cfef321bab03239312f", // <== Replace with DIVRT client key.
                                        "zid": "12345",
                                        "uniqueID": "pinaboxdemo@divrt.co",
                                        "gateType": gateType]
                                           
         return pinaConfig
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


    
