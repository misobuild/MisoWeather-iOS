//
//  OnboardingView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/13.
//

import Foundation
import UIKit

final class OnboardingView: UIView {
    
    // MARK: - Subviews
    var images = [UIImage(named: "onboarding1"), UIImage(named: "onboarding2"), UIImage(named: "onboarding3"), UIImage(named: "onboarding4")
                  , UIImage(named: "onboarding5")]
    var imageViews = [UIImageView]()

    let scrollView = UIScrollView()
    // 스크롤 뷰 안에는 스크롤이 되는 컨텐트 뷰가 존재해야 함
    let contentView = UIView()
    
    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 45.0, weight: .regular)
        label.textColor = .buttonTextColor
        label.text = "MisoWeather🌤"
        return label
    }()
    
    private func addContentScrollView() {
        var width: CGFloat = 0
        for index in 0..<images.count {
            let imageView = UIImageView()
            //imageView.image = UIImage(named: "onboarding1")
            let xPos = self.frame.width * CGFloat(index)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
             imageView.image = images[index]
            imageView.contentMode = .scaleAspectFit
            contentView.addSubview(imageView)
        
            imageView.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(width)
                $0.height.equalTo(scrollView)
                $0.width.equalTo(scrollView).inset(scrollView.frame.width / CGFloat(images.count))
            }
            width += 400
            scrollView.contentSize.width = imageView.frame.width * CGFloat(index + 1)
        }
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addContentScrollView()
        setPageControl()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OnboardingView {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
       
        contentView.addSubview(titleLabel)
        
        scrollView.addSubview(contentView)
        
        addSubview(scrollView)

        [
            scrollView,
            pageControl,
      //      titleLabel
        ].forEach {addSubview($0)}
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(1200)
            $0.height.equalTo(scrollView)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        titleLabel.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.bottom.equalToSuperview()
//            $0.height.equalTo(scrollView)
//            $0.width.equalTo(1200)
//        }
//
        pageControl.snp.makeConstraints {
            $0.bottom.equalTo(scrollView.snp.bottom)
            $0.centerX.equalTo(scrollView)
        }
    }
}

extension OnboardingView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = Int(Int(scrollView.contentOffset.x) / Int(scrollView.frame.size.width))
        setPageControlSelectedPage(currentPage: value)
    }
}
