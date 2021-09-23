//
//  LoginViewController.swift
//  Outquiz
//
//  Created by Vasily Evreinov on 07.03.2018.
//  Copyright © 2018 UniProgy s.r.o. All rights reserved.
//

import UIKit
 import FacebookCore
 import FacebookLogin
  
import AuthenticationServices

class LoginViewController: BaseViewController, UITextViewDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
                    
            let userIdentifier = appleIDCredential.user
            
            // weirdly apple issues a token which cannot be verified immediately, only a few seconds later
            // so we have to delay our call to server
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                self.login("apple", userIdentifier, idTokenString)
            }
        }
    }
    

    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var loginFacebookButton: UIButton!
    @IBOutlet weak var loginPhoneButton: UIButton!
    @IBOutlet weak var legalInfoTextView: UITextView!
    @IBOutlet weak var loginAppleButton: RoundedButton!
    
    // MARK: - Buttons actions
    
    @IBAction func loginAppleButtonTap(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            //request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    @IBAction func loginFacebookButtonTap(_ sender: Any) {
         
        FacebookCore.Settings.appID = Config.shared.data["facebook.client_id"]!
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: [.publicProfile], viewController: self, completion: { (loginResult) in
            switch loginResult {
            case .success(granted: _, declined: _, token: let token):
            
                self.login("facebook", token.userID, token.tokenString)
                break;
            default:
                break;
            }
        })
        
         
    }
    
    @IBAction func baclbttapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func loginPhoneButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Phone") as! PhoneViewController
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Login
    
    func login(_ type: String, _ id: String, _ verification: String)
    {
        API.login(type, id, verification, loginSuccess, failure)
    }
    
    func loginSuccess(_ data: NSDictionary)
    {
        let player = Player(data: data)
        Misc.currentPlayer = player
        
        // if no username provided - show profile editor
        if(Misc.currentPlayer?.username == nil)
        {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
        // show main screen otherwise
        else {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    // MARK: - UITextViewDelegate
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        var title = ""
        if URL.absoluteString == Misc.docUrl("terms")
        {
            title = NSLocalizedString("terms_of_use", comment: "")
        }
        else if URL.absoluteString == Misc.docUrl("privacy")
        {
            title = NSLocalizedString("privacy_policy", comment: "")
        }
        else if URL.absoluteString == Misc.docUrl("rules")
        {
            title = NSLocalizedString("rules", comment: "")
        }
        
        let navigationController = Misc.webView(title, URL.absoluteString)
        self.present(navigationController, animated: true, completion: nil)
        
        return false
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView()
    {
        // handle all translations
        sloganLabel.text = NSLocalizedString("Live BigFan Trivia Game Show", comment: "")
        loginFacebookButton.setTitle(NSLocalizedString("login_via_facebook", comment: ""), for: .normal)
        loginPhoneButton.setTitle(NSLocalizedString("Login via Phone", comment: ""), for: .normal)
        
        // design
        sloganLabel.textColor = UIColor(cfgName: "colors.text")
        loginFacebookButton.backgroundColor = UIColor(cfgName: "colors.login.button.background")
        loginFacebookButton.setTitleColor(UIColor(cfgName: "colors.login.button.text"), for: .normal)
        loginPhoneButton.backgroundColor = UIColor(cfgName: "colors.login.button.background")
        loginPhoneButton.setTitleColor(UIColor(cfgName: "colors.login.button.text"), for: .normal)
        loginAppleButton.backgroundColor = UIColor(cfgName: "colors.login.button.background")
        loginAppleButton.setTitleColor(UIColor(cfgName: "colors.login.button.text"), for: .normal)
        
        let termsOfUse = NSLocalizedString("terms_of_use", comment: "")
        let privacyPolicy = NSLocalizedString("privacy_policy", comment: "")
        let rules = NSLocalizedString("rules", comment: "")
        let legalMsg = String(format: NSLocalizedString("accept_terms", comment: ""), termsOfUse, privacyPolicy, rules)
        let legalMsgAttributed = NSMutableAttributedString(string: legalMsg)
        
        let range = NSRange(location: 0, length: legalMsgAttributed.length)
        
        let linkAttributes: [String : Any] = [
            NSAttributedString.Key.foregroundColor.rawValue: UIColor(cfgName: "colors.text").withAlphaComponent(0.5),
            NSAttributedString.Key.underlineColor.rawValue: UIColor(cfgName: "colors.text").withAlphaComponent(0.5),
            NSAttributedString.Key.underlineStyle.rawValue: NSUnderlineStyle.single.rawValue
        ]
        
        legalMsgAttributed.setCentered()
        legalMsgAttributed.addAttribute(.foregroundColor, value: UIColor(cfgName: "colors.text"), range: range)
        legalMsgAttributed.addAttribute(.font, value: UIFont.systemFont(ofSize: 16.0), range: range)
        legalMsgAttributed.setLink(termsOfUse, Misc.docUrl("terms"))
        legalMsgAttributed.setLink(privacyPolicy, Misc.docUrl("privacy"))
        legalMsgAttributed.setLink(rules, Misc.docUrl("rules"))
        
        legalInfoTextView.linkTextAttributes = convertToOptionalNSAttributedStringKeyDictionary(linkAttributes)
        legalInfoTextView.attributedText = legalMsgAttributed
        legalInfoTextView.delegate = self
        
        if #available(iOS 13.0, *) {
            // do nothing
        } else {
            loginAppleButton.isHidden = true
        }
    }
    
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
