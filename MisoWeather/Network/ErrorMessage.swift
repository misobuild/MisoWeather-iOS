//
//  ErrorMessage.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/04.
//

enum APIError: Error {
    case data
    case decodingJSON
    case error
    case statusCode
}
