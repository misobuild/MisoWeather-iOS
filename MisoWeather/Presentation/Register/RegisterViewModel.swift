//
//  RegisterViewModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/05.
//

import Foundation

final class RegisterViewModel {
    
    private var memberData: MemberModel?
    
    var memberInfo: MemberModel? {
        self.memberData
    }
    
    func getIsExistUser(completion: @escaping (String) -> Void) {
        let networkManager = NetworkManager()
        let token = TokenUtils()
        
        let loginType = UserDefaults.standard.string(forKey: "loginType")
        var urlString = ""
        
        print("login Type = \(loginType)")
        
        if loginType == "kakao" {
            guard let id = token.read("kakao", account: "userID") else {return}
            urlString = URL.existence + id + Path.socialType + "kakao"
            print(urlString)
        }
        
        if loginType == "apple" {
            guard let id = token.read("apple", account: "user") else {return}
            urlString = URL.existence + id + Path.socialType + "apple"
            print(urlString)
        }
        
        if let url =  URL(string: urlString) {
            networkManager.getfetchData(url: url) {(result: Result<ExistModel, APIError>) in
                switch result {
                case .success(let model):
                    print(model)
                    completion(String(model.data))
                    
                case .failure(let error):
                    debugPrint("getIsExistUser error = \(error)")
                }
            }
        }
    }
    
    func postToken(completion: @escaping (String) -> Void) {
        print("postToken")
        let networkManager = NetworkManager()
        let token = TokenUtils()

        let loginType = UserDefaults.standard.string(forKey: "loginType")
        
        var urlString = URL.token
        var body: [String: Any] = [:]
        
        if loginType == "kakao" {
            guard let accessToken = token.read("kakao", account: "accessToken") else {return}
            UserDefaults.standard.set("kakao", forKey: "loginType")
            let userID = token.read("kakao", account: "userID")
            body = [
                "socialId": userID!,
                "socialType": "kakao"
            ]
            urlString += accessToken
        } else {
            guard let accessToken = token.read("apple", account: "identityToken") else {return}
            UserDefaults.standard.set("apple", forKey: "loginType")
            let userID = token.read("apple", account: "user")
            body = [
                "socialId": userID!,
                "socialType": "apple"
            ]
            urlString += accessToken
        }
        print(urlString)
        
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: encodedString) else {return}
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return}
        
        var requeset: URLRequest = URLRequest(url: url)
        requeset.httpMethod = URLMethod.post
        requeset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requeset.httpBody = jsonBody
        
        networkManager.postRegister(url: requeset) {(result: Result<String, APIError>) in
            switch result {
            case .success(let serverToken):
                print("serverToken: \(serverToken)")
                token.create("misoWeather", account: "serverToken", value: serverToken)
                completion(String(""))
                
            case .failure(let error):
                debugPrint("getIsExistUser error = \(error)")
            }
        }
    }
}
