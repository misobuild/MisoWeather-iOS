//
//  SmallRegionListViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/17.
//

import UIKit
import SnapKit

class SmallRegionListViewController: UIViewController {
        
    weak var delegate: SendDelegate?
    private var midScaleRegionList: [RegionList] = []
    
    // MARK: - Subviews
    
    private lazy var regionSelectListView: RegionSelectListView = {
        let view = RegionSelectListView()
        view.regionList = midScaleRegionList
        return view
    }()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
                
        if let data = self.delegate?.sendData() {
            self.midScaleRegionList = data
            print("midScaleRegionList \(midScaleRegionList)")
        }
        
        setupView()
    }
}

extension SmallRegionListViewController {

    // MARK: - Layout
    private func setupView() {
        [
            regionSelectListView

        ].forEach {view.addSubview($0)}

        regionSelectListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}
