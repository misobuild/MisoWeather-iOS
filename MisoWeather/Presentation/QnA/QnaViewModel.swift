//
//  QnaViewModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/11.
//

import Foundation

final class QnaViewModel {
    
    /// 서베이 답변 입력
    func postSurveyAnswerData(answerID: Int, surveyID: Int, completion: @escaping () -> Void) {
        
        let token = TokenUtils()
        guard let serverToken =  token.read("misoWeather", account: "serverToken") else {return}
        guard let regionName = UserDefaults.standard.string(forKey: "regionName") else {return}
        UserDefaults.standard.set(regionName, forKey: "selectRegionName")
        
        let body: [String: Any] = [
            "answerId": answerID,
            "shortBigScale": regionName,
            "surveyId": surveyID
        ]
        
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return}
        
        guard let url = URL(string: URL.survey) else {return}
        var requeset: URLRequest = URLRequest(url: url)
        requeset.httpMethod = URLMethod.post
        requeset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requeset.addValue(serverToken, forHTTPHeaderField: "serverToken")
        requeset.httpBody = jsonBody
        
        let networkManager = NetworkManager()
        networkManager.headerTokenRequsetData(url: requeset) {(result: Result<SurveyResultModel, APIError>) in
            switch result {
            case .success:
                completion()
                
            case .failure(let error):
                debugPrint("postSurveyAnswerData error = \(error)")
                completion()
            }
        }
    }

}
