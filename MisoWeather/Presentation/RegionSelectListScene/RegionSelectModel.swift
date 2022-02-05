//
//  RegionSelectModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/04.
//

import Foundation

final class RegionSelectModel {
    
    private var midleRegionData: RegionModel?
    private var recivedNickName: NicknameModel.Data = NicknameModel.Data(nickname: "", emoji: "")
    
    var midleRegionList: [RegionList] {
        (self.midleRegionData?.data.regionList)!
    }

    var reciveNickname: NicknameModel.Data {
        self.recivedNickName
    }
    
    func fetchMiddleRegionData(urlString: String, completion: @escaping () -> Void) {
        
        let networkManager = NetworkManager()
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        if let url =  URL(string: encodedString) {
            networkManager.getfetchData(url: url) {(result: Result<RegionModel, APIError>) in
                switch result {
                case .success(let model):
                    self.midleRegionData = model
                    completion()
                    
                case .failure(let error):
                    debugPrint("error = \(error)")
                }
            }
        }
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
}
