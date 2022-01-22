//
//  ForecastTableView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/22.
//

import UIKit
import SnapKit

final class ForecastTableView: UIView {
    
    // MARK: - subView
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.text = "10일 예보"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 39.0
        tableView.separatorStyle = .none
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: "ForecastTableViewCell")
    
        return tableView
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

extension ForecastTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath)
//        cell.selectionStyle = .none
//        cell.textLabel?.font = .systemFont(ofSize: 14.0, weight: .thin)
//        cell.textLabel?.text = "오늘 날씨는 어쩌구~"
        return cell
    }
}

extension ForecastTableView: UITableViewDataSource {
    
}

extension ForecastTableView {
    // MARK: - layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            titleLabel,
            tableView
        ].forEach {addSubview($0)}

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13.0)
            $0.leading.equalToSuperview().inset(width * 0.05)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(27.0)
            $0.leading.equalToSuperview()
            $0.height.equalTo(390)
            $0.width.equalTo(width - (width * 0.17))
        }
    }
}
