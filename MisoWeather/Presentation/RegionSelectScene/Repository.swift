//
//  Repository.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/14.
//

import Foundation

class Repository {
    
    let requestRegionList = ["서울특별시", "경기도", "인천광역시", "대전광역시", "세종특별자치시", "충청북도", "충청남도", "광주광역시", "전라북도", "전라남도", "대구광역시", "부산광역시", "울산광역시", "경상북도", "경상남도", "강원도", "제주도"]
    
    func getData(onCompleted: @escaping ([String]) -> Void) {
        onCompleted(requestRegionList)
    }
}
