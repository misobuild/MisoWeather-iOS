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
