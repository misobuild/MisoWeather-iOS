//
//  CurrentTempModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/07.
//

struct CurrentTempModel: Decodable {
    let data: Info
    let message: String
    let status: String
}

struct Info: Decodable {
    let region: Region
    let forecast: Forecast
    let forecastInfo: ForecastInfo
}

struct Forecast: Decodable {
    let hour: String
    let sky: String
    let temperature: String
}

struct ForecastInfo: Decodable {
    let temperatureMax: String
    let temperatureMin: String
}

struct Region: Decodable {
    let bigScale: String
    let midScale: String
    let smallScale: String
}
