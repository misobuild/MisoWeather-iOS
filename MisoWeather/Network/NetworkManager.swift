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
    
    func fetchModel<T: Decodable>(url: URL, completion: @escaping (Result<T,APIError>) -> Void) {
         
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
        dataTasks.append(dataTask)
    }
}
