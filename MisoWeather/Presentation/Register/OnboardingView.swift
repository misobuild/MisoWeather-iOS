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
    var text = ["오늘 날씨,\n미소웨더에 물어봐", "오늘 뭐 입지?", "이따 뭐 먹지?", "내일 어디 가지?", "날씨로 얘기하자!"]
    var subText = ["", "좀 꾸미고 싶은데,\n코트 입으면 추울까?", "오늘 날씨에 딱 어울리는\n음식은 뭘까?",
                   "여기 보다는 따뜻하면 좋겠는데,\n그 지역 사람들한테 물어볼까?", "지금 바로 오늘 날씨에 대한\n생각을 나누러 가볼까요?"]
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = text.count
        view.currentPage = 0
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
        for index in 0..<text.count {
            print(width)
            configureTitle(index: index, width: width)
            configureSubTitle(index: index, width: width)
            configureimage(index: index, width: width)
            width += UIScreen.main.bounds.width
        }
    }
    private func configureimage(index: Int, width: CGFloat) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "onboarding\(index + 1)")
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width)
            $0.height.equalTo(UIScreen.main.bounds.width * 0.6)
            $0.width.equalTo(scrollView).inset(scrollView.frame.width / CGFloat(text.count))
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureTitle(index: Int, width: CGFloat) {
        let titleView = UILabel()
        titleView.text = text[index]
        titleView.textColor = .white
        titleView.numberOfLines = 0
        titleView.font = .systemFont(ofSize: 36, weight: .bold)
        contentView.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width + 40)
            $0.top.equalToSuperview()
        }
    }
    
    private func configureSubTitle(index: Int, width: CGFloat) {
        let titleView = UILabel()
        titleView.text = subText[index]
        titleView.textColor = .white
        titleView.numberOfLines = 0
        titleView.font = .systemFont(ofSize: 20, weight: .thin)
        contentView.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width + 40)
            $0.top.equalToSuperview().inset(50)
        }
    }
    
    private func setPageControlSelectedPage(currentPage: Int) {
        pageControl.currentPage = currentPage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addContentScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
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
            pageControl
        ].forEach {addSubview($0)}
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(width * 5)
            $0.height.equalTo(scrollView)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {
            $0.bottom.equalTo(scrollView.snp.bottom).offset(30)
            $0.centerX.equalTo(scrollView)
        }
    }
}

extension OnboardingView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
}
