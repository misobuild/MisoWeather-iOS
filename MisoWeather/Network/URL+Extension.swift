//
//  URL+Extension
.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/15.
//

import Foundation

enum Path {
    static var domain = "http://3.35.55.100/api/"
    static var region = "region/"
    static var member = "member"
    static var nickname = "nickname"
    static var token = "/token"
    static var socialToken = "?socialToken="
    static var forecast = "forecast/"
    static var comment = "comment?"
    static var commnetId = "commentId="
    static var size = "size="
}

extension URL {
    static let region = Path.domain + Path.region
    
    static let nickname = Path.domain + Path.member + "/" + Path.nickname
    static let sinup = Path.domain + Path.member + Path.socialToken
   
    static let member = Path.domain + Path.member
    
    // 토큰 재발급
    static let token = Path.domain + Path.member + Path.token + Path.socialToken
    
    // MainView
    // 날씨 간략 정보
    static let realtimeForecast = Path.domain + Path.forecast
    
    // 한줄평
    static let comment = Path.domain + Path.comment
}
