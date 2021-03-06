//
//  ViewController.swift
//  DeviceTokenFromFireBase
//
//  Created by MAC on 06/03/21.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    
    @IBOutlet weak var instanceIDTokenMessage: UITextView!
    @IBOutlet weak var TokenView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.displayFCMToken(notification:)),
                                               name: Notification.Name("FCMToken"), object: nil)
    }
    @IBAction func LogTokenClicked(_ sender: UIButton) {
        if  let token = Messaging.messaging().fcmToken{
            print("FCM token: \(token)")
            // [END log_fcm_reg_token]
            self.TokenView.text  = "Logged FCM token: \(token)"
        }
        print(Messaging.messaging().apnsToken)
        //
        //        InstanceID.instanceID().instanceID { (result, error) in
        //          if let error = error {
        //            print("Error fetching remote instance ID: \(error)")
        //          } else if let result = result {
        //            print("Remote instance ID token: \(result.token)")
        //            self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
        //          }
        //        }
    }
    //    //code to make a token string
    //       func tokenString(_ deviceToken:Data) -> String{
    //           let bytes = [UInt8](deviceToken)
    //           var token = ""
    //           for byte in bytes{
    //               token += String(format: "%02x",byte)
    //           }
    //           return token // this token will be passed to your backend that can be written in php, js, .net etc.
    //       }
    @objc func displayFCMToken(notification: NSNotification){
        guard let userInfo = notification.userInfo else {return}
        if let fcmToken = userInfo["token"] as? String {
            self.TokenView.text = "Received FCM token: \(fcmToken)"
        }
    }
    @IBAction func SecondSB(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Demo", bundle: nil).instantiateViewController(withIdentifier: "SecondSBVC")
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}

extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
