//
//  RegionSelectListView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/17.
//

import UIKit
import SnapKit

final class RegionSelectListView: UIView {
    
    var regionList: [RegionList] = []
    var selectRegion = "선택 안 함"
    var regionID = 0
    
    // MARK: - Subviews
    private lazy var titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.questionLabel.text = "간식거리🍩"
        return label
    }()
    
    lazy var confirmButton: CustomButton = {
        let button = CustomButton(type: .next)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegionSelectListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        cell.textLabel?.font = .systemFont(ofSize: 18.0, weight: .regular)
        if regionList[1].smallScale == regionList[0].smallScale {
            // MidScale
            cell.textLabel?.text = regionList[indexPath.row].midScale
        } else {
            // SmallScale
            cell.textLabel?.text = regionList[indexPath.row].smallScale
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRegion = regionList[indexPath.row].midScale
        regionID = regionList[indexPath.row].id
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
        cell?.textLabel?.textColor = .mainColor
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.font = .systemFont(ofSize: 18.0, weight: .regular)
        cell?.textLabel?.textColor = .textColor
    }
}

extension RegionSelectListView: UITableViewDataSource {
}

extension RegionSelectListView {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        [
            titleLabel,
            tableView,
            confirmButton
        ].forEach {addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(height * 0.2)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(height * 0.4)
            $0.width.equalTo(width - (width * 0.20))
            $0.height.equalTo(height * 0.35)
            $0.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(height * 0.1)
            $0.width.equalTo(width - (width * 0.14))
            $0.height.equalTo((width - (width * 0.23)) * 0.15)
        }
    }
}
