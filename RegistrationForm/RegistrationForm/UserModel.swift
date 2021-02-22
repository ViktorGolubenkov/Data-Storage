//
//  UserModel.swift
//  RegistrationForm
//
//  Created by Viktor Golubenkov on 02.02.2021.
//

import Foundation

//MARK: - Model


class UserModel: NSObject, NSCoding {
    
    let firstName: String
    let lastName: String
    let email: String
    let age: String
    let gender: GenderType
    let country: String
    
    init(firstName: String, lastName: String, email: String, age: String, gender: GenderType, country: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        self.gender = gender
        self.country = country
    }

    func encode(with coder: NSCoder) {
        coder.encode(firstName, forKey: "firstName")
        coder.encode(lastName, forKey: "lastName")
        coder.encode(email, forKey: "email")
        coder.encode(age, forKey: "age")
        coder.encode(gender.rawValue, forKey: "gender")
        coder.encode(country, forKey: "country")
    }
    
    required init?(coder: NSCoder) {
        firstName = coder.decodeObject(forKey: "firstName") as? String ?? ""
        lastName = coder.decodeObject(forKey: "lastName") as? String ?? ""
        email = coder.decodeObject(forKey: "email") as? String ?? ""
        age = coder.decodeObject(forKey: "age") as? String ?? ""
        gender = GenderType(rawValue: coder.decodeObject(forKey: "gender") as! String) ?? GenderType.male
        country = coder.decodeObject(forKey: "country") as? String ?? ""
    }

}

enum GenderType: String {
    case male
    case female
    case other
}


