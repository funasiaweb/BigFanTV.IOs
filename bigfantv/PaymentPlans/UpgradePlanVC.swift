//
//  MyplansVC.swift
//  bigfantv
//
//  Created by Ganesh on 31/08/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs
 
class UpgradePlanVC: UIViewController {

    @IBOutlet var TableV: UITableView!
    var movieuniqid = ""
    var planurl = ""
    var plandata:PlanList?
      private var Successdata:SuccessResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Upgrade plans for user"
       
        let cellNib = UINib(nibName: "UpgradeplanCell", bundle: nil)
                             
                       TableV?.register(cellNib, forCellReuseIdentifier: "UpgradeplanCell")
                       TableV?.backgroundColor = Appcolor.backgorund3
                       TableV?.allowsMultipleSelection = true
                       TableV.tableFooterView = UIView()
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
              
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false)
        { (t) in
                   if Connectivity.isConnectedToInternet()
                   {
                    self.GetAllplans()
                   }
                   else
                   {
                       Utility.Internetconnection(vc: self)
                   }
               }
       
                    let viewright = UIView(frame: CGRect(x:  0, y: 0, width: 50,height: 30))
                       viewright.backgroundColor = UIColor.clear
           
                    let  button4 = UIButton(frame: CGRect(x: 0,y: 0, width: 30, height: 30))
                         button4.setImage(UIImage(named: "backarrow"), for: UIControl.State.normal)
                         button4.setTitle("close", for: .normal)
                         button4.addTarget(self, action: #selector(close), for: UIControl.Event.touchUpInside)
                   
                       viewright.addSubview(button4)
                                   
                       let leftbuttton = UIBarButtonItem(customView: viewright)
                        self.navigationItem.leftBarButtonItem = leftbuttton
                              
       }
                              @objc func close()
                              {
                                  self.dismiss(animated: true, completion: nil)
                              }
    func GetAllplans()
    {
               //subscribe to a plan to view this content
        Api.getStudioplanlist(movieuniqid, endpoint: ApiEndPoints.GetStudioPlanLists, vc: self)  { (res, err) -> (Void) in
                        do
                        {
                            let decoder = JSONDecoder()
                            self.plandata = try decoder.decode(PlanList.self, from: res  ?? Data())
                            
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
        if segue.identifier == "toplan"
                   {
                    guard let navController = segue.destination as? UINavigationController,
                                                        let displayVC = navController.topViewController as? SubscribePlanVC else {
                                                            return
                                                    }
                                          
                           displayVC.planurl = planurl
                                            
                    
                 }
        
      
        }
    

}
extension UpgradePlanVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return plandata?.list.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UpgradeplanCell", for: indexPath) as? UpgradeplanCell
        {
           
            cell.LbTitle.text = self.plandata?.list[indexPath.row].name ?? ""
            cell.Btsubscribe.setTitle("\(self.plandata?.list[indexPath.row].currency?.symbol ?? "") \(self.plandata?.list[indexPath.row].price ?? "")", for: .normal)
            
            cell.BtUpgrade.tag = indexPath.row
            cell.BtUpgrade.addTarget(self, action: #selector(loadplan(_:)), for: .touchUpInside)
                       
            return cell
            
        }
        return UITableViewCell()
    }
    
    @objc func loadplan(_ sender:UIButton)
    {
        Api.Updatestripepayment(self.plandata?.list[sender.tag].id ?? "", endpoint: ApiEndPoints.updateStripePayment, vc: self)  { (res, err) -> (Void) in
                                    do
                                    {
                                        let decoder = JSONDecoder()
                                        self.Successdata = try decoder.decode(SuccessResponse.self, from: res  ?? Data())
                                        if self.Successdata?.code == 200
                                        {

                                            let alertController = MDCAlertController(title: Appcommon.Appname, attributedMessage: NSAttributedString(string:"Plan upgraded successfully",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor,NSAttributedString.Key.font:  UIFont(name: "Muli-Bold", size: 16)!]))
                                            alertController.cornerRadius = 4
                                            alertController.buttonTitleColor = Appcolor.backgorund3
                                            alertController.addAction(MDCAlertAction(title: "Ok", handler: { (action) in
                                               self.dismiss(animated: true, completion: nil)
                                            }))
                                            
                                              self.present(alertController, animated: true, completion: nil)
                                         
                                          
                                            
                                        }else
                                        {
                                            Utility.showAlert(vc: self, message: self.Successdata?.msg ?? "", titelstring:Appcommon.Appname)
                                        }
                                       
                                    }
                                    catch let error
                                    {
                                        Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                    }
                                }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}
