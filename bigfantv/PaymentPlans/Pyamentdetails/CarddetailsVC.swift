//
//  CarddetailsVC.swift
//  bigfantv
//
//  Created by Ganesh on 17/10/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit

class CarddetailsVC: UIViewController {
    var CardDatadetails:CardData?
     @IBOutlet var TableV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        TableV.tableFooterView = UIView()
    }
    

    override func viewDidAppear(_ animated: Bool) {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (t) in
                if Connectivity.isConnectedToInternet()
                {
                   self.getpurchasehistory()
                }else
                {
                    Utility.Internetconnection(vc: self)
                }
            }
        }
    
    
       func getpurchasehistory()
       {
           Api.Getpurchasehistory(endpoint: ApiEndPoints.GetCardsListForPPV, vc: self) {  (res, err) -> (Void) in
                                do
                              {
                                  let decoder = JSONDecoder()
                                  self.CardDatadetails = try decoder.decode(CardData.self, from: res  ?? Data())
                                   self.TableV.delegate = self
                                  self.TableV.dataSource  = self
                                  DispatchQueue.main.async
                                    {
                                      
                                      self.TableV.reloadData()
                                  }
                                  
                                  
                              }
                                catch let error
                                   {
                                       Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                   }
                               }
       }

}

extension CarddetailsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CardDatadetails?.subComedymovList?.count ?? 0 <= 0
        {
            TableV.setEmptyView(title: "No Card details Available")
        }else
        {
            TableV.restore()
        }
        return CardDatadetails?.subComedymovList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as? purchasecell
        {
            let item = CardDatadetails?.subComedymovList?[indexPath.row]
         //   cell.LbStatus.text = item?.statusppv
            
           
            cell.LbTitle.text = item?.card_holder_name
            cell.LbIndex.text =   (item?.card_last_fourdigit ?? "") 
            
            cell.LbMONey.text = "Valid Upto ##/##"
            return cell
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 240
    }
}
