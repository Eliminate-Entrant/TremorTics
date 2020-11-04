//
//  SettingsBundleHelper.swift
//  Tremor Tics
//
//  Created by Shaheer Chaudry on 8/27/19.
//  Copyright © 2019 Shaheer Chaudry. All rights reserved.
//
import Foundation


class SettingsBundleHelper {
    struct SettingsBundleKeys {
        static let Reset = "RESET_APP_KEY"
        static let BuildVersionKey = "build_preference"
        static let AppVersionKey = "version_preference"
        static let User = "USER"
        
    }
    
    class func removeUserInfo(){
        if UserDefaults.standard.bool(forKey: SettingsBundleKeys.User) {
            UserDefaults.standard.set(false, forKey: SettingsBundleKeys.User)
            let appDomain: String? = Bundle.main.bundleIdentifier
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
            
        } }
    class func checkAndExecuteSettings() {
        if UserDefaults.standard.bool(forKey: SettingsBundleKeys.Reset) {
            UserDefaults.standard.set(false, forKey: SettingsBundleKeys.Reset)
            let appDomain: String? = Bundle.main.bundleIdentifier
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
            tr.removeAll()
            TremorReportsTableViewController().saveReports()
            // reset userDefaults..
            
            // delete all other user data here..
        }
    }
    
    class func setVersionAndBuildNumber() {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.set(version, forKey: "version_preference")
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.set(build, forKey: "build_preference")
    }
}
