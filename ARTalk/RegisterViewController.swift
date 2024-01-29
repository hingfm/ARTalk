//
//  RegisterViewController.swift
//  ARTalkUITests
//
//  Created by Hing Chung on 28/1/2024.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class RegisterViewController: UIViewController {

    @IBOutlet var newEmail: UITextField!
    @IBOutlet var newPassword: UITextField!
    @IBOutlet var regError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        if let email = newEmail.text, let password = newPassword.text {
            Auth.auth().createUser(withEmail: email, password: password){
                authResult, error in
                if let e = error {
                    //error
                    self.regError.text = e.localizedDescription
                }else{
                    //navigation to homeViewController after register
                    self.regError.text = ""
                    self.performSegue(withIdentifier: "registerSegue", sender: self)
                }
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
