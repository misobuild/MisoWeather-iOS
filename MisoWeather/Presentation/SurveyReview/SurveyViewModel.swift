//
//  SurveyViewModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/08.
//

import Foundation

final class SurveyViewModel {
    
    private var placeHolder =
                    """
                오늘 날씨에 대한
                \(UserDefaults.standard.string(forKey: "nickName")!)의 느낌은 어떠신가요?
                """
    private var surveyData: [SurveyList] = []
    private var commentData: [CommentList] = []
    private var postData = ""

    var surveyInfo: [SurveyList] {
        self.surveyData
    }
    var placeHolderText: String {
        self.placeHolder
    }
    var commenttInfo: [CommentList] {
        self.commentData
    }
    var commnetText: String {
        self.postData
    }
    
    func setCommentData(text: String) {
        self.postData = text
    }
    
    func postCommentData(completion: @escaping () -> Void) {
        
        let token = TokenUtils()
        guard let serverToken =  token.read("misoWeather", account: "serverToken") else {return}
        
        let body: [String: Any] = [
            "content": postData
        ]
        
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return}
        
        guard let url = URL(string: URL.registerComment) else {return}
        var requeset: URLRequest = URLRequest(url: url)
        requeset.httpMethod = URLMethod.post
        requeset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requeset.addValue(serverToken, forHTTPHeaderField: "serverToken")
        requeset.httpBody = jsonBody
        
        let networkManager = NetworkManager()
        networkManager.getRequsetData(url: requeset) {(result: Result<CommentModel, APIError>) in
            switch result {
            case .success(let model):
                print(model)
                completion()
                
            case .failure(let error):
                debugPrint("error = \(error)")
                completion()
            }
        }
    }
    
    func getCommentData(completion: @escaping () -> Void) {
        let networkManager = NetworkManager()
        let urlString = URL.comment + Path.size + "20"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        if let url =  URL(string: encodedString) {
            networkManager.getfetchData(url: url) {(result: Result<CommentModel, APIError>) in
                switch result {
                case .success(let model):
                    self.commentData = model.data.commentList
                    completion()
                    
                case .failure(let error):
                    debugPrint("error = \(error)")
                }
            }
        }
    }
}
