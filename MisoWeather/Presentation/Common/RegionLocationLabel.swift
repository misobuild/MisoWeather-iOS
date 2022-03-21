//
//  RegionLocationLabel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/21.
//

import Foundation
import UIKit

class RegionLocationLabel: UIView {
    
    private lazy var location: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "location")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegionLocationLabel {
    
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        [
            location,
            regionLabel
        ].forEach {addSubview($0)}
        
        location.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10.0)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(20.0)
            $0.height.equalTo(20.0)
        }
        
        regionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview()
            $0.leading.equalTo(location.snp.trailing).offset(width * 0.01)
        }
    }
}
