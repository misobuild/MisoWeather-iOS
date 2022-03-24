//
//  ForecastDailyModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/03/18.
//

struct ForecastDailyModel: Decodable {
    let message: String
    let status: String
    let data: DailyData
}

struct DailyData: Decodable {
    let region: RegionList
    let dailyForecastList: [DailyForecastList]
    let rain: Int
    let snow: Int
    let pop: Int
    let popIcon: String
}

struct DailyForecastList: Decodable {
    let createdAt: String
    let forecastTime: String
    let maxTemperature: Double
    let minTemperature: Double
    let weather: String
    let pop: Int
    let rain: Int
    let snow: Int
    let popIcon: String
}
