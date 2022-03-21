//
//  ChartView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/22.
//

import UIKit
import SnapKit

final class ChartView: UIView {
    
    // MARK: - subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .textColor
        label.text = "롱패딩"
        return label
    }()
    
    lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .textColor
        label.text = "52%"
        return label
    }()
    
    lazy var rangkLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .buttonTextColor
        label.text = "1"
        return label
    }()
    
   lazy var chartView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView(rankheight: 67)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChartView {
    // MARK: - Layout
    func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height, rankheight: CGFloat) {
        
        [
            titleLabel,
            percentLabel,
            chartView,
            chartView,
            rangkLabel
        ].forEach {addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(3.0)
            $0.height.equalTo(20)
        }
        
        percentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2.0)
        }
        
        chartView.snp.makeConstraints {
            $0.centerX.equalTo(titleLabel)
            $0.top.equalTo(percentLabel.snp.bottom).offset(6.0)
            $0.width.equalTo(57.0)
            $0.height.equalTo(rankheight)
        }
        rangkLabel.snp.makeConstraints {
            $0.centerX.equalTo(titleLabel)
            $0.top.equalTo(chartView).inset(2.0)
        }
    }
}
