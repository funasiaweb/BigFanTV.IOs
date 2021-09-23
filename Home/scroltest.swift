//  ScrollingStackController
//  Efficient Scrolling Container for UIViewControllers
//
//  Created by Daniele Margutti.
//  Copyright © 2017 Daniele Margutti. All rights reserved.
//
//    Web: http://www.danielemargutti.com
//    Email: hello@danielemargutti.com
//    Twitter: @danielemargutti
//
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.

import UIKit

class scroltest: ScrollingStackController {

    var controller_1: ContainerList = ContainerList.create()
    var controller_2: ContainerView = ContainerView.create()
 //   var controller_3: ContainerView2 = ContainerView2.create()
     var controller_4: Radiocontainer = Radiocontainer.create()
     var controller_5: StaticMovies = StaticMovies.create()
    var controller_6: BannerVC = BannerVC.create()
    var controller_7: BannerVC = BannerVC.create()
    var timer = Timer()
    var counter = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
    
        Utility.ShowLoader(vc: self)
             
        self.viewControllers = [controller_2,controller_7, controller_1,controller_6, controller_5 ]
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (t) in
                    self.reload()
                    
                })
        
        
        Utility.configurscollview(scrollV: self.scrollView!)
        self.scrollView!.refreshControl?.addTarget(self, action:
                                           #selector(handleRefreshControl),
                                           for: .valueChanged)
            
          
          }
           
           @objc func handleRefreshControl() {
              // Update your content…
            self.scrollView?.refreshControl?.beginRefreshing()
           
               if Connectivity.isConnectedToInternet()
               {
                  Preload()
               }else
               {
                   Utility.Internetconnection(vc: self)
               }
                   DispatchQueue.main.async {
                    self.scrollView?.refreshControl?.endRefreshing()
              }
           }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Connectivity.isConnectedToInternet()
        {
            controller_5.GetFavlist()
            controller_4.Getimagelist { (trues) in
                if trues{
                    self.viewControllers = [self.controller_2,self.controller_4,self.controller_7, self.controller_1,self.controller_6, self.controller_5 ]
                }else
                {
                     self.viewControllers = [self.controller_2 ,self.controller_7, self.controller_1,self.controller_6, self.controller_5 ]
                }
            }
 
        }
        
        //reloadfav()
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
      
     
    }
    
    func Preload()
    {
        self.viewControllers = [controller_2,controller_4,controller_7, controller_1,controller_6, controller_5 ]
        Utility.hideLoader(vc: self)
    }
   
    func reload()
    {
        if controller_1.isloaded == true
        {
             Utility.hideLoader(vc: self)
            if controller_4.isradioavailable == 1
            {
            self.viewControllers = [controller_2,controller_4,controller_7, controller_1,controller_6, controller_5 ]
            }else
            {
                 self.viewControllers = [controller_2 ,controller_7, controller_1,controller_6, controller_5 ]
            }
            timer.invalidate()
        }else
        {
                self.viewControllers = [controller_2 ,controller_7]
        }
        
    }

  
    
}

