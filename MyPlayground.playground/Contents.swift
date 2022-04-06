import UIKit

let arrayScopes = [
    "user-read-private", "playlist-modify-public",
    "playlist-read-private", "playlist-modify-private",
    "user-follow-read", "user-library-modify",
    "user-library-read", "user-read-email"
]

arrayScopes.joined(separator: "%20")
