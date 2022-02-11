//
//  SurveyViewModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/11.
//

import Foundation

final class SurveyViewModel {
    
    private var surveyData: [SurveyList] = []
    private var userSurveyData: [UserSurveyList] = []
    private var surveyAnswerData: [SurveyAnswerList] = []
    
    var surveyInfo: [SurveyList] {
        self.surveyData
    }
    
    var userSurveyInfo: [UserSurveyList] {
        self.userSurveyData
    }
    
    var surveyAnswerInfo: [SurveyAnswerList] {
        self.surveyAnswerData
    }
    
    // MARK: - Survey
    
    func getSurveyData(completion: @escaping () -> Void) {
        let networkManager = NetworkManager()
        let urlString = URL.survey
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        if let url =  URL(string: encodedString) {
            networkManager.getfetchData(url: url) {(result: Result<SurveyModel, APIError>) in
                switch result {
                case .success(let model):
                    self.surveyData = model.data.responseList
                    completion()
                    
                case .failure(let error):
                    debugPrint("getSurveyData error = \(error)")
                }
            }
        }
    }
    
    func getUserSurveyData(completion: @escaping () -> Void) {
        let token = TokenUtils()
        guard let serverToken =  token.read("misoWeather", account: "serverToken") else {return}
        
        guard let url = URL(string: URL.userSurvy) else {return}
        var requeset: URLRequest = URLRequest(url: url)
        requeset.httpMethod = URLMethod.get
        requeset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requeset.addValue(serverToken, forHTTPHeaderField: "serverToken")
        
        let networkManager = NetworkManager()
        networkManager.headerTokenRequsetData(url: requeset) {(result: Result<UserSurveyModel, APIError>) in
            switch result {
            case .success(let model):
                self.userSurveyData = model.data.responseList
                completion()
                
            case .failure(let error):
                debugPrint("getSurveyData error = \(error)")
            }
        }
    }
    
    func getSurveyAnswerData(id: Int, completion: @escaping () -> Void) {
        let token = TokenUtils()
        guard let serverToken =  token.read("misoWeather", account: "serverToken") else {return}
        
        guard let url = URL(string: URL.surveyAnswer + "\(id)") else {return}
        var requeset: URLRequest = URLRequest(url: url)
        requeset.httpMethod = URLMethod.get
        requeset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requeset.addValue(serverToken, forHTTPHeaderField: "serverToken")
        
        let networkManager = NetworkManager()
        networkManager.headerTokenRequsetData(url: requeset) {(result: Result<SurveyAnswerModel, APIError>) in
            switch result {
            case .success(let model):
                self.surveyAnswerData = model.data.responseList
                completion()
                
            case .failure(let error):
                debugPrint("getSurveyData error = \(error)")
            }
        }
    }
}
