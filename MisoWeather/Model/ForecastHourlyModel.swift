//
//  ForecastHourlyModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/03/18.
//

struct ForecastHourlyModel: Decodable {
    let message: String
    let status: String
    let data: HourlyData
}

struct HourlyData: Decodable {
    let region: RegionList
    let hourlyForecastList: [HourlyForecastList]
}

struct HourlyForecastList: Decodable {
    let createdAt: String
    let forecastTime: String
    let temperature: Double
    let weather: String
}
