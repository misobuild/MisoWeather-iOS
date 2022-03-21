//
//  Observables.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/14.
//

import UIKit

class Observable<T> {
    // 3. 호출되면, 2번에서 받은 값을 전달
    private var listener: ((T) -> Void)?
    
    // 2. 값이 set되면, listener에 해당 값을 전달
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    // 1.초기화 함수를 통해서 값을 입력받고, value에 저장
    init(_ value: T) {
        self.value = value
    }
    
    // 4. 다른곳에서 bind 라는 메소드를 호출하면
    // value에 저장했던 값을 전달해주고
    // 전달받은 clouser 표현식을 listener에 할당
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
