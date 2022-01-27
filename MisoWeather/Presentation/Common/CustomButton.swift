//
//  CustomButton.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/18.
//

import UIKit

final class CustomButton: UIButton {
    
    public enum CSButtonType {
        case next
        case register
        case addRegion
        case survey
        case changeRegion
        case post
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.tag == 1 {
                backgroundColor = isHighlighted ? .backgroundColor : .white
            } else {
                backgroundColor = isHighlighted ? .selectButtonColor : .mainColor
            }
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
      
        case .post:
            self.setTitle("공유하기", for: .normal)
            self.titleLabel?.font = .systemFont(ofSize: 11, weight: .bold)
            self.layer.cornerRadius = 12.5
            
        case .changeRegion:
            self.tag = 1
            self.backgroundColor = .white
            self.layer.cornerRadius = 15
            self.layer.masksToBounds = true
            self.setTitleColor(.mainColor, for: .normal)
            self.setTitle("서울", for: .normal)
            self.titleLabel?.font = .systemFont(ofSize: 16.0)
            self.layer.cornerRadius = 10
            self.setImage(UIImage(named: "chevron")?.withTintColor(UIColor.mainColor!), for: .normal)
            self.semanticContentAttribute = .forceRightToLeft
            self.imageEdgeInsets = .init(top: 0, left: 15, bottom: 0, right: -15)
            self.titleEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: -10)
            self.imageView?.tintColor = .mainColor
        }
    }
}
