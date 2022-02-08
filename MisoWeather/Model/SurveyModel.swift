//
//  SurveyModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/08.
//

struct SurveyModel: Decodable {
    let status: String
    let message: String
    let data: ResponseList
}

struct ResponseList: Decodable {
    let responseList: [Survey]
}

struct Survey: Decodable {
    let keyList: [String?]
    let valueList: [Int]
    let surveyId: Int
}

