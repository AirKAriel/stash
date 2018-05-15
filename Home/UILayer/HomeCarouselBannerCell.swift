//
//  HomeCarouselBannerCell.swift
//  ClientCore
//
//  Created by Fangzhou Yan on 12/5/17.
//  Copyright © 2017 GPshopper. All rights reserved.
//

import UIKit
import GDK

class HomeCarouselBannerCell: UITableViewCell {
    @IBOutlet weak var carouselView: CarouselView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        carouselView.setBanners([GDKBanner]())
    }
}
