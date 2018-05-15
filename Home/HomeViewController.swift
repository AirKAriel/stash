//
//  HomeViewController.swift
//  ClientCore
//
//  Created by Fangzhou Yan on 12/5/17.
//  Copyright © 2017 GPShopper. All rights reserved.
//
import Foundation
import UIKit
import GDK

final class HomeViewController: BaseViewController, UITableViewDelegate {
    
    var output:HomeEventHandler!
    var updatedBannerImageIDs = Set<String>()
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    let homeDataSource = HomeDataSource()
    
    fileprivate var refreshControl = UIRefreshControl()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        screenName = GAScreen.Name.home.string
        self.applyAppConfig()
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshBanners()
    }

    // MARK: - PRIVATE
    private func setup() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name(rawValue: GDKBannerManagerUpdatedNotificationName), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: CarouselDidUpdateIntrinsicContentSizeNotificationName, object: nil)
        
        tableView.dataSource = homeDataSource
        tableView.delegate = self
        refreshBanners()
        
        navigationItem.rightBarButtonItems = [searchButton, cartButton]
    }
    
    private func refreshBanners() {
        self.homeDataSource.carouselBanners = BannerModule.shared.banners(withPrefix: .homeCarousel)
        var fullWidthBanners = BannerModule.shared.banners(withPrefix: .homeBanner)
        if let ribbonBanner = BannerModule.shared.banner(forPosition: .homeRibbon) {
            fullWidthBanners.insert(ribbonBanner, at: 0)
        }
        
        self.homeDataSource.fullWidthBanners = fullWidthBanners
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    private func applyAppConfig() {
        self.title = AppConfigValues.string(location: .home, friendlyName: .navigation, viewType: .title)
    }
    
    @objc private func refresh() {
        refreshBanners()
    }
    
    @objc private func updateTableView() {
        //Update the tableView cell heights base on the carousel height and relayout when carousel finishes downloading images.
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
            if let bannerCell = cell as? HomeBannerCell, bannerCell.shouldParallax {
                bannerCell.scrolledOn(scrollView: scrollView, parallaxView: bannerCell.bannerView)
            }
        }
    }
    
}

extension HomeViewController: SearchDelegate {
 
    override func searchBarAction() {
        self.output.presentSearchViewController()
    }
    
    func search(term: String) {
        self.output.pushProductListViewController(searchQuery: term)
    }
}

extension HomeViewController: GDKBannerViewDelegate {
    func bannerView(_ bannerView: GDKBannerView, updatedImage image: UIImage?) {
        if let cell = bannerView.superview?.superview as? HomeBannerCell {
            if tableView.visibleCells.contains(cell) {
                if let imageID = bannerView.banner?.imageID {
                    if !updatedBannerImageIDs.contains(imageID) {
                        updatedBannerImageIDs.insert(imageID)
                        tableView.beginUpdates()
                        tableView.endUpdates()
                    }
                }
            }
        }
    }
}
