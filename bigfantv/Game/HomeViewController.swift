//
//  HomeViewController.swift
//  Outquiz
//
//  Created by Vasily Evreinov on 16.03.2018.
//  Copyright © 2018 UniProgy s.r.o. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var faqButton: UIButton!
    @IBOutlet weak var nextGameInfoLabel: UILabel!
    @IBOutlet weak var liveButton: UIButton!
    
    @IBOutlet weak var userCardView: UIView!
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var balanceValueLabel: UILabel!
    @IBOutlet weak var balanceTitleLabel: UILabel!
    @IBOutlet weak var livesValueLabel: UILabel!
    @IBOutlet weak var livesTitleLabel: UILabel!
    @IBOutlet weak var livesImageView: UIImageView!
    
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var getMoreLivesButton: UIButton!
    
    @IBOutlet weak var lbView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSelector: UISegmentedControl!
    @IBOutlet weak var lbList: UITableView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    var showsTimer: Timer?
    var show: Show?
    var lbWeekly: NSArray?
    var lbTotal: NSArray?
    var autoLaunchShow: Bool = true
    var playerStats: NSDictionary?
    static var isfromgame = 0
    // MARK: - Button Taps
    
    @IBAction func getMoreLivesButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Lives", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! LivesViewController
        let navigationController = UINavigationController(rootViewController: controller)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func menuButtonTap(_ sender: Any) {
        showAccount()
    }
    
    @IBAction func liveButtonTap(_ sender: Any) {
        launchShow()
    }
    
    @IBAction func faqButtonTap(_ sender: Any) {
        showFaqMenu()
    }
    
    @objc func showCashout()
    {
        let storyboard = UIStoryboard(name: "Cashout", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! CashoutViewController
        controller.balance = playerStats?["balance"] as? Int ?? 0
        let navigationController = UINavigationController(rootViewController: controller)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - FAQ Menu
    
    @IBAction func backbttapped(_ sender: UIButton) {
        HomeViewController.isfromgame = 1
        //self.performSegue(withIdentifier: "backta", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func showFaqMenu()
    {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Rules", comment: ""), style: .default, handler: { (action) in
            let navigationController = Misc.webView(NSLocalizedString("rules", comment: ""), Misc.docUrl("rules"))
            self.present(navigationController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Faq", comment: ""), style: .default, handler: { (action) in
            let navigationController = Misc.webView(NSLocalizedString("faq", comment: ""), Misc.docUrl("faq"))
            self.present(navigationController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { (action) in
            // do nothing, it's cancelled
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Menu
    
    @objc func showAccount()
    {
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        let navigationController = UINavigationController(rootViewController: controller!)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // stop timer when app goes in background
        NotificationCenter.default.addObserver(self, selector: #selector(appClosed), name:UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appOpened), name:UIApplication.didBecomeActiveNotification, object: nil)
        // enable auto show live show
        autoLaunchShow = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disappear()
    }
    
    @objc func appClosed()
    {
        disappear()
    }
    
    @objc func appOpened()
    {
        appear()
    }
    
    func appear()
    {
        if(showsTimer == nil)
        {
            showsTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(loadShow), userInfo: nil, repeats: true)
        }
        loadPlayer()
        loadLb()
    }
    
    func disappear()
    {
        showsTimer?.invalidate()
        showsTimer = nil
    }
    
    func configureView()
    {
        // design
        let textColor = UIColor(cfgName: "colors.text")
        faqButton.tintColor = textColor
        liveButton.backgroundColor = UIColor(cfgName: "colors.home.watch.background")
        liveButton.setTitleColor(UIColor(cfgName: "colors.home.watch.text"), for: .normal)
        userCardView.backgroundColor = textColor.withAlphaComponent(0.1)
        userCardView.layer.cornerRadius = 16.0
        usernameLabel.textColor = textColor
        menuButton.tintColor = textColor
        rankLabel.textColor = textColor.withAlphaComponent(0.5)
        balanceValueLabel.textColor = textColor
        balanceTitleLabel.textColor = textColor.withAlphaComponent(0.5)
        livesValueLabel.textColor = textColor
        livesTitleLabel.textColor = textColor.withAlphaComponent(0.5)
        livesImageView.tintColor = UIColor(cfgName: "colors.home.heart")
        getMoreLivesButton.backgroundColor = textColor
        getMoreLivesButton.setTitleColor(UIColor(cfgName: "colors.background"), for: .normal)
        lbView.backgroundColor = textColor.withAlphaComponent(0.1)
        lbView.layer.cornerRadius = 16.0
        lbSelector.tintColor = textColor
        lbTitle.textColor = textColor
        separatorView.backgroundColor = textColor.withAlphaComponent(0.2)
        lbSelector.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        lbSelector.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        
        // fill in labels and available data, such as avatar
        getMoreLivesButton.setTitle(NSLocalizedString("Get More Lives", comment: ""), for: .normal)
        lbTitle.text = NSLocalizedString("Leaderboard", comment: "")
        nextGameInfoLabel.attributedText = NSAttributedString(string: "")
        Misc.currentPlayer?.setAvatar(avatarImageView)
        usernameLabel.text = Misc.currentPlayer?.username
        rankLabel.text = ""
        balanceValueLabel.text = ""
        balanceTitleLabel.text = NSLocalizedString("Balance", comment: "")
        livesValueLabel.text = "0"
        livesTitleLabel.text = NSLocalizedString("Lives", comment: "")
        liveButton.setTitle(NSLocalizedString("Live watch now", comment: ""), for: .normal)
        
        // enable tap on balance to show cashout screen
        balanceValueLabel.isUserInteractionEnabled = true
        let balanceTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showCashout))
        balanceValueLabel.addGestureRecognizer(balanceTap)
        
        // leaderboard
        lbSelector.addTarget(self, action: #selector(lbChanged), for: .valueChanged)
        lbSelector.setTitle(NSLocalizedString("This Week", comment: ""), forSegmentAt: 0)
        lbSelector.setTitle(NSLocalizedString("All time", comment: ""), forSegmentAt: 1)
        lbSelector.selectedSegmentIndex = 0
        lbList.dataSource = self
        lbList.delegate = self
        // remove empty cells from tableview
        lbList.tableFooterView = UIView()
        // hide before the data loads
        lbList.isHidden = true
    }
    
    // MARK: - Show
    
    @objc func loadShow()
    {
        API.home(showSuccess, failure)
    }
    
    func showSuccess(_ data: NSDictionary)
    {
        let obj = data["show"] as? NSDictionary
        if(obj != nil)
        {
            let id = obj!["id"] as! Int
            let schedule = obj!["schedule"] as! String
            let amount = obj!["amount"] as! Int
            let live = obj!["live"] as! Int
            self.show = Show(id, schedule, amount, live)
            
            if live == 1
            {
                self.show!.socket = obj!["socket"] as? NSDictionary
                self.show!.streaming = obj!["streaming"] as? NSDictionary
            }
            
        } else {
            self.show = nil
        }
        updateShow()
    }
    
    func updateShow()
    {
        var msg = NSMutableAttributedString(string: "")
        
        if(show == nil)
        {
            msg = NSMutableAttributedString(string: NSLocalizedString("No Upcoming show", comment: "").uppercased())
            msg.setFont(msg.string, UIFont.systemFont(ofSize: 20.0))
            nextGameInfoLabel.isHidden = false
            liveButton.isHidden = true
        }
        else if(show!.live == 0)
        {
            let strNextGameTitle = NSLocalizedString("Next game", comment: "").uppercased()
            let strSchedule = self.show!.scheduleFormatted()
            let strPrizeTitle = NSLocalizedString("Prize", comment: "").uppercased()
            let strPrize = self.show!.amountFormatted()
            
            msg = NSMutableAttributedString(string: strNextGameTitle)
            msg.append(NSAttributedString(string: "\n"))
            msg.append(NSMutableAttributedString(string: strSchedule))
            msg.append(NSAttributedString(string: "\n"))
            msg.append(NSAttributedString(string: strPrizeTitle))
            msg.append(NSAttributedString(string: "\n"))
            msg.append(NSMutableAttributedString(string: strPrize))
            
            msg.setFont(strNextGameTitle, UIFont.systemFont(ofSize: 20.0))
            msg.setFont(strSchedule, UIFont.boldSystemFont(ofSize: strSchedule.count < 10 ? 35.0 : 30.0))
            msg.setFont(strPrizeTitle, UIFont.systemFont(ofSize: 20.0))
            msg.setFont(strPrize, UIFont.boldSystemFont(ofSize: 35.0))
            
            nextGameInfoLabel.isHidden = false
            liveButton.isHidden = true
        }
        else if(show!.live == 1)
        {
            nextGameInfoLabel.isHidden = true
            liveButton.isHidden = false
            if autoLaunchShow
            {
                launchShow()
            }
        }
        
        if(msg.length > 0)
        {
            let range = NSRange(location: 0, length: msg.length)
            msg.setCentered()
            msg.addAttribute(.foregroundColor, value: UIColor(cfgName: "colors.text"), range: range)
        }
        nextGameInfoLabel.attributedText = msg
    }
    
    func launchShow()
    {
        /*
        let storyboard = UIStoryboard(name: "Show", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! ShowViewController
        controller.lives = playerStats?["lives"] as? Int ?? 0
        controller.show = self.show
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        autoLaunchShow = false
        */
    }
    
    // MARK: - Player Stats
    
    func loadPlayer()
    {
        API.player(playerSuccess, failure)
    }
    
    func playerSuccess(_ data: NSDictionary)
    {
        playerStats = data
        
        let rank_total = data["rank_total"] as? Int
        let rank_weekly = data["rank_weekly"] as? Int
        let balance = data["balance"] as! Int
        let lives = data["lives"] as! Int
        
        let rank_weekly_str = rank_weekly == nil ? "-" : String(format:"%d", rank_weekly!)
        let rank_total_str = rank_total == nil ? "-" : String(format:"%d", rank_total!)
        
        rankLabel.text = String(format: NSLocalizedString("Rank this week", comment: ""), rank_weekly_str, rank_total_str)
        balanceValueLabel.text = Misc.moneyFormat(balance)
        livesValueLabel.text = String(format:"%d", lives)
        
        loadShow()
    }
    
    // MARK: - Leaderboard
    
    func loadLb()
    {
        API.leaderboard(lbSucces, failure)
    }
    
    func lbSucces(_ data: NSDictionary)
    {
        lbWeekly = data["weekly"] as? NSArray
        lbTotal = data["total"] as? NSArray
        lbChanged()
    }
    
    @objc func lbChanged()
    {
        lbList.reloadData()
        // show the list
        lbList.isHidden = false
        // list height is a height of a row multiplied by the number of rows
        let listHeight = tableView(lbList, heightForRowAt: IndexPath(row: 0, section: 0)) * CGFloat(tableView(lbList, numberOfRowsInSection: 0))
        // leaderboard section height equals to top position of the list plus it's height
        let lbHeight = lbList.frame.origin.y + listHeight
        // content view height equals to top position of leaderboard view plus it's height plus margin
        contentViewHeight.constant = lbView.frame.origin.y + lbHeight + 16.0 * 2
        // layout content view
        contentView.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 44.0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let src = lbSelector.selectedSegmentIndex == 0 ? lbWeekly : lbTotal
        return src == nil ? 0 : src!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as! LeaderboardCell
        
        let src = lbSelector.selectedSegmentIndex == 0 ? lbWeekly : lbTotal
        let item = src![indexPath.row] as! NSDictionary
        let player = Player(data: item)
        
        let amount = item["total"] as! Int
        let amountFloat = Float(amount) / Float(100)
        let format = amountFloat.truncatingRemainder(dividingBy: 1.0) > 0 ? "%@%.2f" : "%@%.0f"
        
        cell.rankLabel.text = String(format: "%d", indexPath.row+1)
        cell.usernameLabel.text = player.username
        cell.amountLabel.text = String(format: format, Config.shared.data["app.currencySymbol"]!, amountFloat)
        
        player.setAvatar(cell.avatarImageView)
        
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (tableView.numberOfRows(inSection: indexPath.section) - 1) {
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0);
        } else {
            cell.separatorInset = UIEdgeInsets.zero
        }
    }
    
}


