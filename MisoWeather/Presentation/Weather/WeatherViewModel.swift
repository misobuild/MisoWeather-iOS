//
//  WeatherViewModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/03/19.
//

import Foundation

final class WeatherViewModel {
    
    private var location: String = ""
    private var forecastData: ForecastData?
    private var houlryData: ForecastHourlyModel?
    private var dailyData: ForecastDailyModel?
    private var dustData: Airdust?
    
    var locationInfo: String {
        self.location
    }
    
    var forecastInfo: ForecastData? {
        self.forecastData
    }
    
    var houlryInfo: ForecastHourlyModel? {
        self.houlryData
    }
    
    var dailyInfo: ForecastDailyModel? {
        self.dailyData
    }
    
    var dustInfo: Airdust? {
        self.dustData
    }
    
    func getRealtimeForecast(completion: @escaping () -> Void) {
        let networkManager = NetworkManager()
        guard let regionID = UserDefaults.standard.string(forKey: "regionID") else {return}
    
        if let url =  URL(string: URL.forecast + regionID) {
            networkManager.getfetchData(url: url) {(result: Result<ForecastModel, APIError>) in
                switch result {
                case .success(let model):
                    self.forecastData = model.data
                    
                    var text = model.data.region.bigScale
                    if model.data.region.midScale != "선택 안 함" {
                        if model.data.region.midScale != text {
                            text.append(" " + model.data.region.midScale)
                        }
                        if model.data.region.smallScale != "선택 안 함" {
                            text.append(" " + model.data.region.smallScale)
                        }
                    }
                    self.location = text
                    completion( )
                    
                case .failure(let error):
                    debugPrint("getRealtimeForecast error = \(error)")
                }
            }
        }
    }
    
    func getHourlyForecast(completion: @escaping () -> Void) {
        guard let regionID = UserDefaults.standard.string(forKey: "regionID") else {return}
        let networkManager = NetworkManager()
        if let url =  URL(string: URL.houlryForecast + regionID) {
            networkManager.getfetchData(url: url) {(result: Result<ForecastHourlyModel, APIError>) in
                switch result {
                case .success(let model):
                    self.houlryData = model
                    completion()
                    
                case .failure(let error):
                    debugPrint("getHourlyForecast = \(error)")
                }
            }
        }
    }
    
    func getDailyForecast(completion: @escaping () -> Void) {
        guard let regionID = UserDefaults.standard.string(forKey: "regionID") else {return}
        let networkManager = NetworkManager()
        if let url =  URL(string: URL.dailyForecast + regionID) {
            networkManager.getfetchData(url: url) {(result: Result<ForecastDailyModel, APIError>) in
                switch result {
                case .success(let model):
                    self.dailyData = model
                    completion()
                    
                case .failure(let error):
                    debugPrint("getDailyForecast = \(error)")
                }
            }
        }
    }
    
    func getAirDust(completion: @escaping () -> Void) {
        guard let regionID = UserDefaults.standard.string(forKey: "regionID") else {return}
        let networkManager = NetworkManager()
        if let url =  URL(string: URL.dustForecast + regionID) {
            networkManager.getfetchData(url: url) {(result: Result<ForecastAirdustModel, APIError>) in
                switch result {
                case .success(let model):
                    self.dustData = model.data
                    completion()
                    
                case .failure(let error):
                    debugPrint("getAirDust = \(error)")
                }
            }
        }
    }
}
