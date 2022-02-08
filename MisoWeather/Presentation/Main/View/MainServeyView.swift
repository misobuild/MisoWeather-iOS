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
    
    private lazy var checkView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "checkCircle")
        return view
    }()
    
    lazy var chart2View: ChartView = {
        let view = ChartView()
        view.rangkLabel.text = "2"
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: 60, height: 50)
        layer.colors = [UIColor.mainColor!.cgColor, UIColor.white.cgColor]
        view.chartView.layer.addSublayer(layer)
        view.percentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        return view
    }()
    
    lazy var chart1View: ChartView = {
        let view = ChartView()
        view.titleLabel.textColor = .mainColor
        view.percentLabel.textColor = .mainColor
        view.titleLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
        view.percentLabel.font = .systemFont(ofSize: 12.0, weight: .regular)
        
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: 60, height: 70)
        layer.colors = [UIColor.mainColor!.cgColor, UIColor.white.cgColor]
        view.chartView.layer.addSublayer(layer)
        
        let image = UIImageView()
        image.image = UIImage(named: "checkCircle")
        view.addSubview(image)
        view.contentMode = .scaleAspectFit
        
        view.percentLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(6)
        }
        
        image.snp.makeConstraints {
            $0.centerY.equalTo(view.percentLabel)
            $0.trailing.equalTo(view.percentLabel.snp.leading).inset(-4)
            $0.width.equalTo(10)
            $0.height.equalTo(10)
        }
        
        return view
    }()
    
    lazy var chart3View: ChartView = {
        let view = ChartView()
        view.rangkLabel.text = "3"
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: 60, height: 32)
        layer.colors = [UIColor.mainColor!.cgColor, UIColor.white.cgColor]
        view.chartView.layer.addSublayer(layer)
        view.percentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
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
            chart3View,
            checkView
        ].forEach {addSubview($0)}
        
        chart2View.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width * 0.12)
            $0.width.equalTo(57.0)
            $0.height.equalTo(113.0)
            $0.bottom.equalToSuperview().inset(-15)
        }
        chart1View.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(57.0)
            $0.height.equalTo(113.0)
            $0.bottom.equalToSuperview().inset(5.0)
        }
        chart3View.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(width * 0.12)
            $0.width.equalTo(57.0)
            $0.height.equalTo(113.0)
            $0.bottom.equalToSuperview().inset(-35)
        }
    }
}
