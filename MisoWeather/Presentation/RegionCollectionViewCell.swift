//
//  RegionCollectionViewCell.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/06.
//

import SnapKit
import UIKit

final class RegionCollectionViewCell: UICollectionViewCell {
    
    var active = ""
    var inactive = ""
    
    private lazy var regionButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                regionButton.image = UIImage(named: active)
            } else {
                regionButton.image = UIImage(named: inactive)
            }
        }
    }
    
    func setup(region: Region) {
        regionButton.image = UIImage(named: region.buttonInactive)
        active = region.buttonActive
        inactive = region.buttonInactive
        setupSubView()
    }
}


private extension RegionCollectionViewCell{
    func setupSubView() {
        contentView.addSubview(regionButton)
        
        regionButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

