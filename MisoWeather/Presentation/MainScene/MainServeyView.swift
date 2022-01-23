//
//  MainServeyView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/22.
//

import UIKit
import SnapKit

final class MainServeyView: UIView {
    
    // MARK: - subviews
    lazy var chart1View: ChartView = {
        let view = ChartView()
        view.titleLabel.text = "숏패딩"
        view.percentLabel.text = "29%"
        view.rangkLabel.text = "2"
        return view
    }()
    
    lazy var chart2View: ChartView = {
        let view = ChartView()
        view.titleLabel.text = "롱패딩"
        view.percentLabel.text = "52%"
        view.titleLabel.textColor = .mainColor
        view.percentLabel.textColor = .mainColor
        view.titleLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
        view.percentLabel.font = .systemFont(ofSize: 12.0, weight: .regular)
        return view
    }()
    
    lazy var chart3View: ChartView = {
        let view = ChartView()
        view.titleLabel.text = "코트"
        view.percentLabel.text = "10%"
        view.rangkLabel.text = "3"
       
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainServeyView {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            chart1View,
            chart2View,
            chart3View
        ].forEach {addSubview($0)}
        
        chart1View.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width * 0.12)
            $0.width.equalTo(57.0)
            $0.height.equalTo(113.0)
            $0.bottom.equalToSuperview()
        }
        chart2View.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width * 0.325)
            $0.width.equalTo(57.0)
            $0.height.equalTo(113.0)
            $0.bottom.equalToSuperview().inset(5.0)
        }
        chart3View.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(width * 0.12)
            $0.width.equalTo(57.0)
            $0.height.equalTo(113.0)
            $0.bottom.equalToSuperview()
        }
    }
}
