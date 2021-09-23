//
//  CashoutViewController.swift
//  Outquiz
//
//  Created by Vasily Evreinov on 05.04.2018.
//  Copyright © 2018 UniProgy s.r.o. All rights reserved.
//

import UIKit

class CashoutViewController: BaseViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var paypalField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK - Properties
    var balance = 0
    
    // MARK - Buttons
    
    @IBAction func submitButtonTap(_ sender: Any)
    {
        let paypal = paypalField.text
        if(balance > 0 && paypal != nil && paypal != "")
        {
            submitButton.isEnabled = false
            swithNavButton("loading")
            API.cashout(paypal!, cashoutSuccess, failure)
        }
    }
    
    func cashoutSuccess(_ data: NSDictionary)
    {
        submitButton.isEnabled = true
        swithNavButton("done")
        let alert = UIAlertController(title: NSLocalizedString("cashout", comment: ""), message: NSLocalizedString("cashout_success", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: {(alert: UIAlertAction!) in
            self.closePopup()
        }))
        self.present(alert, animated: true)
    }
    
    override func failure(_ status: Int, _ errors: [String]) {
        submitButton.isEnabled = true
        swithNavButton("done")
        super.failure(status, errors)
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView()
    {
        // translations
        paypalField.text = ""
        paypalField.placeholder = NSLocalizedString("paypal_placeholder", comment: "")
        infoLabel.text = NSLocalizedString("paypal_info", comment: "")
        submitButton.setTitle(NSLocalizedString("cashout_button", comment: ""), for: .normal)
        balanceLabel.text = Misc.moneyFormat(balance)
        
        // look
        self.view.backgroundColor = UIColor(cfgName: "colors.system.background")
        infoLabel.textColor = UIColor(cfgName: "colors.system.text").withAlphaComponent(0.3)
        balanceLabel.textColor = UIColor(cfgName: "colors.system.text")
        paypalField.layer.cornerRadius = paypalField.frame.size.height / 2
        paypalField.layer.borderWidth = 1.0
        paypalField.layer.borderColor = UIColor(cfgName: "colors.system.text").withAlphaComponent(0.3).cgColor
        submitButton.layer.cornerRadius = submitButton.frame.size.height / 2
        submitButton.backgroundColor = UIColor(cfgName: "colors.system.button.background")
        submitButton.setTitleColor(UIColor(cfgName: "colors.system.button.text"), for: .normal)
        view.viewWithTag(1)?.tintColor = UIColor(cfgName: "colors.cashout.icon")
        
        // add "close on tap" functionality
        let closeTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(closeTap)
        
        // show cancel button
        swithNavButton("done")
    }
    
    @objc func dismissKeyboard() {
        if(paypalField.isFirstResponder)
        {
            view.endEditing(true)
        }
    }
    
    @objc func closePopup()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func swithNavButton(_ to: String)
    {
        if(to == "loading")
        {
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            activityIndicator.style = .gray
            let barButton = UIBarButtonItem(customView: activityIndicator)
            navigationItem.setRightBarButton(barButton, animated: true)
            activityIndicator.startAnimating()
        } else if (to == "done") {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closePopup))
        }
    }
}
