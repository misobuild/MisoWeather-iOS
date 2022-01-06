//
//  regionSearchViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/03.
//

import UIKit
import SnapKit

class regionSearchViewController: UIViewController {
    var num = 0
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.isHidden = true
        return tableView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = """
                    어느 지역의
                    옷차림을 보고 싶으신가요?
                    """
        return label
    }()
    
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    private lazy var confirmButton: customButton = {
        let button = customButton(type: .system)
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        return button
    }()
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(nicknameSelectViewController(), animated: true)
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "날씨"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "도시로 검색해주세요. 예) 파주시 "
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationItems()
        setup()

    }
}

extension regionSearchViewController {
    private func setup() {
        [tableView, titleLabel ,regionLabel, confirmButton].forEach{view.addSubview($0)}
///
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalToSuperview().inset(300.0)
        }
        regionLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(100.0)

        }
        confirmButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(100.0)
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.height.equalTo(50.0)
        }
    }
}

extension regionSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        num = 7
        tableView.reloadData()
        tableView.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        num = 0
        tableView.isHidden = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension regionSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = "title"
        cell.detailTextLabel?.text = "detail"
        
        return cell
    }
}

extension regionSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = nicknameSelectViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
