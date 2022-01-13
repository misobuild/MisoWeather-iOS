//
//  Repository.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/14.
//

import Foundation

class Repository {
    
    let allRegion = ["서울", "경기", "인천", "대전", "세종", "충북", "충남", "광주", "전북", "전남", "대구", "부산", "울산", "경북", "경남", "강원", "제주"]
    
    func getData(onCompleted: @escaping ([String]) -> Void) {
        onCompleted(allRegion)
    }
}
