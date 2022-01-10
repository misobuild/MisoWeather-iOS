//
//  RegionCollectionViewCell.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/06.
//

import SnapKit
import UIKit

final class RegionCollectionViewCell: UICollectionViewCell {
    
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 18
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                regionLabel.textColor = .white
                regionLabel.layer.borderColor = UIColor.white.cgColor
                regionLabel.layer.masksToBounds = true
                regionLabel.backgroundColor = .black
            } else {
                regionLabel.textColor = .black
                regionLabel.layer.borderColor = UIColor.black.cgColor
                regionLabel.backgroundColor = .white
            }
        }
    }
    
    func setup(region: String) {
        regionLabel.text = region
        
        setupView()
    }
}

private extension RegionCollectionViewCell{
    
    // MARK: - Layout
    func setupView() {
        contentView.addSubview(regionLabel)
        
        regionLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


