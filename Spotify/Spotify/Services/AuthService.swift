//
//  AuthService.swift
//  Spotify
//
//  Created by Олег Федоров on 06.04.2022.
//

import Foundation

final class AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var expirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}
