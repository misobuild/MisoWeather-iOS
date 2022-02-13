//
//  SurveyViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/24.
//

import UIKit
import SnapKit

final class SurveyViewController: UIViewController {
    
    let model = SurveyViewModel()
    
    // MARK: - SubView
    var surveyTableView: SurveyTableView = {
        let tabieView = SurveyTableView()
        return tabieView
    }()
    
    // MARK: - PrivateMethod
    
    private func setData() {
        model.getSurveyData {
            self.model.getUserSurveyData {
                self.surveyTableView.surveyList = self.model.surveyInfo
                self.surveyTableView.userSurveyList = self.model.userSurveyInfo
                DispatchQueue.main.async {
                    self.surveyTableView.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func notificationReceived(notification: Notification) {
        // Notification에 담겨진 object와 userInfo를 얻어 처리 가능
        guard let notificationUserInfo = notification.userInfo as? [String: Int] else { return }
        guard let surveyID = notificationUserInfo.values.first else {return}
        
        model.getSurveyAnswerData(id: surveyID) {
            DispatchQueue.main.async {
                let nextVC = QnaViewController()
                nextVC.surveyAnswerList = self.model.surveyAnswerInfo
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        
        // 옵저버를 추가해 구독이 가능하게 끔 함
        // self에서 notification이란 이름을 가진 노티를 관찰할 것이고, 해당 노티가 발생하는 경우에 notificationReceived 란 함수를 호출해 실행할 것이다.
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(notification:)), name: .surveyNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
        self.surveyTableView.tableView.reloadData()
    }
}

extension SurveyViewController {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        [
            surveyTableView
        ].forEach {view.addSubview($0)}
        
        surveyTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
