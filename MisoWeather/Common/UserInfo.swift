//
//  UserInfo.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/14.
//

class UserInfo {
    static let shared = UserInfo()
    var name: String?
    
    private init() {}
    // instance 생성 X
}

let userInfo = UserInfo.shared
