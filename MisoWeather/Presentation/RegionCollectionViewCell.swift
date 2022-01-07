//
//  RegionCollectionViewCell.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/06.
//

import SnapKit
import UIKit

final class RegionCollectionViewCell: UICollectionViewCell {
    
    var regionButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        regionButton = UIButton(type: .custom)
        regionButton.scalesLargeContentImage = true
        regionButton.sizeToFit()
        regionButton.contentMode = .scaleAspectFit
        
        regionButton.setImage(UIImage(named: "busanButton"), for: .normal)
        //regionButton.isSelected = true
        
        contentView.addSubview(regionButton)
        regionButton.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
