//
//  Manager.swift
//  RegistrationForm
//
//  Created by Viktor Golubenkov on 02.02.2021.
//

import Foundation

final class Manager {
     
    
    //MARK: - 2 types of stored data ("userName" - for simple data, such as firstName/lastName, "userData" - to store different data)

    private enum SettingsKeys: String {
        
        case userName
        case userData
        
    }
    
    
    //MARK: - In this case, data of the simple "String" type is saved (such as firstName/lastName or both) and associated with the key "userName"

    static var userName: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userName.rawValue
            if let name = newValue {
                defaults.set(name, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    //MARK: - And in another case, here trying to save different data associated with the key "userData"

    static var userData: UserModel! {
        get {
            // IMPORTANT! Requested data must be explicitly specified as a "Data" type
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKeys.userData.rawValue) as? Data,
            let decodedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? UserModel
            else { return nil }
            return decodedData
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userData.rawValue
            // IMPORTANT! For saving different data in a "UserDefaults", all user data must be converted to the "Data" type
            if let userData = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: userData, requiringSecureCoding: false) {
                    defaults.setValue(savedData, forKey: key)
                }
            }
        }
    }
  
}

//MARK: - Method for deleting all data from UserDefaults

extension UserDefaults {
    static func clear() {
        guard let domain = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
