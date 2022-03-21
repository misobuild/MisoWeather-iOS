//
//  MemberModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/05.
//

struct MemberModel: Decodable {
    let status: String
    let message: String
    let data: Member
}

struct Member: Decodable {
    let nickname: String
    let emoji: String
    let regionId: Int
    let regionName: String
}
