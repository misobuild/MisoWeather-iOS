//
//  QnaViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/25.
//

import UIKit

final class QnaViewController: UIViewController {
    
    let model = QnaViewModel()
    var surveyAnswerList: [SurveyAnswerList] = []
    var answerID: Int = 0
    var item = ""
    
    // MARK: - Subviews
    private lazy var qnaView: QnaView = {
        let view = QnaView()
        return view
    }()
    
    private lazy var titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.subTitleLabel.text = ""
        return label
    }()
    
    private lazy var confirmButton: CustomButton = {
        let button = CustomButton(type: .answer)
        button.addTarget(self, action: #selector(postAnswer), for: .touchUpInside)
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
    
    // MARK: - Private Method
    @objc private func postAnswer() {
        model.postSurveyAnswerData(answerID: answerID, surveyID: surveyAnswerList[0].surveyId) {
            DispatchQueue.main.async {
                
                let qnaView = QnaView()
                qnaView.item = self.item
                self.view.addSubview(qnaView)
                qnaView.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    self.popView()
                }
            }
        }
    }
    
    private func popView() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }

    private func setData() {
        titleLabel.titleLabel.text = surveyAnswerList[0].surveyDescription
        titleLabel.questionLabel.text = surveyAnswerList[0].surveyTitle
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setData()
        setupView()
    }
}

extension QnaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyAnswerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QnaTableVIewCell", for: indexPath) as? QnaTableVIewCell
        cell?.selectionStyle = .none
        cell?.setup(data: surveyAnswerList[indexPath.row])
        return cell ?? QnaTableVIewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = true
        self.answerID = surveyAnswerList[indexPath.row].answerId
        self.item = surveyAnswerList[indexPath.row].answer
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
