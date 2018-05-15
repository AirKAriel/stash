//
//  AchievementsCell.swift
//  Achievements
//
//  Created by Fangzhou Yan on 5/14/18.
//  Copyright © 2018 Fangzhou Yan. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class AchievementsCell: UITableViewCell {
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView! //can use BezierPath to draw custom progress bar
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func prepareForReuse() {
        backgroundImageView.image = nil
        levelLabel.text = ""
        progressLabel.text = ""
        totalLabel.text = ""
        progressView.setProgress(0, animated: false)
    }
    
    func configureWith(achievement: Achievement) {
        if let url = URL(string: achievement.imageUrl) {
            backgroundImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "imagePlaceHolder"), completed: nil)
        }
        
        backgroundImageView.layer.cornerRadius = 10 //cause UI lagging if list is long, can improve by custom drawing in background queue.
        
        contentView.alpha = achievement.accessible ? 1 : 0.35
        
        levelView.layer.cornerRadius = 50 //background it if list is long
        levelLabel.text = achievement.level
        
        let percentOfProgress = achievement.progress.floatValue / achievement.total.floatValue
        progressView.setProgress(percentOfProgress, animated: true) //can move to table view will display cell delegate function.
        progressView.progressTintColor = UIColor.green
        progressView.trackTintColor = UIColor(white: 0.95, alpha: 1.0)
        
        progressLabel.text = "\(achievement.progress)pts"
        totalLabel.text = "\(achievement.total)pts"
        
    }
}
