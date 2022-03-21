//
//  URL+Extension.swift
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
    static var comment = "comment"
    static var commnetId = "commentId="
    static var size = "size="
    static var survey = "survey"
    static var shortBigScale = "?shortBigScale="
    static var answers = "/answers/"
    static var precheck = "/precheck"
    static var exist = "/existence?socialId="
    static var socialType = "&socialType="
    static var chageRegion = "member-region-mapping/default?regionId="
    static var weather = "new-forecast/"
    static var update = "update/"
    static var houlry = "hourly/"
    static var daily = "daily/"
    static var airdust = "airdust/"
}

extension URL {
    /// 회원 여부 검사
    static let existence = Path.domain + Path.member + Path.exist

    static let region = Path.domain + Path.region
    
    static let nickname = Path.domain + Path.member + "/" + Path.nickname
    static let sinup = Path.domain + Path.member + Path.socialToken
   
    static let member = Path.domain + Path.member

    /// 토큰 재발급
    static let token = Path.domain + Path.member + Path.token + Path.socialToken
    
    // MainView
    /// 날씨 간략 정보
    static let realtimeForecast = Path.domain + Path.forecast
    
    // SurvayView
    /// 사용자 서베이 답변 여부
    static let precheck = Path.domain + Path.survey + Path.precheck
    
    /// 서베이 결과(Graph)
    static let survey = Path.domain + Path.survey
    
    /// 사용자 서베이 답변 상태
    static let userSurvy = Path.domain + Path.survey + "/" + Path.member
    
    /// 서베이 답변 목록
    static let surveyAnswer = Path.domain + Path.survey + Path.answers
    
    /// 한줄평
    static let comment = Path.domain + Path.comment + "?"
    
    /// 한줄평 등록
    static let registerComment = Path.domain + Path.comment
    
    /// 지역 변경
    static let chageRegion = Path.domain + Path.chageRegion
    
    /// 날씨 업데이트
    static let forecastUpdate = Path.domain + Path.weather + Path.update

    /// 현재 날씨
    static let forecast = Path.domain + Path.weather
    
    /// 시간대별 날씨
    static let houlryForecast = Path.domain + Path.weather + Path.houlry
    
    /// 일별 날씨
    static let dailyForecast = Path.domain + Path.weather + Path.daily
    
    /// 미세먼지
    static let dustForecast = Path.domain + Path.weather + Path.airdust
}
