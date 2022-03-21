//
//  MidRegionListViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/10.
//

import UIKit
import SnapKit

final class MidRegionListViewController: UIViewController {
    
    weak var delegate: RegionSendDelegate?
    private let model = RegionSelectViewModel()
    private var midScaleRegionList: [RegionList] = []
    private var smallScaleRegionList: [RegionList] = []
    var backScreen = BackScreen.create
    
    // MARK: - Subviews
    private lazy var regionSelectListView: RegionSelectListView = {
        let view = RegionSelectListView()
        view.regionList = midScaleRegionList
        view.confirmButton.addTarget(MidRegionListViewController(), action: #selector(fetchData), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Private Method
    @objc private func nextVC() {
        if regionSelectListView.selectRegion == midScaleRegionList.first?.smallScale {
            // 선택 지역ID 저장
            UserDefaults.standard.set(midScaleRegionList[0].id, forKey: "regionID")
            switch backScreen {
            case .survey, .main:
                model.putRegionChange {
                    DispatchQueue.main.async {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            case .create:
                let nextVC = NicknameSelectViewController()
                nextVC.recivedNickName = model.reciveNickname
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
     
        } else {
            let nextVC = SmallRegionListViewController()
            nextVC.delegate = self
            nextVC.smallScaleRegionList = model.midleRegionList
            nextVC.backScreen = backScreen
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
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
        var urlString = ""
        if regionSelectListView.selectRegion == "" {
            self.showAlert()
        } else {
            if regionSelectListView.selectRegion == midScaleRegionList.first?.smallScale {
                // 닉네임 받기
                urlString = URL.nickname
                model.fetchNicknameData(urlString: urlString) {
                    DispatchQueue.main.async {
                        self.nextVC()
                    }
                }
            } else {
                // small region 받기
                urlString = URL.region + midScaleRegionList[0].bigScale + "/" + regionSelectListView.selectRegion
                model.fetchMiddleRegionData(urlString: urlString) {
                    self.smallScaleRegionList = self.model.midleRegionList
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
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.barTintColor = .white
        // 라인 선 없애기
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        if let data = self.delegate?.sendData() {
            self.midScaleRegionList = data
        }
        setupView()
    }
}

extension MidRegionListViewController {
    
    // MARK: - Layout
    private func setupView() {
        view.addSubview(regionSelectListView)
        
        regionSelectListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MidRegionListViewController: RegionSendDelegate {
    func sendData() -> [RegionList] {
        return midScaleRegionList
    }
}
