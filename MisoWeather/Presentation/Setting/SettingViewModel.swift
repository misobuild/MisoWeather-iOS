//
//  SettingViewModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/05.
//

import Foundation

final class SettingViewModel {
    
    private var memberData: MemberModel?
    
    var memberInfo: MemberModel? {
        self.memberData
    }
    
    var settingList: [String] {
        ["🔑  로그아웃", "📱  앱 버전", "💔  계정 삭제"]
    }
    
    func getMemberData(completion: @escaping () -> Void) {
        
        let networkManager = NetworkManager()
        
        let token = TokenUtils()
        guard let serverToken =  token.read("misoWeather", account: "serverToken") else {return}
        
        guard let url = URL(string: URL.member) else {return}
        var requeset: URLRequest = URLRequest(url: url)
        requeset.httpMethod = URLMethod.get
        requeset.addValue(serverToken, forHTTPHeaderField: "serverToken")
        
        networkManager.headerTokenRequsetData(url: requeset) {(result: Result<MemberModel, APIError>) in
            switch result {
            case .success(let model):
                self.memberData = model
                completion()
                
            case .failure(let error):
                debugPrint("error = \(error)")
                completion()
            }
        }
    }
    
    func deleteUser(completion: @escaping (Result<String, APIError>) -> Void) {
        print("deleteUser 실행")
        
        let token = TokenUtils()
        var userID = ""
        
        let loginType = UserDefaults.standard.string(forKey: "loginType")
        
        guard let serverToken = token.read("misoWeather", account: "serverToken") else {return}
        
        if loginType == "kakao" {
            userID = token.read("kakao", account: "userID") ?? ""
        }
        if loginType == "apple"{
            userID = token.read("apple", account: "user") ?? ""
        }
        
        let body: [String: Any] = [
            "socialId": userID,
            "socialType": loginType!
        ]
        
        let urlString = URL.member
        
        print(body)
        
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: encodedString) else {return}
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return}
        
        var requeset: URLRequest = URLRequest(url: url)
        requeset.httpMethod = URLMethod.delete
        requeset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requeset.addValue(serverToken, forHTTPHeaderField: "serverToken")
        requeset.httpBody = jsonBody
        
        print(urlString)
        
        let networkManager = NetworkManager()
        networkManager.deleteUser(url: requeset) {(result: Result<String, APIError>) in
            switch result {
            case .success(let message):
                print("유저삭제: \(message)")

                if loginType == "kakao" {
                    userID = token.read("kakao", account: "userID") ?? ""
                    token.delete("kakao", account: "accessToken")
                    token.delete("kakao", account: "userID")
                }
                if loginType == "apple"{
                    userID = token.read("apple", account: "user") ?? ""
                    token.delete("apple", account: "identityToken")
                    token.delete("apple", account: "user")
                }
                token.delete("misoWeather", account: "serverToken")
                completion(.success(""))
                
            case .failure(let error):
                print("deleteUser error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
