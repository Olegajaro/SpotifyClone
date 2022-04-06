//
//  AuthService.swift
//  Spotify
//
//  Created by Олег Федоров on 06.04.2022.
//

import Foundation

final class AuthService {
    
    static let shared = AuthService()
    
    struct Constans {
        static let cliendID = "a138ef3c121b46a2914092328c256da9"
        static let clientSecret = "0ad2572a341641959e84a73d5d2e3399"
    }
    
    private init() {}
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://www.iosacademy.io"
        let baseURL = "https://accounts.spotify.com/authorize"
        let stringURL = "\(baseURL)?response_type=code&client_id=\(Constans.cliendID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        
        return URL(string: stringURL)
    }
    
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
    
    public func exchangeCodeForToken(code: String,
                                     completion: @escaping (Bool) -> Void) {
         // Get token
        
    }
    
    private func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
