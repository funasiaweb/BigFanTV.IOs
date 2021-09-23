//
//  Misc.swift
//  Outquiz
//
//  Created by Vasily Evreinov on 10.03.2018.
//  Copyright © 2018 UniProgy s.r.o. All rights reserved.
//

import UIKit
import AVFoundation

class Misc {
    
    private static var _currentPlayer: Player?
    
    static var currentPlayer: Player? {
        get {
            if self._currentPlayer == nil
            {
                self._currentPlayer = self.getPlayer()
            }
            return self._currentPlayer
        }
        set(player) {
            self._currentPlayer = player
            self.savePlayer(player)
        }
    }
    
    class func saveToken(_ token: String)
    {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(token, forKey: "pushNotiToken")
    }
    
    class func getToken() -> String? {
        let defaults:UserDefaults = UserDefaults.standard
        if let token:String = defaults.string(forKey: "pushNotiToken" )
        {
            return token
        }
        return nil
    }
    
    class func savePlayer(_ player: Player?)
    {
        let defaults:UserDefaults = UserDefaults.standard
        if(player != nil)
        {
            defaults.set(player!.getDictionary(), forKey: "currentPlayer")
        } else {
            defaults.removeObject(forKey: "currentPlayer")
        }
    }
    
    class func getPlayer() -> Player?
    {
        let defaults:UserDefaults = UserDefaults.standard
        if let dict = defaults.dictionary(forKey: "currentPlayer" )
        {
            return Player(data: dict as NSDictionary)
        }
        return nil
    }
    
    class func logout()
    {
        // empty stored user
        self.currentPlayer = nil
        // rollback to initial controller
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    class func docUrl(_ type: String) -> String
    {
        let host = Config.shared.data["app.host"]!
        switch type {
        case "terms":
            return host+"/page/terms"
        case "privacy":
            return host+"/page/privacy"
        case "faq":
            return host+"/page/faq"
        case "rules":
            return host+"/page/rules"
        default:
            return host
        }
    }
    
    class func moneyFormat(_ amount: Int) -> String
    {
        let amountFloat = Float(amount) / Float(100)
        let format = amountFloat.truncatingRemainder(dividingBy: 1.0) > 0 ? "%@%.2f" : "%@%.0f"
        return String(format: format, Config.shared.data["app.currencySymbol"]!, amountFloat)
    }
    
    class func soundURL(_ type: String) -> URL? {
        switch type {
        case "question":
            return Bundle.main.url(forResource: "question", withExtension: "mp3")
        case "timer":
            return Bundle.main.url(forResource: "timer", withExtension: "mp3")
        case "winner":
            return Bundle.main.url(forResource: "winner", withExtension: "mp3")
        // click as default
        default:
            return Bundle.main.url(forResource: "click", withExtension: "mp3")
        }
    }
    
    class func webView(_ title: String, _ url: String) -> UINavigationController {
        let storyboard = UIStoryboard(name: "WebView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! WebViewController
        controller.docTitle = title
        controller.docUrl = URL(string: url)
        return UINavigationController(rootViewController: controller)
    }
}
