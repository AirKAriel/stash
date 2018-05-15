//
//  CarouselView.swift
//  SallyBeauty
//
//  Created by Pavel Vavilov on 8/29/17.
//  Copyright © 2017 GPShopper. All rights reserved.
//

import GDK
import UIKit

let CarouselDidUpdateIntrinsicContentSizeNotificationName = Notification.Name("kCarouselDidUpdate")

protocol CarouselIntrinsicContentSizeDelegate: class {
    func shouldUpdateIntrinsicContentSize()
}

/**
 Custom `UIScrollView` that calculates size based on the GDKBanner's image
 with largest aspect ratio received from the GDK.
 */

final class CarouselScrollView: UIScrollView {
    
    weak var carouselDelegate: CarouselIntrinsicContentSizeDelegate? = nil
    
    fileprivate typealias PositionName = String
    fileprivate var preferredLayoutWidth: CGFloat?
    fileprivate var images: [PositionName: UIImage] = [:]
    fileprivate(set) var bannerViews: [GDKBannerView] = []
    
    
    override var intrinsicContentSize: CGSize {
        return calculateIntrinsicContentSize()
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
        
        let xInset = contentInset.left + contentInset.right
        let yInset = contentInset.top + contentInset.bottom
        
        var pageFrame = CGRect(x: 0.0,
                               y: 0.0,
                               width: frame.width - xInset,
                               height: frame.height - yInset)
        
        for view in bannerViews {
            view.frame = pageFrame
            pageFrame = pageFrame.offsetBy(dx: pageFrame.width, dy: 0)
        }
        
        
        contentSize = CGSize(width: pageFrame.origin.x, height: pageFrame.height)
    }
    
    
    // MARK: Public
    
    public func setBanners(_ banners: [GDKBanner]) {
        for bannerView in bannerViews {
            bannerView.removeFromSuperview()
        }
        
        bannerViews = sortedBannerViews(from: banners)
        
        for bannerView in bannerViews {
            addSubview(bannerView)
        }
    }
}


// MARK: - GDKBannerViewDelegate

extension CarouselScrollView: GDKBannerViewDelegate {
    func bannerView(_ bannerView: GDKBannerView, updatedImage image: UIImage?) {
        if let image = image {
            images[bannerView.positionName] = image
        }
        
        invalidateIntrinsicContentSize()
        carouselDelegate?.shouldUpdateIntrinsicContentSize()
    }
}


// MARK: - Private

private extension CarouselScrollView {
    
    func setup() {
        isPagingEnabled = true
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    func sortedBannerViews(from banners: [GDKBanner]) -> [GDKBannerView] {
        var tmpBannerViewDict: [Int: GDKBannerView] = [:]
        var bannerViews: [GDKBannerView] = []
        
        for banner in banners {
            guard let positionIndexString = banner.positionName.components(separatedBy: "_").last,
                let positionIndex = Int(positionIndexString) else {
                    continue
            }
            
            let bannerView = GDKBannerView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
            bannerView.fadesIn = false
            bannerView.delegate = self
            bannerView.positionName = banner.positionName
            bannerView.banner = banner
            bannerView.contentMode = .scaleAspectFit
          
            tmpBannerViewDict[positionIndex] = bannerView
        }
        
        var i = 0
        while i <= tmpBannerViewDict.keys.count {
            if let bannerView = tmpBannerViewDict[i] {
                bannerViews.append(bannerView)
            }
            i += 1
        }
        
        //Creating a copy of the first banner that's appended to the end of the bannerViews array to create/simulate a seamless looping effect for the carousel
    
        let firstBannerViewCopy = GDKBannerView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        firstBannerViewCopy.fadesIn = false
        firstBannerViewCopy.delegate = self
        firstBannerViewCopy.contentMode = .scaleAspectFit
        if let positionName = bannerViews.first?.banner?.positionName {
            firstBannerViewCopy.positionName = positionName
        }
        firstBannerViewCopy.banner = bannerViews.first?.banner
        bannerViews.append(firstBannerViewCopy)
        
        
        return bannerViews
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
    
    func calculateIntrinsicContentSize() -> CGSize {
        var size = CGSize.zero
        
        if let width = preferredLayoutWidth {
            if images.count > 0 {
              let actualImages = images.map { $1 }
              let height = getCarouselHeightBasedOn(images: actualImages)
                size = CGSize(width: width, height: height)
            } else {
                size = CGSize(width: width, height: 0)
            }
        } else {
            size = CGSize(width: UIViewNoIntrinsicMetric, height: UIViewNoIntrinsicMetric)
        }
        
        NotificationCenter.default.post(name: CarouselDidUpdateIntrinsicContentSizeNotificationName, object: nil)
        
        return size
    }
  
  func getCarouselHeightBasedOn(images: [UIImage]) -> CGFloat {
    guard let preferredLayoutWidth = preferredLayoutWidth else {
      return 0
    }
    
    var recommendedHeight: CGFloat = 0
    
    for image in images {
      let widthRatio = preferredLayoutWidth / image.size.width
      let stretchedHeight = image.size.height * widthRatio
      
      if stretchedHeight > recommendedHeight {
        recommendedHeight = stretchedHeight
      }
    }
   
    return recommendedHeight
  }
}
