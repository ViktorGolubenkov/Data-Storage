//
//  MainViewController.swift
//  FirebaseExample
//
//  Created by Viktor Golubenkov on 21.02.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class MainViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var singUpButtonOutlet: UIButton!
    
    let database = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    // Login
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                
                if let error = error {
                    print(error)
                    self.loginErrorAlert()
                    
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: nil)
                }
            }

        }
    }
    
    // Sing Up
    @IBAction func singUpPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            // creating a user
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if let error = error {
                    self.singUpErrorAlert(error: error.localizedDescription)
                } else {
                    // saving email to database collection
                    self.database.collection(K.data).addDocument(data: [K.email: email]) { (error) in
                        if let error = error {
                            print("Error: \(error), data not saved to FirestoneDB")
                            
                        } else {
                            self.singUpSuccessfullyAlert()
                        }
                    }
                }
            }
        }
    }

    
}


extension MainViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loginButtonOutlet.layer.cornerRadius = 8
        singUpButtonOutlet.layer.cornerRadius = 8
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    func loginErrorAlert() {
        
        let alert = UIAlertController(title: "Incorrect email/password", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func singUpErrorAlert(error: String) {
        
        let alert = UIAlertController(title: "Incorrect email/password", message: "The email must be formatted as 'example@mail.com' and the password must contain at least 6 characters", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func singUpSuccessfullyAlert() {
        
        let alert = UIAlertController(title: "Account created succesfully", message: "You can now log in", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Log in", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
}
