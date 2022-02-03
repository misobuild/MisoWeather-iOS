//
//  RegionButton.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/24.
//

import UIKit
import SnapKit

final class RegionButton: UIView {
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "location")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .mainColor
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var regionButton: CustomButton = {
        let button = CustomButton(type: .changeRegion)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
}

extension RegionButton {
    // MARK: - Layout
    private func setupView() {
        [regionButton, image].forEach {addSubview($0)}
        
        image.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(58)
            $0.width.equalTo(18)
            $0.height.equalTo(18)
        }
        regionButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.width.equalTo(80)
        }
    }
}
