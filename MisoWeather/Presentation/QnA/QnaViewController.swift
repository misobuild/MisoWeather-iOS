//
//  QnaViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/25.
//

import UIKit

final class QnaViewController: UIViewController {
    
    var titleString = "오늘 날씨엔"
    var qnaString = "어떤외투 입으실래요?"
    
    // MARK: - Subviews
    private lazy var titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.titleLabel.text = "\(titleString)"
        label.questionLabel.text = "\(qnaString)"
        label.subTitleLabel.text = ""
        return label
    }()
    
    lazy var confirmButton: CustomButton = {
        let button = CustomButton(type: .answer)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        tableView.register(QnaTableVIewCell.self, forCellReuseIdentifier: "QnaTableVIewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
}

extension QnaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QnaTableVIewCell", for: indexPath) as? QnaTableVIewCell
        cell?.selectionStyle = .none
        cell?.setup()
        return cell ?? QnaTableVIewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
}

extension QnaViewController: UITableViewDataSource {
}

extension QnaViewController {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        [
            titleLabel,
            tableView,
            confirmButton
        ].forEach {view.addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(height * 0.2)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(height * 0.32)
            $0.width.equalTo(width - (width * 0.20))
            $0.height.equalTo(height * 0.45)
            $0.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(height * 0.14)
            $0.width.equalTo(width - (width * 0.14))
            $0.height.equalTo((width - (width * 0.23)) * 0.15)
        }
    }
}
