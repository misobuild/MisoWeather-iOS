//
//  ObservableVMProtocol.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/14.
//

protocol ObservableVMProtocol {
    associatedtype T
    
    // 데이터 가져옴
    func fetchData()
    
    // 에러 처리
    func setError(_ message: String)
    
    // 원본 데이터
    var storage: Observable<[T]> {get set}
    
    // 에러 메시지
    var errorMessage: Observable<String?> {get set}
    
    // 에러
    var error: Observable<Bool> {get set}
}
