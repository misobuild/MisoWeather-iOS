//
//  SurveyViewModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/08.
//

import Foundation

final class SurveyReviewViewModel {
    
    private var row = 15
    private var placeHolder =
                    """
                오늘 날씨에 대한
                \(UserDefaults.standard.string(forKey: "nickName") ?? "")님의 느낌은 어떠신가요?
                """
    private var surveyData: [SurveyList] = []
    private var commentData: [CommentList] = []
    private var postData = ""
    private var lastID = 0
    private var hasNext = true

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
    var isMoreData: Bool {
        self.hasNext
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
        networkManager.headerTokenRequsetData(url: requeset) {(result: Result<StatusModel, APIError>) in
            switch result {
            case .success:
                completion()
                
            case .failure(let error):
                debugPrint("PostCommentData error = \(error)")
                completion()
            }
        }
    }
    
    func getCommentData(completion: @escaping () -> Void) {
        let networkManager = NetworkManager()
        let urlString = URL.comment + Path.size + "\(row)"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        if let url =  URL(string: encodedString) {
            networkManager.getfetchData(url: url) {(result: Result<CommentModel, APIError>) in
                switch result {
                case .success(let model):
                    self.commentData = model.data.commentList
                    self.lastID = model.data.commentList.last!.id
                    self.hasNext = model.data.hasNext
                    
                    completion()
                    
                case .failure(let error):
                    debugPrint("getCommentData error = \(error)")
                }
            }
        }
    }
    
    func getMoreCommentData(completion: @escaping () -> Void) {
        let networkManager = NetworkManager()
        let urlString = URL.comment + Path.commnetId + "\(lastID)&" + Path.size + "\(row)"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        if let url =  URL(string: encodedString) {
            networkManager.getfetchData(url: url) {(result: Result<CommentModel, APIError>) in
                switch result {
                case .success(let model):
                    self.commentData.append(contentsOf: model.data.commentList)
                    self.lastID = model.data.commentList.last!.id
                    self.hasNext = model.data.hasNext
                    completion()
                    
                case .failure(let error):
                    debugPrint("getCommentData error = \(error)")
                }
            }
        }
    }
}
