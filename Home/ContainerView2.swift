//  ScrollingStackController
//  Efficient Scrolling Container for UIViewControllers
//
//  Created by Daniele Margutti.
//  Copyright © 2017 Daniele Margutti. All rights reserved.
//
//	Web: http://www.danielemargutti.com
//	Email: hello@danielemargutti.com
//	Twitter: @danielemargutti
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

import Foundation
import UIKit

public class ContainerView2: UIViewController, StackContainable {
	
    

    @IBOutlet var CollectionV: UICollectionView!
    let cellIdentifier = "cell"
    var category = ""
    var subcategory = ""
     let imagearray =
        ["lang1","lang8", "lang11", "lang10", "lang9", "lang5", "lang7", "lang8","lang4","lang2","lang6"]
    let newarray =
        ["English","Hindi", "Punjabi", "Tamil", "Telugu", "Marathi", "Malayalam", "Bhojpuri","Gujarati","Bengali","Kannada"]
     let subcatearray = ["English","Hindi", "Punjabi", "Tamil", "Telugu", "Marathi", "Malyalam", "bhojpuri","Gujarati","Bengali","Kannada"]
    public static func create() -> ContainerView2 {
		return UIStoryboard(name: "Containers", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContainerView2") as! ContainerView2
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
        
         
               
	}
     @IBAction func BtsubscribeTapped(_ sender: UIButton) {
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let VC1 = storyBoard.instantiateViewController(withIdentifier: "MyplansVC") as! MyplansVC
            
      let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
     navController.navigationBar.barTintColor = Appcolor.backgorund3
         navController.navigationBar.isTranslucent = false
     navController.modalPresentationStyle = .fullScreen
     self.present(navController, animated:true, completion: nil)
     
     
     }
	
	public func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
		return .view(height: 50)
	}
	
}
extension ContainerView2:UICollectionViewDelegate,UICollectionViewDataSource
{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LnagCellFeatured
            Comedycell.ImgLang.image = UIImage(named: imagearray[indexPath.row])
            Comedycell.LbLang.text = newarray[indexPath.row]
           
        return Comedycell
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "ComedyViewAllVC") as! ComedyViewAllVC
          VC1.Movcategory = "language-1"
          VC1.MovSubcategory = subcatearray[indexPath.row]
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
        navController.navigationBar.barTintColor = Appcolor.backgorund3
        navController.modalPresentationStyle = .fullScreen
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
       navController.navigationBar.titleTextAttributes = textAttributes
        self.present(navController, animated:true, completion: nil)
    }
    
}
extension ContainerView2: UICollectionViewDelegateFlowLayout
{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          /*
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                return CGSize(width: collectionView.frame.size.height + 40, height:collectionView.frame.size.height)
            }
            else if UIDevice.current.userInterfaceIdiom == .phone
            {
                
                return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
                     
                   }
        */
        return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
            
           // return CGSize(width: 180, height: 280)
        }
     
   
    }
 
