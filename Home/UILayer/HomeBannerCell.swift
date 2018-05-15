//
//  HomeBannerCell.swift
//  ClientCore
//
//  Created by Fangzhou Yan on 12/5/17.
//  Copyright © 2017 GPshopper. All rights reserved.
//

import UIKit
import GDK

class HomeBannerCell: UITableViewCell {
    @IBOutlet weak var bannerView: GDKBannerView!
    var shouldParallax = false
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bannerView.banner = nil
        shouldParallax = false
    }
}

