//
//  ListPlansVC.swift
//  bigfantv
//
//  Created by Ganesh on 02/09/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs
class ListPlansVC: UIViewController {

    @IBOutlet var TableV: UITableView!
    
    var plandata:MyPlanList?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "Myplanscell", bundle: nil)
                      
                TableV?.register(cellNib, forCellReuseIdentifier: "Myplanscell")
                TableV?.backgroundColor = Appcolor.backgorund3
                TableV?.allowsMultipleSelection = true
                TableV.tableFooterView = UIView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
                  
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (t) in
                       if Connectivity.isConnectedToInternet()
                       {
                        self.GetAllplans()
                       }else
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
                    
            Api.getMyplanlist( endpoint: ApiEndPoints.MyPlans, vc: self)  { (res, err) -> (Void) in
                            do
                            {
                                let decoder = JSONDecoder()
                                self.plandata = try decoder.decode(MyPlanList.self, from: res  ?? Data())
                                if self.plandata?.list?.count ?? 0 > 0
                                {
                                if self.plandata?.status == "Ok"
                                {
                                self.TableV.delegate = self
                                self.TableV.dataSource  = self
                                DispatchQueue.main.async
                                    {
                                    self.TableV.reloadData()
                                    }
                                }
                                }else
                                {
                                    let alertController = MDCAlertController(title: "BigFan TV", message: "You are not subscribed to any plan.Please subscribe.")
                                         
                                    alertController.cornerRadius = 4
                                    alertController.buttonTitleColor = Appcolor.backgorund3
                                    alertController.addAction(MDCAlertAction(title: "Ok", handler: { (action) in
                                       // self.performSegue(withIdentifier: "toplans", sender: self)
                                    }))
                                    alertController.addAction(MDCAlertAction(title: "Cancel", handler: { (action) in
                                        alertController.dismiss(animated: true) {
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                    }))
                                    
                                      self.present(alertController, animated: true, completion: nil)
                                    
                                    
                                }
                               
                            }
                            catch let error
                            {
                                Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                            }
                        }
              }
      
        
    @IBAction func Upgradeplantapped(_ sender: UIButton)
    {
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let VC1 = storyBoard.instantiateViewController(withIdentifier: "UpgradePlanVC") as! UpgradePlanVC
           
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
        navController.navigationBar.barTintColor = Appcolor.backgorund3
        navController.modalPresentationStyle = .fullScreen
         let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
         navController.navigationBar.titleTextAttributes = textAttributes
        self.present(navController, animated:true, completion: nil)
    }
    
    }
    extension ListPlansVC:UITableViewDelegate,UITableViewDataSource
    {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if plandata?.list?.count ?? 0 <= 0
                   {
                       TableV.setEmptyView(title: "No plans found")
                   }else
                   {
                       TableV.restore()
                   }
            return plandata?.list?.count ?? 0
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Myplanscell", for: indexPath) as? Myplanscell
            {
                cell.Title.text = self.plandata?.list?[indexPath.row].name ?? ""
               // cell.BtUpgrade.tag = indexPath.row
               // cell.BtUpgrade.addTarget(self, action: #selector(upgradeplan(_:)), for: .touchUpInside)
                cell.LbDetails.text =  "\(self.plandata?.list?[indexPath.row].currency?.symbol ?? "") \(self.plandata?.list?[indexPath.row].price ?? "")"
               return cell
            }
                       return UITableViewCell()
            
        }
        @objc func upgradeplan( _ sender:UIButton)
        {
             let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
              let VC1 = storyBoard.instantiateViewController(withIdentifier: "UpgradePlanVC") as! UpgradePlanVC
               
            let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
            navController.navigationBar.barTintColor = Appcolor.backgorund3
            navController.modalPresentationStyle = .fullScreen
             let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
             navController.navigationBar.titleTextAttributes = textAttributes
            self.present(navController, animated:true, completion: nil)
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 240
        }
    }





































