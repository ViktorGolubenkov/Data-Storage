//
//  FormViewController.swift
//  RegistrationForm
//
//  Created by Viktor Golubenkov on 02.02.2021.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    
    
    var genderSegment: GenderType?
    var country: String?
    let countries = Countries().countries
    let genderTypes = ["Male", "Female", "Other"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        
    }

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        // gender
        switch genderSegmentedControl.selectedSegmentIndex {
        case 0:
            genderSegment = .male
        case 1:
            genderSegment = .female
        case 2:
            genderSegment = .other
        default:
            break
        }
        
        // other data
        let firstNameText = firstNameTextField.text!.trimmingCharacters(in: .whitespaces)
        let lastNameText = lastNameTextField.text!.trimmingCharacters(in: .whitespaces)
        let email = emailTextField.text!.trimmingCharacters(in: .whitespaces)
        let age = ageTextField.text!.trimmingCharacters(in: .whitespaces)
        
        // country
        guard let country = country,
              let gender = genderSegment else { return }
    
        // create a "data container" for all data
        let userObject = UserModel(firstName: firstNameText, lastName: lastNameText, email: email, age: age, gender: gender, country: country)
        
        // save this data (in this case firstName and lastName) under the "userName" key:
        Manager.userName = firstNameText + ", " + lastNameText
        
        // save this data(container) under the "userData" key:
        Manager.userData = userObject

        
        // check if the data is saved properly, we should see something like "firstName, lastName":
        print(Manager.userName!)
        // check if the data is saved properly, we should see something like "<RegistrationForm.UserModel: 0x600000685080>":
        print(Manager.userData!)
    }

    
}

//MARK: - Picker delegate & datasource


extension FormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let country = countries[row]
        
        return country
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        country = countries[row]
    }
    
}


//MARK: - Animation


extension FormViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        
        // rounded style for save button
        saveButton.layer.cornerRadius = 10
        showButton.layer.cornerRadius = 10
        
        // animation for labels
        let labelAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn) {
            self.firstNameLabel.center.x -= 555
            self.firstNameLabel.frame.size.width = 200
            self.firstNameTextField.center.x += 555
            self.firstNameTextField.frame.size.width = 200
            self.lastNameLabel.center.x -= 555
            self.lastNameLabel.frame.size.width = 200
            self.lastNameTextField.center.x += 555
            self.lastNameTextField.frame.size.width = 200
            self.emailLabel.center.x -= 555
            self.emailLabel.frame.size.width = 200
            self.emailTextField.center.x += 555
            self.emailTextField.frame.size.width = 200
            self.ageLabel.center.x -= 555
            self.ageLabel.frame.size.width = 200
            self.ageTextField.center.x += 555
            self.ageTextField.frame.size.width = 200
            self.genderLabel.center.x -= 555
            self.genderLabel.frame.size.width = 200
            self.genderSegmentedControl.center.x += 555
            self.genderSegmentedControl.frame.size.width = 200
            self.countryLabel.center.x -= 555
            self.countryLabel.frame.size.width = 200
            self.countryPicker.center.x += 555
            self.countryPicker.frame.size.width = 200
        }
        
        labelAnimator.startAnimation(afterDelay: 0.3)
        
        // animation for buttons
        let buttonAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn) {
            self.saveButton.center.x += 555
            self.saveButton.frame.size.width = 200
            self.showButton.center.x -= 555
            self.showButton.frame.size.width = 200
        }
        
        buttonAnimator.startAnimation(afterDelay: 0.5)
    }
    
}
