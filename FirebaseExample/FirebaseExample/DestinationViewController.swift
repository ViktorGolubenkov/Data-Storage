//
//  DestinationViewController.swift
//  FirebaseExample
//
//  Created by Viktor Golubenkov on 21.02.2021.
//

import UIKit
import Firebase

class DestinationViewController: UIViewController {
    
    @IBOutlet weak var labelOutlet: UILabel!
    
    let database = Firestore.firestore()

    var emails: [User] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataFromDatabase()
        
    }
    

    
    // fetching data from database collection
    func fetchDataFromDatabase() {

        
        database.collection(K.data).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error: \(error), can't get data from database")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let userData = data[K.email] as? String {
                            let newEmail = User(email: userData)
                            self.emails.append(newEmail)

                            DispatchQueue.main.async {
                                self.labelOutlet.text = "\(self.emails)"
                            }
                        }
                    }
                }
            }
        }
    }
    
    // signing out and dissmissing view
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let singOutError as NSError {
            print("Error signing out: \(singOutError)")
        }
        
    }
    
    
    
    
    
}

