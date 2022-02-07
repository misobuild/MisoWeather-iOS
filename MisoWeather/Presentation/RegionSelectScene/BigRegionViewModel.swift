//
//  BigRegionModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/04.
//

import Foundation

protocol RegionSendDelegate: AnyObject {
    func sendData() -> [RegionList]
}

final class BigRegionViewModel {
    
    private var midleRegionData: RegionModel?
    
    var midleRegionList: [RegionList] {
        (self.midleRegionData?.data.regionList)!
    }
    
    func fetchRegionData(region: String, completion: @escaping () -> Void) {
        
        let networkManager = NetworkManager()
        let urlString = URL.region + region
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
}
