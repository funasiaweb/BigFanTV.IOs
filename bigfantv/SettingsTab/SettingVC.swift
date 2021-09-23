//
//  SettingVC.swift
//  bigfantv
//
//  Created by Ganesh on 03/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import MaterialComponents.MaterialDialogs
class SettingVC: UIViewController {

    @IBOutlet var ImgProfile: UIImageView!
    @IBOutlet var Hideview: UIView!
    @IBOutlet var BtLogin: UIButton!


    @IBOutlet var LbEmail: UILabel!
    @IBOutlet var Lbname: UILabel!
    var Successdata:Userprofile?
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let username = UserDefaults.standard.string(forKey: "display_name")
        {
            print(username)
            Lbname.text = username
        }
        if let useremail = UserDefaults.standard.string(forKey:  "email")
              {
                  LbEmail.text = useremail
              }
         let tap1 = UITapGestureRecognizer(target: self, action: #selector(userprofile))
             ImgProfile.addGestureRecognizer(tap1)
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "isLoggedin") == true
        {
            self.Hideview.isHidden = true
        }else
        {
            self.Hideview.isHidden = false

        }
    }
    
    @objc func userprofile()
    {
        let alert = UIAlertController(title: "Please select a Picture from", message: nil, preferredStyle: .actionSheet)
               alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                   self.openCamera()
               }))
               
               alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                    self.openGallary()
                   
               }))
               alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
               
               //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
               switch UIDevice.current.userInterfaceIdiom {
               case .pad:
                   alert.popoverPresentationController?.sourceView = view
                  // alert.popoverPresentationController?.sourceRect = .
                   alert.popoverPresentationController?.permittedArrowDirections = .left
               default:
                   break
               }
              
               self.present(alert, animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.BtLogin.layer.cornerRadius = self.BtLogin.frame.size.height/2
        self.BtLogin.layer.borderWidth = 1
        self.BtLogin.layer.borderColor = UIColor.white.cgColor
               ImgProfile.layer.cornerRadius = ImgProfile.frame.size.height / 2
               ImgProfile.layer.borderColor = UIColor.white.cgColor
               ImgProfile.layer.borderWidth = 2
          
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (t) in
                        if Connectivity.isConnectedToInternet()
                        {
                            self.getuserdetails()
                            
                        }else
                        {
                            Utility.Internetconnection(vc: self)
                        }
                    }
    }
    @IBAction func Bttermsandconditionstapped()
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let VC1 = storyBoard.instantiateViewController(withIdentifier: "TermsandconditionsVC") as! TermsandconditionsVC
        VC1.isfrom = 0
       let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
       navController.navigationBar.barTintColor = Appcolor.backgorund4
       navController.modalPresentationStyle = .fullScreen
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
        navController.navigationBar.titleTextAttributes = textAttributes
       self.present(navController, animated:true, completion: nil)
    }
    @IBAction func Btaboutustapped()
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let VC1 = storyBoard.instantiateViewController(withIdentifier: "TermsandconditionsVC") as! TermsandconditionsVC
        VC1.isfrom = 1
       let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
       navController.navigationBar.barTintColor = Appcolor.backgorund4
       navController.modalPresentationStyle = .fullScreen
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
        navController.navigationBar.titleTextAttributes = textAttributes
       self.present(navController, animated:true, completion: nil)
        
    }
    @IBAction func navigatetoLogin()
    {
        let alertController = MDCAlertController(title: "BigFan TV", message:  "First Login or Register to save the settings")
        let action = MDCAlertAction(title:"Continue")
                                        { (action) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let displayVC = storyBoard.instantiateViewController(withIdentifier: "LaunchVC") as! LaunchVC
                              
            displayVC.modalPresentationStyle = .fullScreen
                                
          

            

           self.present(displayVC, animated: false, completion: nil)

        }
        let cancelaction = MDCAlertAction(title:"Cancel")
        { (cancelaction) in}
                            
        alertController.addAction(action)
                                
        alertController.addAction(cancelaction)

    self.present(alertController, animated: true, completion: nil)
    }
   func getuserdetails()
    {
         
        Api.getuserprofile( email: UserDefaults.standard.value(forKey: "email") as? String ?? "",   endpoint: ApiEndPoints.GetProfileDetails, vc: self) { (res, err) -> (Void) in
                       do
                       {
                           let decoder = JSONDecoder()
                             self.Successdata = try decoder.decode(Userprofile.self, from: res  ?? Data())
                           
                             if self.Successdata?.code == 200
                             {
                                self.ImgProfile.sd_setImage(with: URL(string: self.Successdata?.profileimage ?? ""), completed: nil)
                                UserDefaults.standard.set(self.Successdata?.profileimage ?? "", forKey: "profile_image")
                              
                             }
                          
                       }
                       catch let error
                       {
                           Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                       }
                   }
    }
    func openCamera(){
        
             if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                 imagePicker.sourceType = UIImagePickerController.SourceType.camera
                 //If you dont want to edit the photo then you can set allowsEditing to false
                 imagePicker.allowsEditing = true
                 imagePicker.delegate = self
                 self.present(imagePicker, animated: true, completion: nil)
             }
             else{
                 let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                 self.present(alert, animated: true, completion: nil)
             }
         }
         
         //MARK: - Choose image from camera roll
         
         func openGallary(){
      
             imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
             //If you dont want to edit the photo then you can set allowsEditing to false
             imagePicker.allowsEditing = true
             imagePicker.delegate = self
            // imagePicker.mediaTypes = [(kUTTypeMovie as String)]
             self.present(imagePicker, animated: true, completion: nil)
         }
    @IBAction func restoreInapppurchaseBtTApped(_ sender: UIButton) {
      if  PKIAPHandler.shared.canMakePurchases() == true
      {
        let alertController = MDCAlertController(title: Appcommon.Appname, attributedMessage: NSAttributedString(string:"Continue with Restore Purchase?",
         attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor,NSAttributedString.Key.font:  UIFont(name: "Muli-Bold", size: 16)!]))
        // let alertController = MDCAlertController(title: titelstring, message: message)
         let action = MDCAlertAction(title:"OK")
         { (action) in  print("ok")
            PKIAPHandler.shared.restorePurchase()
         }
        let cancel = MDCAlertAction(title: "Cancel") { (action) in
            print("cancelled")
        }
         alertController.addAction(action)
        alertController.addAction(cancel)
          self.present(alertController, animated: true, completion: nil)      }
    }
    @IBAction func LogoutBtTApped(_ sender: UIButton) {
        let alertController = MDCAlertController(title: Appcommon.Appname, attributedMessage: NSAttributedString(string:"Continue with Logout?",
         attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor,NSAttributedString.Key.font:  UIFont(name: "Muli-Bold", size: 16)!]))
        // let alertController = MDCAlertController(title: titelstring, message: message)
         let action = MDCAlertAction(title:"OK")
         { (action) in  print("ok")
            /*
              let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                */
           // UserDefaults.standard.removeObject(forKey: "email")
           // self.performSegue(withIdentifier: "logout", sender: self)
           // let domain = Bundle.main.bundleIdentifier!
         //   UserDefaults.standard.removePersistentDomain(forName: domain)
         //   UserDefaults.standard.synchronize()
         //   print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.set("", forKey: "id")
            UserDefaults.standard.set("", forKey: "AccessToken")

            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let displayVC = storyBoard.instantiateViewController(withIdentifier: "LaunchVC") as! LaunchVC
                              
            displayVC.modalPresentationStyle = .fullScreen
                                
          

            

           self.present(displayVC, animated: false, completion: nil)
         }
        let cancel = MDCAlertAction(title: "Cancel") { (action) in
            print("cancelled")
        }
         alertController.addAction(action)
        alertController.addAction(cancel)
          self.present(alertController, animated: true, completion: nil)
        
    
    }
    
   

         func setprofile(imagex:UIImage)
            {
             let image = imagex
             let imgData = image.jpegData(compressionQuality: 0.2)!

              let parameters = [ "authToken" : "\(Keycenter.authToken)",
                                 "user_id":"\(UserDefaults.standard.string(forKey: "id"))"] as [String : Any] //Optional for extra parameter
             let manager = Alamofire.SessionManager.default
                     manager.upload(multipartFormData: { multipartFormData in
                     multipartFormData.append(imgData, withName: "file",fileName: "file.jpg", mimeType: "image/jpg")
                     for (key, value) in parameters {
                             multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                         }
                        //Optional for extra parameters
                 },
             to:"https://cms.muvi.com/rest/UpdateUserProfileV1")
             { (result) in
                 switch result {
                 case .success(let upload, _, _):

                     upload.uploadProgress(closure: { (progress) in
                         print("Upload Progress: \(progress.fractionCompleted)")
                     })

                     upload.responseJSON { response in
                         
                        self.ImgProfile.image = imagex
                     }

                 case .failure(let encodingError):
                    
                     print(encodingError)
                 }
             }    }
         

    }
    extension SettingVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate
    {
        
          func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
              picker.isNavigationBarHidden = false
            
            
              self.dismiss(animated: true, completion: nil)
          }
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
            var selectedImage: UIImage!
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                       selectedImage = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                       selectedImage = image
                   }
       if Connectivity.isConnectedToInternet()
                          {
                              self.ImgProfile.image = selectedImage
                              setprofile(imagex: selectedImage)
                          }else
                          {
                              Utility.Internetconnection(vc: self)
                          }
        
        picker.dismiss(animated: true, completion: nil)
    }
    }
         public enum ImageFormat {
                  case png
                  case jpeg(CGFloat)
              }
        func convertImageTobase64q(format: ImageFormat, image:UIImage) -> String? {
            var imageData: Data?
            switch format {
            case .png: imageData = image.pngData()
            case .jpeg(let compression): imageData = image.jpegData(compressionQuality: compression)
            }
            return imageData?.base64EncodedString()
        }

