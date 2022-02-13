//
//  SurveyResultModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/11.
//

struct SurveyResultModel: Decodable {
    let status: String
    let message: String
    let data: SurveyResult
}

struct SurveyResult: Decodable {
    let surveyDescription: String
    let answer: String
}
