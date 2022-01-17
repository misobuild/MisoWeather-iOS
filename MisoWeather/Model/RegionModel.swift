//
//  RegionModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/15.
//

struct RegionModel: Codable {
    let httpStatus: String
    let message: String
    let data: Data
    
    struct Data: Codable {
        let regionList: [RegionList]
    }
}

struct RegionList: Codable {
    let id: Int
    let bigScale: String
    let midScale: String
    let smallScale: String
}
