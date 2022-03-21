//
//  NetworkManager.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/04.
//

import Foundation

public enum Result<Success, Failure: Error > {
    case success(Success)
    case failure(Failure)
}

class NetworkManager {
    
    var dataTasks = [URLSessionTask]()
    
    let sucessRange = 200..<300
    let session: URLSession = URLSession.shared
    
    // MARK: - GET
    func getfetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return completion(.failure(.data))
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return completion(.failure(.statusCode))
            }
            guard self.sucessRange.contains(statusCode) else {
                return completion(.failure(.error))
            }
            if let model = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(model))
            } else {
                completion(.failure(.decodingJSON))
            }
        }
        dataTask.resume()
    }
    
    func headerTokenRequsetData<T: Decodable>(url: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return completion(.failure(.data))
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return completion(.failure(.statusCode))
            }
            guard self.sucessRange.contains(statusCode) else {
                return completion(.failure(.error))
            }
            if let model = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(model))
            } else {
                completion(.failure(.decodingJSON))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - POST
    func postRegister<T: Decodable>(url: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return completion(.failure(.data))
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return completion(.failure(.statusCode))
            }
            
            guard self.sucessRange.contains(statusCode) else {
                return completion(.failure(.error))
            }
            if let httpResponse = response as? HTTPURLResponse {
                if let serverToken =  httpResponse.value(forHTTPHeaderField: "serverToken") {
                    completion(.success(serverToken as! T))
                } else {
                    if let resultString = String(data: data, encoding: .utf8) {
                        debugPrint("result String: \(resultString)")
                    }
                    debugPrint("postRegister error = \(httpResponse)")
                    completion(.failure(.error))
                }
            }
        }
        dataTask.resume()
    }
    
    // MARK: - DELETE

    func deleteUser(url: URLRequest, completion: @escaping (Result<String, APIError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                completion(.success("성공"))
            } else {
                completion(.failure(.error))
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return completion(.failure(.statusCode))
            }
            guard self.sucessRange.contains(statusCode) else {
                return completion(.failure(.error))
            }
        }
        dataTask.resume()
    }
}
