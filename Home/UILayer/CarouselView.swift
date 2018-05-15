//
//  CarouselView.swift
//  SallyBeauty
//
//  Created by Pavel Vavilov on 8/29/17.
//  Copyright © 2017 GPShopper. All rights reserved.
//

import GDK
import UIKit

/** Container view for `CarouselScrollView`. Contains `StylablePageControl`. */

final class CarouselView: UIView {
    fileprivate var currentIndex: Int = 0
    fileprivate var preferredLayoutWidth: CGFloat?
    fileprivate let pageControl = StylablePageControl(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    fileprivate let carouselScrollView = CarouselScrollView(frame: .zero)
    
    //impression tracking
    var bannersWithImpressions: [GDKBannerView] = []
    fileprivate var bannerTimer: Timer?
    fileprivate var displayedBannerView = GDKBannerView()
    
    override var intrinsicContentSize: CGSize {
        return carouselScrollView.intrinsicContentSize
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        invalidateIntrinsicContentSizeIfNeeded()
        
        carouselScrollView.frame = bounds
        pageControl.center = CGPoint(x: center.x, y: bounds.size.height - 20)
    }
    
    
    // MARK: Public
    
    public func setBanners(_ banners: [GDKBanner]) {
        carouselScrollView.setBanners(banners)
        
        pageControl.numberOfPages = carouselScrollView.bannerViews.count - 1
        pageControl.isHidden = carouselScrollView.bannerViews.count <= 1
        pageControl.currentPage = currentIndex
        startImpressionTimer()
    }
}


// MARK: - UIScrollViewDelegate

extension CarouselView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        if Int(pageNumber) == pageControl.numberOfPages {
            pageControl.currentPage = 0
            currentIndex = 0
        }
        else {
            pageControl.currentPage = Int(pageNumber)
            currentIndex = Int(pageNumber)
        }
        
        pageControl.accessibilityLabel = "Page Selector"
        pageControl.accessibilityHint = String(format: "currently on page %i of %i", pageControl.currentPage, pageControl.numberOfPages)
        startImpressionTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.x > CGFloat(pageControl.numberOfPages) * scrollView.frame.size.width) {
            scrollView.contentOffset.x = 0
        }
        else if(scrollView.contentOffset.x < 0.0) {
            scrollView.contentOffset.x = CGFloat(pageControl.numberOfPages) * scrollView.frame.size.width
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        bannerTimer?.invalidate()
    }

}


// MARK: - CarouselScrollViewDelegate

extension CarouselView: CarouselIntrinsicContentSizeDelegate {
    func shouldUpdateIntrinsicContentSize() {
        invalidateIntrinsicContentSize()
    }
}


// MARK: - Private

private extension CarouselView {
    
    func setup() {
        carouselScrollView.delegate = self
        carouselScrollView.carouselDelegate = self
        
        addSubview(carouselScrollView)
        addSubview(pageControl)
    }
    
    func startImpressionTimer() {
        if !carouselScrollView.bannerViews.isEmpty {
            displayedBannerView = carouselScrollView.bannerViews[pageControl.currentPage]
            bannerTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(logImpression), userInfo: nil, repeats: false)
        }
    }
    
    @objc func logImpression() {
        guard let banner = displayedBannerView.banner, !(bannersWithImpressions.contains(displayedBannerView)) else {
            return
        }
        //Banner tracking events should ideally happen in GDK
        Analytics.shared.trackEventBannerViewed(banner)
        bannersWithImpressions.append(displayedBannerView)
    }
    
    func invalidateIntrinsicContentSizeIfNeeded() {
        guard let preferredLayoutWidth = preferredLayoutWidth else {
            self.preferredLayoutWidth = bounds.size.width
            invalidateIntrinsicContentSize()
            return
        }
        
        if preferredLayoutWidth != bounds.size.width {
            self.preferredLayoutWidth = bounds.size.width
            invalidateIntrinsicContentSize()
        }
    }
}
