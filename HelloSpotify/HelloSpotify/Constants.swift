//
//  Constants.swift
//  HelloSpotify
//
//  Created by Олег Федоров on 02.04.2022.
//

import Foundation

//let accessTokenKey = "access-token-key"
//let redirectUri = URL(string: "HelloSpotify://")
//let spotifyClientId = "yourClientId"
//let spotiftClientSecretKey = "yourSecretKey"

let accessTokenKey = "access-token-key"
let redirectUri = URL(string: "HelloSpotify://")!
let spotifyClientId = "3d6a6819c1324e2ca90142d997befeec"
let spotifyClientSecretKey = "26a7c3d63b52446b90c003a583739e99"

/*
 Scopes let you specify exactly what types of data your application wants to
 access, and the set of scopes you pass in your call determines what acess
 permissions the user is asked to grant.
 For more information, see https://developer.spotify.com/web-api/using-scopes/.
 */

let scopes: SPTScope = [
    .userReadEmail, .userReadPrivate,
    .userReadPlaybackState, .userModifyPlaybackState, .userReadCurrentlyPlaying,
    .streaming, .appRemoteControl,
    .playlistReadCollaborative, .playlistModifyPublic, .playlistReadPrivate, .playlistModifyPrivate,
    .userLibraryModify, .userLibraryRead,
    .userTopRead, .userReadPlaybackState, .userReadCurrentlyPlaying,
    .userFollowRead, .userFollowModify,
]
let stringScopes = [
    "user-read-email", "user-read-private",
    "user-read-playback-state", "user-modify-playback-state", "user-read-currently-playing",
    "streaming", "app-remote-control",
    "playlist-read-collaborative", "playlist-modify-public", "playlist-read-private", "playlist-modify-private",
    "user-library-modify", "user-library-read",
    "user-top-read", "user-read-playback-position", "user-read-recently-played",
    "user-follow-read", "user-follow-modify",
]
