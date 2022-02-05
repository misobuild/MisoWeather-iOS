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
    
    func token(completion: @escaping (Result<String, APIError>) -> Void) {
        print("token() 실행")
        let token = TokenUtils()
        guard let accessToken = token.read("kakao", account: "accessToken") else {return}
        let userID = token.read("kakao", account: "userID")
        
        let body: [String: Any] = [
            "socialId": userID!,
            "socialType": "kakao"
        ]
        
        let urlString = URL.token + accessToken
        print(urlString)
        
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: encodedString) else {return}
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return}
        
        var requeset: URLRequest = URLRequest(url: url)
        requeset.httpMethod = URLMethod.post
        requeset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requeset.httpBody = jsonBody
        
        let networkManager = NetworkManager()
        networkManager.postRegister(url: requeset) {(result: Result<String, APIError>) in
            print(accessToken)
            print(result)

            
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
