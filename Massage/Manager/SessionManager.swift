//
//  SessionManager.swift
//  b2c-ios
//
//  Created by Giles Williams on 12/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import UIKit
import ReactiveSwift

public enum NoError: Swift.Error { }

class SessionManager {
    static let sharedInstance = SessionManager()
    
    let currentSession = MutableProperty<Session?>(nil)
    
    func restoreSavedSession() {
        var savedSession: Session? = RealmManager.realm().objects(Session.self).first
        if(savedSession == nil) {
            // no saved session found - before we go ahead and assume that they're logged out, let's check the saved token
            if let savedToken = loadSavedToken() {
                // we have a saved token, create an empty session with the token so it can be fetched from the server
                // this typically only happens if the db migrates and gets wiped
                print("session data missing - loading from stored token")
                savedSession = Session(token: savedToken)
            }
        }
        
        self.currentSession.swap(savedSession)
        
        if(self.currentSession.value != nil) {
            DispatchQueue.main.async { [weak self] in
                self?.refreshCurrentSession()
            }
        }
    }
    
    func refreshCurrentSession() {
        let req = APIClient.sharedInstance.me()
        
        req.startWithResult { [weak self] (result) in
            if let session = result.value {
                self?.setCurrentSessionData(session)
            }
            else if let error = result.error {
                if(error.httpStatus == 401) {
                    // session no longer valid, clear it
                    self?.logout()
                }
            }
        }
    }
    
    func setCurrentSessionData(_ session: Session) {
        // store the token separately in case the DB gets wiped
        persistToken(session.token)
        
        // write this session to the db
        try! RealmManager.realm().write {
            RealmManager.realm().add(session, update: true)
        }
        
        // trigger a session refresh
        self.currentSession.swap(session)
        
        self.afterLogin()
    }
    
    func attemptLogin(emailAddress: String, password: String) -> SignalProducer<Session, APIClient.APIError> {
        return APIClient.sharedInstance.login(emailAddress: emailAddress, password: password).on(event: { [weak self] (result) in
            if let session = result.value {
                RealmManager.sharedInstance.clearEntireDatabase()
                
                self?.setCurrentSessionData(session)
                self?.afterLogin()
            }
            })
    }

    func attemptSignup(emailAddress: String, password: String, fullName: String, city_id: String) -> SignalProducer<Session, APIClient.APIError> {
        return APIClient.sharedInstance.signup(withEmail: emailAddress, password: password, name: fullName, city_id: city_id).on(event: { [weak self] (result) in
            if let session = result.value {
                RealmManager.sharedInstance.clearEntireDatabase()
                
                self?.setCurrentSessionData(session)
                self?.afterLogin()
            }
            })
    }
    
    func attemptFacebookLogin(fbToken: String, city_id: String) -> SignalProducer<Session, APIClient.APIError> {
        
        return APIClient.sharedInstance.login(withFacebookToken: fbToken, city_id: city_id).on(event: { [weak self] (result) in
            if let session = result.value {
                RealmManager.sharedInstance.clearEntireDatabase()
                
                self?.setCurrentSessionData(session)
                self?.afterLogin()
            }
            })
    }

    
    func logout() {
        #if DEBUG
            print("SessionStore#logout")
        #endif
        
        
        // TODO - wipe tracking
        
        // wipe the db, including the session
        RealmManager.sharedInstance.clearEntireDatabase()
        
        // store the token as nil separately in case the DB gets wiped
        persistToken(nil)
        
        // trigger a session refresh (will cause the app to realise it's logged out)
        self.currentSession.swap(nil)
        
        SearchManager.sharedInstance.currentSearch.swap(nil)
    }
    
    
    // MARK - internal login
    
    private func afterLogin() {
        if self.currentSession.value != nil {
            // TODO - sync tracking
        }
    }
    
    func callSupportNumber() {
        var telNumber: String?
        
        if let session = self.currentSession.value {
            if let city = session.user?.homeCity {
                telNumber = city.telephoneLink
            }
            else if let country = session.user?.homeCountry {
                telNumber = country.fallbackPhoneFormatted
            }
        }
        
        if let foundTelNumber = telNumber {
            let urlStr = "telprompt:+" + foundTelNumber
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: urlStr)!)
            } else {
                // older
                UIApplication.shared.openURL(URL(string: urlStr)!)
            }
        }
    }
    
    
    // MARK - token methods
    
    private let SESSION_TOKEN_USER_DEFAULTS_KEY = "com.urbanmassage.defaults.authKey"
    
    private func persistToken(_ token: String?) {
        print("persist token", token)
        
        UserDefaults.standard.set(token, forKey: SESSION_TOKEN_USER_DEFAULTS_KEY)
        UserDefaults.standard.synchronize()
    }
    
    private func loadSavedToken() -> String? {
        return UserDefaults.standard.string(forKey: SESSION_TOKEN_USER_DEFAULTS_KEY)
    }
}
