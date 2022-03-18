//
//  SurveyAnswerModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/11.
//

struct SurveyAnswerModel: Decodable {
    let status: String
    let message: String
    let data: SurveyAnswerData
}

struct SurveyAnswerData: Decodable {
    let responseList: [SurveyAnswerList]
}

struct SurveyAnswerList: Decodable {
    let answerId: Int
    let answerDescription: String
    let answer: String
    let surveyId: Int
    let surveyDescription: String
    let surveyTitle: String
}
