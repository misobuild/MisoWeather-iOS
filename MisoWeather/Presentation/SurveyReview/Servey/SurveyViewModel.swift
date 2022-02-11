//
//  SurveyViewModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/11.
//

import Foundation

final class SurveyViewModel {
    
    private var surveyData: [SurveyList] = []

    var surveyInfo: [SurveyList] {
        self.surveyData
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
}
