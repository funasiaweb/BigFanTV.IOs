//
//  PurchasehistoryVC.swift
//  bigfantv
//
//  Created by Ganesh on 17/10/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
class purchasecell:UITableViewCell{
    
    @IBOutlet var LbMONey: UILabel!
    @IBOutlet var LbTitle: UILabel!
    @IBOutlet var LbDuration: UILabel!
    @IBOutlet var LbIndex: UILabel!
    @IBOutlet var LbStatus: UILabel!
}
class PurchasehistoryVC: UIViewController {
    var purchasedata:PurchasehistoryList?
    @IBOutlet var TableV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableV.tableFooterView = UIView()
       // UserDefaults.standard.set("6737035", forKey: "id")
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
        Api.Getpurchasehistory(endpoint: ApiEndPoints.PurchaseHistory, vc: self) {  (res, err) -> (Void) in
                             do
                           {
                               let decoder = JSONDecoder()
                               self.purchasedata = try decoder.decode(PurchasehistoryList.self, from: res  ?? Data())
                               
                               self.TableV.delegate = self
                               self.TableV.dataSource  = self
                               DispatchQueue.main.async {
                                   
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
extension PurchasehistoryVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if purchasedata?.subComedymovList?.count ?? 0 <= 0
        {
            TableV.setEmptyView(title: "No purchase History Available")
        }else
        {
            TableV.restore()
        }
        return purchasedata?.subComedymovList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as? purchasecell
        {
            let item = purchasedata?.subComedymovList?[indexPath.row]
            cell.LbStatus.text = item?.statusppv
            cell.LbTitle.text = item?.plan_name
            //cell.LbIndex.text = "\(indexPath.row + 1) ."
            cell.LbDuration.text = "\(item?.currency_symbol ?? "") \(item?.amount ?? "") \(item?.currency_code ?? "")"
            cell.LbMONey.text = item?.transaction_date
          //  "\(item?.currency_symbol ?? "") \(item?.amount ?? "") \(item?.currency_code ?? "")"
            return cell
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
