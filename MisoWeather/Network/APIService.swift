//
//  APIService.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/19.
//
import UIKit

protocol URLSessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    private let closure: () -> Void
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    func resume() {
        closure()
    }
}

class URLSessionMock: URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTaskProtocol {
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
