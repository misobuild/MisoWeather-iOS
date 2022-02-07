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
        UserDefaults.standard.set(regionSelectListView.regionID, forKey: "regionID")
        let nextVC = NicknameSelectViewController()
        nextVC.recivedNickName = model.reciveNickname
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func fetchData() {
        let urlString = URL.nickname
        model.fetchNicknameData(urlString: urlString) {
            DispatchQueue.main.async {
                self.nextVC()
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
