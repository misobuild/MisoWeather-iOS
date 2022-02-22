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
        
        if loginType == "kakao" {
            guard let id = token.read("kakao", account: "userID") else {return}
            urlString = URL.existence + id + Path.socialType + "kakao"
        } else {
            guard let id = token.read("apple", account: "user") else {return}
            urlString = URL.existence + id + Path.socialType + "apple"
        }
       
        if let url =  URL(string: urlString) {
            networkManager.getfetchData(url: url) {(result: Result<ExistModel, APIError>) in
                switch result {
                case .success(let model):
                    completion(String(model.data))
                    
                case .failure(let error):
                    debugPrint("error = \(error)")
                }
            }
        }
    }
}
