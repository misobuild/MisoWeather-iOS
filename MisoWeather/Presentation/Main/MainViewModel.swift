//
//  MainViewModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/05.
//
import Foundation

final class MainViewModel {
    
    private var memberData: MemberModel?
    private var forecastData: ForecastData?
    private var location: String = ""
    private var commentData: [CommentList] = []
    private var surveyData: [SurveyList] = []

    var memberInfo: MemberModel? {
        self.memberData
    }
    
    var forecastInfo: ForecastData? {
        self.forecastData
    }
    
    var locationInfo: String {
        self.location
    }
    
    var commenttInfo: [CommentList] {
        self.commentData
    }
    
    var surveyInfo: [SurveyList] {
        self.surveyData
    }
    
    func getMemberData(completion: @escaping () -> Void) {
        let networkManager = NetworkManager()
        
        let token = TokenUtils()
        guard let serverToken =  token.read("misoWeather", account: "serverToken") else {return}
        
        guard let url = URL(string: URL.member) else {return}
        var requeset: URLRequest = URLRequest(url: url)
        requeset.httpMethod = URLMethod.get
        requeset.addValue(serverToken, forHTTPHeaderField: "serverToken")
        
        networkManager.headerTokenRequsetData(url: requeset) {(result: Result<MemberModel, APIError>) in
            switch result {
            case .success(let model):
                self.memberData = model
                UserDefaults.standard.set(model.data.regionId, forKey: "regionID")
                UserDefaults.standard.set(model.data.nickname, forKey: "nickName")
                UserDefaults.standard.set(model.data.regionName, forKey: "regionName")
                UserDefaults.standard.set(model.data.regionName, forKey: "selectRegionName")
                completion()
                
            case .failure(let error):
                debugPrint("getMemberData error = \(error)")
                completion()
            }
        }
    }
    
    func getForecastUpdate(completion: @escaping () -> Void) {
        let networkManager = NetworkManager()

        guard let regionID = UserDefaults.standard.string(forKey: "regionID") else {return}
        
        if let url = URL(string: URL.forecastUpdate + regionID) {
            networkManager.getfetchData(url: url) {(result: Result<StatusModel, APIError>)  in
                switch result {
                case .success:
                    completion()
                case .failure(let error):
                    debugPrint("getForecastUpdate error = \(error)")
                }
            }
        }
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
                        text.append(" " + model.data.region.midScale)
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
    
    func getSurveyData(completion: @escaping () -> Void) {
        let networkManager = NetworkManager()
        let urlString = URL.survey
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        if let url =  URL(string: encodedString) {
            networkManager.getfetchData(url: url) {(result: Result<SurveyModel, APIError>) in
                switch result {
                case .success(let model):
                    self.surveyData = model.data.responseList
                    completion()
                    
                case .failure(let error):
                    debugPrint("getSurveyData error = \(error)")
                }
            }
        }
    }
    
    func getCommentData(completion: @escaping () -> Void) {
        let networkManager = NetworkManager()
        let urlString = URL.comment + Path.size + "5"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        if let url =  URL(string: encodedString) {
            networkManager.getfetchData(url: url) {(result: Result<CommentModel, APIError>) in
                switch result {
                case .success(let model):
                    self.commentData = model.data.commentList
                    completion()
                    
                case .failure(let error):
                    debugPrint("getCommentData error = \(error)")
                }
            }
        }
    }
}
