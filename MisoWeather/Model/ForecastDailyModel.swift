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
}

struct DailyForecastList: Decodable {
    let createdAt: String
    let forecastTime: String
    let maxTemperature: Int
    let minTemperature: Int
    let weather: String
}
