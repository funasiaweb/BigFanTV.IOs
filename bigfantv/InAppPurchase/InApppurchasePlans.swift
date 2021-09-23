//
//  InApppurchasePlans.swift
//  bigfantv
//
//  Created by iOS on 13/07/2021.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs
import PassKit
import StoreKit
import MuviSDK

class inApppurchaseplansCell:UITableViewCell
{
    @IBOutlet var BtBuy: UIButton!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbDescription: UILabel!
    var actionBlock: (() -> Void)? = nil
   
    @IBAction func btBuytapped(_ sender: UIButton) {
        actionBlock?()
    }

    
}

class InApppurchasePlans: UIViewController
{

    @IBOutlet var TableV: UITableView!

    var productsArray = [SKProduct]()
    var movieId = ""
    var userid = ""
    var planId = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.userid = UserDefaults.standard.string(forKey: "id") ?? ""
    
        
       let Canmakepurchase = PKIAPHandler.shared.canMakePurchases()
        if Canmakepurchase
        {
            PKIAPHandler.shared.setProductIds(ids: ["\(planId)"])

            PKIAPHandler.shared.fetchAvailableProducts { [weak self](products)   in
               
                guard let sSelf = self else {return}
                
                sSelf.productsArray = products

                if sSelf.productsArray.count > 0
                {

                    DispatchQueue.main.async
                    {
                        sSelf.TableV.delegate = sSelf
                        sSelf.TableV.dataSource = sSelf
                        sSelf.TableV.reloadData()
                    }

                }
            }
            
        }else
        {
            Utility.showAlert(vc: self, message: "Cannot purchase the plan", titelstring: "")
         }
        

     }
    
  
 

}
 
extension InApppurchasePlans:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as? inApppurchaseplansCell
        {
            let item = self.productsArray[indexPath.row]
            cell.lbTitle.text = item.localizedTitle
            cell.lbDescription.text = item.localizedDescription
            cell.BtBuy.layer.cornerRadius = cell.BtBuy.frame.size.height/2
            cell.BtBuy.layer.borderWidth = 0
            cell.BtBuy.layer.borderColor = UIColor.white.cgColor
            cell.actionBlock = {() in
                
                PKIAPHandler.shared.purchase(product: self.productsArray[indexPath.row]) { (alert, product, transaction) in
                   if let tran = transaction, let prod = product
                   {
                     //use transaction details and purchased product as you want
                    let input = InAppPpvPaymentInput(userId: self.userid, movieId: self.movieId)
                  
                    MuviAPISDK.controller.inAppPpvPaymentDataTask(input) { (result) in
                        switch result
                        {
                        case .success(let output, let response):
                            print("output ::: \(response)")
                        case .failure(let error):
                            print("error \(error.errorDescription)")
                        }
                    }
                   
                   }
                 //  Globals.shared.showWarnigMessage(alert.message)
                   }
                
            }

            
            return cell
        }
    return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
