//
//  HourlyForecastView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/21.
//

import UIKit
import SnapKit

final class HourlyForecastView: UIView {
    
    var hourly: [HourlyForecastList] = []
    
    // MARK: - subviews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.text = "시간대별 날씨"
        return label
    }()
    
    lazy var hourlyWeatherView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HourlyForecastViewCell.self, forCellWithReuseIdentifier: "HourlyWeatherViewCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .backgroundColor
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HourlyForecastView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourly.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherViewCell", for: indexPath) as? HourlyForecastViewCell
        cell?.configureData(hourly: hourly[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

extension HourlyForecastView: UICollectionViewDelegate {
    
}

extension HourlyForecastView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50.0, height: 80.0)
    }
}

extension HourlyForecastView {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [   titleLabel,
            hourlyWeatherView
        ].forEach {addSubview($0)}
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16.0)
            $0.leading.equalToSuperview().inset(20.0)
        }
        
        hourlyWeatherView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            $0.height.equalTo(80.0)
            $0.width.equalTo(width - (width * 0.20))
            $0.leading.equalToSuperview().inset(10.0)
        }
    }
}
