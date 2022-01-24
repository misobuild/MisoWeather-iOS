//
//  SurveyViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/24.
//

import UIKit
import SnapKit

final class SurveyViewController: UIViewController {
    
    // MARK: - SubView
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .regular)
        label.textColor = .black
        label.text = "날씨 이야기1"
        return label
    }()
    
    private var serveyTableView: ServeyTableView = {
        let tabieView = ServeyTableView()
        return tabieView
    }()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
    }
}

extension SurveyViewController {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        [
            serveyTableView
        ].forEach {view.addSubview($0)}
        
        
        serveyTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            //$0.leading.equalToSuperview().inset(width * 0.06)
        }
    }
}
