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
    let bigScale: String
    let pm10: Int
    let pm10Grade: String
    let pm25: Int
    let pm25Grade: String
}
