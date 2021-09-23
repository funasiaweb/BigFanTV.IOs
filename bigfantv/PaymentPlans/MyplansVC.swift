//
//  MyplansVC.swift
//  bigfantv
//
//  Created by Ganesh on 31/08/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
 
class MyplansVC: UIViewController {

    @IBOutlet var TableV: UITableView!
    var movieuniqid = ""
    var planurl = ""
    var plandata:PlanList?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Subscription plans for user"
       
        let cellNib = UINib(nibName: "PlansCell", bundle: nil)
                             
                       TableV?.register(cellNib, forCellReuseIdentifier: "PlansCell")
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
extension MyplansVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return plandata?.list.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlansCell", for: indexPath) as? PlansCell
        {
           
            cell.LbTitle.text = self.plandata?.list[indexPath.row].name ?? ""
            cell.Btsubscribe.setTitle("\(self.plandata?.list[indexPath.row].currency?.symbol ?? "") \(self.plandata?.list[indexPath.row].price ?? "")", for: .normal)
            cell.Btsubscribe.tag = indexPath.row
            cell.Btsubscribe.addTarget(self, action: #selector(loadplan(_:)), for: .touchUpInside)
                       
            return cell
            
        }
        return UITableViewCell()
    }
    
    @objc func loadplan(_ sender:UIButton)
    {
        guard let userid =  UserDefaults.standard.string(forKey: "id") else {return}
        self.planurl = "https://bigfantv.com/en/rest/makeStripePayment?authToken=\(Keycenter.authToken)&user_id=\(userid)&plan_id=\(self.plandata?.list[sender.tag].id ?? "")&payment_type=4"
        self.performSegue(withIdentifier:  "toplan", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}
