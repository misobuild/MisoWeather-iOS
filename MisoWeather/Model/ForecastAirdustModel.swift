//
//  ForecastAirdustModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/03/18.
//

struct ForecastAirdustModel: Decodable {
    let message: String
    let status: String
    let data: Airdust
}

struct Airdust: Decodable {
    let fineDust: Int
    let fineDustIcon: String
    let ultraFineDust: Int
    let ultraFineDustIcon: String
    let fineDustGrade: String
    let ultraFineDustGrade: String
    let bigScale: String
}
