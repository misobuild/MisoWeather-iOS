//
//  SurveyTableView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/24.
//

import UIKit
import SnapKit

final class SurveyTableView: UIView {
    // MARK: - subView
    var surveyList: [SurveyList] = []
    var userSurveyList: [UserSurveyList] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(SurveyTableViewCell.self, forCellReuseIdentifier: "ServeyTableViewCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .clear
        layer.cornerRadius = 20
        self.tableView.allowsSelection = true
        tableView.delaysContentTouches = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SurveyTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSurveyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServeyTableViewCell", for: indexPath) as? SurveyTableViewCell
        cell?.selectionStyle = .none
        cell?.setSurveyData(surveyData: surveyList[indexPath.row])
        cell?.setUserSurveyData(userData: userSurveyList[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension SurveyTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServeyTableViewCell", for: indexPath) as? SurveyTableViewCell
        let id = userSurveyList[indexPath.row].surveyId
        
        if !userSurveyList[indexPath.row].answered {
            // Notification에 userinfo를 실어서 보냄
            NotificationCenter.default.post( name: .surveyNotification, object: nil, userInfo: ["surveyID": id])
        }
    }
}

extension SurveyTableView {
    // MARK: - layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            tableView
        ].forEach {addSubview($0)}
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(width * 0.06)
            $0.trailing.equalToSuperview().inset(width * 0.06)
            $0.bottom.equalToSuperview()
        }
    }
}
