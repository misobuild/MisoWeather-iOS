//
//  ForecastModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/03/18.
//

struct ForecastModel: Decodable {
    let message: String
    let status: String
    let data: ForecastData
}

struct ForecastData: Decodable {
    let region: RegionList
    let temperature: Double
    let temperatureMax: Double
    let temperatureMin: Double
    let weather: String
    let windSpeed: Double
    let windSpeedIcon: String
    let humidity: Int
    let humidityIcon: String
    let windSpeedComment: String
}
