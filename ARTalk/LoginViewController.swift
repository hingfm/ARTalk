//
//  LoginViewController.swift
//  ARTalk
//
//  Created by Hing Chung on 28/1/2024.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class LoginViewController: UIViewController {
    
    @IBOutlet var emailAddress: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        if let email = emailAddress.text, let password = password.text {
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password){
                authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "loginAR" , sender: self)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
