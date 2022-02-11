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
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setData()
        setupView()
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
