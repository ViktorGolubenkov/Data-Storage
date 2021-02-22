//
//  ShowViewController.swift
//  RegistrationForm
//
//  Created by Viktor Golubenkov on 03.02.2021.
//

import UIKit

class ShowViewController: UIViewController {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    let name = Manager.userData.firstName
    let surname = Manager.userData.lastName
    let email = Manager.userData.email
    let age = Manager.userData.age
    let gender = Manager.userData.gender
    let country = Manager.userData.country

    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageLabel.text = "You saved your data!"
        fullNameLabel.text = "Fullname: \(name), \(surname)"
        emailLabel.text = "Email: \(email)"
        ageLabel.text = "Age: \(age)"
        genderLabel.text = "Gender: \(gender.rawValue.capitapizingFirstLetter())"
        countryLabel.text = "Country: \(country)"
        
    }
    
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        // NOTE! - This method will clear the memory every time "Close" is pressed
        UserDefaults.clear()
        
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Extension for "String" (When we request data from memory, "gender" is lowercase)

extension String {
    func capitapizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitapizingFirstLetter()
    }
}
