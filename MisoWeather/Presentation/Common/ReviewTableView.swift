//
//  ReviewTableView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/23.
//

import UIKit
import SnapKit

final class ReviewTableView: UIView {
    
    var row = 5
    var frontColor = UIColor.white
    var backColor = UIColor.backgroundColor

    // MARK: - subView
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 72
        tableView.separatorStyle = .none
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "ReviewTableViewCell")
        
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

extension ReviewTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell
        cell?.selectionStyle = .none
        cell?.backView.backgroundColor = frontColor
        cell?.backgroundColor = backColor
        return cell ?? UITableViewCell()
    }
}

extension ReviewTableView: UITableViewDataSource {
}

extension ReviewTableView {
    // MARK: - layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        [
            tableView
        ].forEach {addSubview($0)}
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
