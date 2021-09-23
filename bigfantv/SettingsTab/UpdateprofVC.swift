//
//  UpdateprofVC.swift
//  bigfantv
//
//  Created by Ganesh on 16/10/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MDCButton
import Alamofire
import SDWebImage
class UpdateprofVC: UIViewController {
 @IBOutlet var ImgProfile: UIImageView!
    
    @IBOutlet var BtSubmit: MDCButton!
    @IBOutlet var Tfname: UITextField!
      var imagePicker = UIImagePickerController()
    var selectedimageas:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let username = UserDefaults.standard.string(forKey: "display_name")
               {
                    Tfname.text = username
               }
        self.ImgProfile.sd_setImage(with: URL(string:UserDefaults.standard.string(forKey: "profile_image") ?? ""), completed: nil)
       
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(userprofile))
                
        ImgProfile.addGestureRecognizer(tap1)
        
              let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapped))
                 view.addGestureRecognizer(tap2)
        }
    
    @objc func tapped()
    {
       // view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
                  ImgProfile.layer.cornerRadius = ImgProfile.frame.size.height / 2
                  ImgProfile.layer.borderColor = UIColor.white.cgColor
                  ImgProfile.layer.borderWidth = 2
             
        
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
                       alert.popoverPresentationController?.sourceRect = CGRect(x: view.center.x, y: view.center.y, width: 0, height: 0)
                       alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                   default:
                       break
                   }
                  
                   self.present(alert, animated: true, completion: nil)
        }
    
    @IBAction func BtSubmitTapped(_ sender: MDCButton) {
   
    if Connectivity.isConnectedToInternet()
                       {
                        setprofile(imagex:ImgProfile.image ?? UIImage())
                       }else
                       {
                           Utility.Internetconnection(vc: self)
                       }
     
    
    }

    func setprofile(imagex:UIImage)
       {
        let image = imagex
        let imgData = image.jpegData(compressionQuality: 0.2)!

         let parameters = [ "authToken" : "\(Keycenter.authToken)",
            "user_id":"\(UserDefaults.standard.string(forKey: "id") ?? "")",
            "name":Tfname.text ?? ""] as [String : Any] //Optional for extra parameter
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
                    UserDefaults.standard.set(self.Tfname.text ?? "", forKey: "display_name")
                                self.dismiss(animated: true, completion: nil)
                })

                upload.responseJSON { response in
                    
                   self.ImgProfile.image = imagex
                }

            case .failure(let encodingError):
               
                print(encodingError)
            }
           
        }    }
}
extension UpdateprofVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate
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
    
                           self.ImgProfile.image = selectedImage
                           selectedimageas  = selectedImage
                       
     
     picker.dismiss(animated: true, completion: nil)
 }
 }
      
