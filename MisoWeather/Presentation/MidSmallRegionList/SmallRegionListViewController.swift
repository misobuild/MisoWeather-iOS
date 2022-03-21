//
//  SmallRegionListViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/17.
//

import UIKit
import SnapKit

final class SmallRegionListViewController: UIViewController {

    private var model = RegionSelectViewModel()
    weak var delegate: RegionSendDelegate?
    var smallScaleRegionList: [RegionList] = []
    var backScreen = BackScreen.create
    
    // MARK: - Subviews
    private lazy var regionSelectListView: RegionSelectListView = {
        let view = RegionSelectListView()
        view.regionList = smallScaleRegionList
        view.confirmButton.addTarget(MidRegionListViewController(), action: #selector(fetchData), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Private Method
    @objc private func nextVC() {
        // 선택 지역ID 저장
        let nextVC = NicknameSelectViewController()
        nextVC.recivedNickName = model.reciveNickname
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "지역을 선택해 주세요.",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func fetchData() {
        if regionSelectListView.selectRegion == "" {
            self.showAlert()
        } else {
            switch backScreen {
            case .survey, .main:
                UserDefaults.standard.set(regionSelectListView.regionID, forKey: "regionID")
                model.putRegionChange {
                    DispatchQueue.main.async {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            case .create:
                let urlString = URL.nickname
                UserDefaults.standard.set(regionSelectListView.regionID, forKey: "regionID")
                model.fetchNicknameData(urlString: urlString) {
                    DispatchQueue.main.async {
                        self.nextVC()
                    }
                }
            }
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
        
        setupView()
    }
}

extension SmallRegionListViewController {
    
    // MARK: - Layout
    private func setupView() {
        view.addSubview(regionSelectListView)
        
        regionSelectListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
