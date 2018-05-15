//
//  HomeDataSource.swift
//  ClientCore
//
//  Created by Fangzhou Yan on 12/5/17.
//  Copyright © 2017 GPshopper. All rights reserved.
//

import Foundation
import GDK

class HomeDataSource: NSObject, UITableViewDataSource {
    
    var carouselBanners: [GDKBanner]!
    var fullWidthBanners: [GDKBanner]!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if carouselBanners.isEmpty {
            return fullWidthBanners.count
        }
        return fullWidthBanners.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, !carouselBanners.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeCarouselBannerCell") as! HomeCarouselBannerCell
            cell.carouselView.setBanners(carouselBanners)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeBannerCell") as! HomeBannerCell
        
        var adjustedRow = indexPath.row
        if !carouselBanners.isEmpty {
            adjustedRow -= 1
        }
        
        let banner = fullWidthBanners[adjustedRow]
        
        cell.bannerView.banner = banner
        if banner.positionName != BannerPosition.homeRibbon.rawValue {
            cell.shouldParallax = true
        }
		
		cell.accessibilityIdentifier = "childBanner\(indexPath.row)"
        return cell
    }
}
