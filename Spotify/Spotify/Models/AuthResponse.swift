//
//  AuthResponse.swift
//  Spotify
//
//  Created by Олег Федоров on 06.04.2022.
//

import Foundation

struct AuthResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String?
    let scope: String
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
    }
}

/*
 Success -  {
     "access_token" = "BQDufXRR9sHJ5BSvUMXwa5vK7Jz97twnvxldS-n0YgVp3mtOtihrZgNXIXdPftF_JxgTx8Cdy-VquR0m7OX30LVPwQhgGi0ngR-Os_FeXQtYmR41DffR61fYIghV6VKpXWbdkXzoZlbICqQ1aanhwztjXch3nQIoI9RzETqljEb_vDd8kJo";
     "expires_in" = 3600;
     "refresh_token" = "AQAFdqLiyeGtQyxVWdRrTs24UjZPOCGrUXcytqXbfjb5SB0xzJsp5vAEm7rr1s35BcIr0ZFqn6JOZ-XUm76ovm8mk-O6DoiL8I7rj-7U8qwf3Jhj5FIwyThk8-wix1LtMMM";
     scope = "user-read-private";
     "token_type" = Bearer;
 }
 */
