//
//  RegionSelectViewModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/14.
//

import UIKit

class RegionSelectViewModel: ObservableVMProtocol {
    
    typealias T = String
    
    let repository = Repository()
    
    let regionList = ["서울", "경기", "인천", "대전", "세종", "충북", "충남", "광주", "전북", "전남", "대구", "부산", "울산", "경북", "경남", "강원", "제주"]
    
    func fetchData() {
        repository.getData { reponse in
            let observable = Observable(reponse)
            self.storage = observable
        }
    }
    
    func setError(_ message: String) {
        
    }
    
    var storage: Observable<[String]> = Observable([])
    
    var errorMessage: Observable<String?> = Observable(nil)
    
    var error: Observable<Bool> = Observable(false)
}
