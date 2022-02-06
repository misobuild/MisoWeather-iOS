//
//  NicknameSelectModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/04.
//

import Foundation

final class NicknameSelectModel {
    
    private var recivedNickName: NicknameModel.Data = NicknameModel.Data(nickname: "", emoji: "")

    var reciveNickname: NicknameModel.Data {
        self.recivedNickName
    }
    
    func fetchNicknameData(urlString: String, completion: @escaping () -> Void) {
        
        let networkManager = NetworkManager()
        if let url = URL(string: urlString) {
            networkManager.getfetchData(url: url) {(result: Result<NicknameModel, APIError>) in
                switch result {
                case .success(let model):
                    self.recivedNickName = model.data
                    completion()
                     
                case .failure(let error):
                    debugPrint("error = \(error)")
                }
            }
        }
    }
    
    func register(completion: @escaping (Result<String, APIError>) -> Void) {
        
        let token = TokenUtils()
        guard let accessToken = token.read("kakao", account: "accessToken") else {return}
        let userID = token.read("kakao", account: "userID")
        let regionID = UserDefaults.standard.string(forKey: "regionID")
      
        let body: [String: Any] = [
            "defaultRegionId": regionID!,
            "emoji": recivedNickName.emoji,
            "nickname": recivedNickName.nickname,
            "socialId": userID!,
            "socialType": "kakao"
        ]
        
        let urlString = URL.sinup + accessToken
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: encodedString) else {return}
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return}
        
        var requeset: URLRequest = URLRequest(url: url)
        requeset.httpMethod = URLMethod.post
        requeset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requeset.httpBody = jsonBody
        
        let networkManager = NetworkManager()
        networkManager.postRegister(url: requeset) {(result: Result<String, APIError>) in
            
            switch result {
            case .success(let serverToken):
                print("serverToken: \(serverToken)")
                token.create("misoWeather", account: "serverToken", value: serverToken)
                completion(.success(""))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
