//
//  UserSurveyModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/11.
//

struct UserSurveyModel: Decodable {
    let status: String
    let message: String
    let data: UserSurveyData
}

struct UserSurveyData: Decodable {
    let responseList: [UserSurveyList]
}

struct UserSurveyList: Decodable {
    let surveyId: Int
    let memberAnswer: String?
    let answered: Bool
}
