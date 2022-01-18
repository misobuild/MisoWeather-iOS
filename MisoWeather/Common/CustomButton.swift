//
//  CustomButton.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/18.
//

import UIKit

class CustomButton: UIButton {
    
    public enum CSButtonType {
        case next
        case register
        case addRegion
        case survey
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .selectButtonColor : .mainColor
        }
    }
    
    convenience init(type: CSButtonType) {
        self.init()
        self.backgroundColor = .mainColor
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.setTitleColor(.buttonTextColor, for: .normal)
        
        switch type {
        case .next:
            self.setTitle("다음", for: .normal)
            
        case .register:
            self.setTitle("이걸로 결정했어요!", for: .normal)
            
        case .addRegion:
            self.setTitle("+ 새로운 지역 추가", for: .normal)
            
        case .survey:
            self.setTitle("이걸로 할래요!", for: .normal)
        }
    }
}
