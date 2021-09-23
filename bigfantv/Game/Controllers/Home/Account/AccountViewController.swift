//
//  AccountViewController.swift
//  Outquiz
//
//  Created by Vasily Evreinov on 19/03/2019.
//  Copyright © 2019 Vasily Evreinov. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var avatarImageView: RoundedImageView!
    @IBOutlet weak var usernameField: PaddingTextField!
    @IBOutlet weak var usernameSubmit: RoundedButton!
    @IBOutlet weak var referralCodeLabel: UILabel!
    @IBOutlet weak var referralCodeField: PaddingTextField!
    @IBOutlet weak var referralCodeSubmit: RoundedButton!
    @IBOutlet weak var inviteButton: RoundedButton!
    @IBOutlet weak var suggestButton: RoundedButton!
    @IBOutlet weak var logoutButton: RoundedButton!
    
    // MARK: - Buttons
    
    @IBAction func inviteButtonTap(_ sender: Any) {
        let shareText = String(format:NSLocalizedString("share_text", comment: ""),
                               Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String,
                               Misc.currentPlayer!.referral!,
                               Config.shared.data["app.host"]!)
        
        let activityController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func suggestButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Suggest", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! SuggestViewController
        let navigationController = UINavigationController(rootViewController: controller)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonTap(_ sender: Any) {
        Misc.logout()
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        
        // colors
        self.view.backgroundColor = UIColor(cfgName: "colors.system.background")
        roundField(usernameField)
        roundField(referralCodeField)
        usernameSubmit.backgroundColor = UIColor(cfgName: "colors.system.button.background")
        referralCodeSubmit.backgroundColor = UIColor(cfgName: "colors.system.button.background")
        colorButton(inviteButton, "colors.account.button.background", "colors.account.button.text", true)
        colorButton(suggestButton, "colors.account.button.background", "colors.account.button.text", true)
        colorButton(logoutButton, "colors.logout.button.background", "colors.logout.button.text", false)
        
        // fill in labels and available data, such as avatar
        Misc.currentPlayer?.setAvatar(avatarImageView)
        usernameField.text = Misc.currentPlayer?.username
        usernameField.placeholder = NSLocalizedString("choose_username", comment: "")
        referralCodeLabel.text = NSLocalizedString("apply_referral_code", comment: "").uppercased()
        referralCodeField.placeholder = NSLocalizedString("referral_code", comment: "")
        inviteButton.setTitle(NSLocalizedString("invite", comment: ""), for: .normal)
        logoutButton.setTitle(NSLocalizedString("logout", comment: ""), for: .normal)
        suggestButton.setTitle(NSLocalizedString("suggest_trivia", comment: ""), for: .normal)
        
        // enable tap on avatar to show menu
        avatarImageView.isUserInteractionEnabled = true
        let avatarTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showAvatarMenu))
        avatarImageView.addGestureRecognizer(avatarTap)
        
        // done button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closePopup))
        
        // add "close on tap" functionality
        let closeTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(closeTap)
    }
    
    @objc func closePopup()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        if(usernameField.isFirstResponder || referralCodeField.isFirstResponder) {
            view.endEditing(true)
        }
    }
    
    func roundField(_ textField: UITextField) {
        textField.layer.cornerRadius = textField.frame.size.height / 2
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(cfgName: "colors.system.button.background").cgColor
    }
    
    func colorButton(_ button: UIButton, _ background: String, _ text: String, _ border: Bool) {
        button.backgroundColor = UIColor(cfgName: background)
        button.setTitleColor(UIColor(cfgName: text), for: .normal)
        if(border) {
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor(cfgName: text).cgColor
        }
    }
    
    // MARK: - Avatar
    
    @objc func showAvatarMenu()
    {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("new_photo", comment: ""), style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("camera_roll", comment: ""), style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        
        if(Misc.currentPlayer?.avatar != nil)
        {
            alert.addAction(UIAlertAction(title: NSLocalizedString("delete_avatar", comment: ""), style: .default, handler: { (action) in
                API.avatar(nil, self.uploadSuccess, self.failure)
            }))
        }
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: { (action) in
            // do nothing, it's cancelled
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // show loading indicator
        let center = avatarImageView.frame.width / 2 - 10
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: center, y: center, width: 20, height: 20))
        activityIndicator.style = .white
        activityIndicator.tag = 99
        avatarImageView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        // upload image
        let image = info[.editedImage] as! UIImage
        let imageData = image.jpegData(compressionQuality: 1.0)
        API.avatar(imageData!, uploadSuccess, failure)
        dismiss(animated:true, completion: nil)
    }
    
    func uploadSuccess(_ data: NSDictionary)
    {
        // remove loading indicator
        avatarImageView.viewWithTag(99)?.removeFromSuperview()
        
        // update player info
        var player = Misc.currentPlayer!
        player.token = data["token"] as? String
        player.avatar = data["avatar"] as? String
        // save as current player
        Misc.currentPlayer = player
        // update preview
        Misc.currentPlayer?.setAvatar(avatarImageView, refresh: true)
    }
    
    override func failure(_ status: Int, _ errors: [String]) {
        // remove loading indicator
        avatarImageView.viewWithTag(99)?.removeFromSuperview()
        super.failure(status, errors)
    }
    
    // MARK: - Username
    
    @IBAction func usernameSubmitTap(_ sender: Any) {
        API.profile(self.usernameField.text ?? "", profileSuccess, failure)
    }
    
    @objc func profileSuccess(_ data: NSDictionary)
    {
        // update player info
        var player = Misc.currentPlayer!
        player.token = data["token"] as? String
        player.username = data["username"] as? String
        // save as current player
        Misc.currentPlayer = player
        
        let alert = UIAlertController(title: NSLocalizedString("account", comment: ""), message: NSLocalizedString("profile_updated", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: {(action) in
            // do nothing
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Referral Code
    
    @IBAction func referralCodeSubmitTap(_ sender: Any) {
        applyReferralCode(code: referralCodeField.text ?? "")
    }
    
    func applyReferralCode(code: String)
    {
        API.referral(code, referralSuccess, failure)
    }
    
    func referralSuccess(_ data: NSDictionary)
    {
        let alert = UIAlertController(title: NSLocalizedString("referral_code", comment: ""), message: NSLocalizedString("referral_code_success", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: {(alert: UIAlertAction!) in
            // close
        }))
        self.present(alert, animated: true)
    }
}
