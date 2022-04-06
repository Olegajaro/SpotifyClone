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
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirectURI = "https://www.iosacademy.io"
        static let arrayScopes = [
            "user-read-private", "playlist-modify-public",
            "playlist-read-private", "playlist-modify-private",
            "user-follow-read", "user-library-modify",
            "user-library-read", "user-read-email"
        ]
    }
    
    private init() {}
    
    public var signInURL: URL? {
        let baseURL = "https://accounts.spotify.com/authorize"
        let stringURL = "\(baseURL)?response_type=code&client_id=\(Constans.cliendID)&scope=\(Constans.arrayScopes.joined(separator: "%20"))&redirect_uri=\(Constans.redirectURI)&show_dialog=TRUE"
        
        return URL(string: stringURL)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        let currentDate = Date()
        let fiveMinute: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinute) >= expirationDate
    }
    
    public func exchangeCodeForToken(code: String,
                                     completion: @escaping (Bool) -> Void) {
         // Get token
        guard let url = URL(string: Constans.tokenAPIURL) else { return }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constans.redirectURI)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constans.cliendID + ":" + Constans.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("DEBUG: Failure to get base64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)",
                         forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }

            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    func refreshTokenIfNeeded(completion: @escaping (Bool) -> Void) {
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        
        guard let refreshToken = refreshToken else {
            return
        }

        // Refresh the token
        guard let url = URL(string: Constans.tokenAPIURL) else { return }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constans.cliendID + ":" + Constans.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("DEBUG: Failure to get base64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)",
                         forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }

            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                print("DEBUG: Successfully refreshed")
                self?.cacheToken(result: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.accessToken, forKey: "accessToken")
        
        if let refreshToken = result.refreshToken {
            UserDefaults.standard.setValue(refreshToken, forKey: "refreshToken")
        }
 
        UserDefaults.standard.setValue(
            Date().addingTimeInterval(TimeInterval(result.expiresIn)),
            forKey: "expirationDate"
        )
    }
}
