//
//  NicknameModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/17.
//

struct NicknameModel: Codable {
    let status: String
    let message: String
    let data: Data
    
    struct Data: Codable {
        let nickname: String
        let emoji: String
    }
}
