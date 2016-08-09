//
//  RegistrationViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 7/5/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
import CoreData
import Firebase

class RegistrationViewController: UIViewController, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDelegate,UITextFieldDelegate {
    
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var btnPhoto: UIButton!

    @IBOutlet weak var txtNationality: UITextField!
    @IBOutlet weak var segmentUserType: UISegmentedControl!
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var segmentSex: UISegmentedControl!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPW: UITextField!
    @IBOutlet weak var txtPW2: UITextField!
    
    @IBOutlet weak var txtViewLanguage: UITextView!
    let imagePicker = UIImagePickerController()
    
    var isRegistrationDone:Bool = false

    @IBAction func DoneSelection(sender:UIStoryboardSegue)
    {
        var selectedLang:String = ""
        var selectedRows = [Int]()
        
        let source = sender.sourceViewController as! LanguageTableViewController
        
        selectedRows = source.LangTableView.indexPathsForSelectedRows!.map{$0.row}
        
        if selectedRows.count > 0
        {
            
            var i = 0
            
            while i < selectedRows.count {
                
                selectedLang = selectedLang + ", \(source.LanguageList[selectedRows[i]])"
                
                i += 1
            }
            
            
            
            //txtViewLanguage.text = selectedLang.substringFromIndex(selectedLang.endIndex.advancedBy(selectedLang.endIndex - 3))
            
            txtViewLanguage.text = selectedLang.substringWithRange(
                selectedLang.startIndex.advancedBy(2)..<selectedLang.endIndex)
        }
        else
        {
            txtViewLanguage.text = ""
        }
        
    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        

        if sender.description.containsString("UIButton") == true && identifier == nil {
            
        var isTourist:Bool
        var sex:String
        
        var alert:UIAlertController
        
        if segmentUserType.selectedSegmentIndex == 0
        {
            isTourist = true
        }
        else
        {
            isTourist = false
        }
        
        if segmentSex.selectedSegmentIndex == 0
        {
            sex = "Male"
        }
        else
        {
            sex = "Female"
        }
        
        if self.imgPhoto.image == nil
        {
            
            alert = UIAlertController(title: "Alert", message:
                "Please choose a photo first.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: false, completion: nil)
            
            return false
        }
            
        else if self.txtLastname.text!.isEmpty || txtFirstname.text!.isEmpty || txtEmail.text!.isEmpty || txtPhone.text!.isEmpty || txtNationality.text!.isEmpty || txtPW.text!.isEmpty || txtPW2.text!.isEmpty || txtViewLanguage.text!.isEmpty
        {
            
            alert = UIAlertController(title: "Alert", message:
                "Please fill out all fields.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: false, completion: nil)
            
            return false
        }
            //                else if (txtEmail.text!.containsString("@") == false && txtEmail.text!.containsString(".") == false)
            //        {
            //            alert = UIAlertController(title: "Alert", message:
            //                "Invalid email address.", preferredStyle: UIAlertControllerStyle.Alert)
            //
            //            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            //
            //            self.presentViewController(alert, animated: false, completion: nil)
            //        }
        else if txtPW.text! != txtPW2.text!
        {
            alert = UIAlertController(title: "Alert", message:
                "Passwords do not match.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: false, completion: nil)
            
            return false
        }
        else
        {
            
            self.saveUser(self.txtLastname.text!, firstname: txtFirstname.text!, email: txtEmail.text!, isTourist:isTourist, phone:txtPhone.text!,nationality:txtNationality.text!,language:txtViewLanguage.text!,sex:sex, pw:txtPW.text!)
            
            if isRegistrationDone == true
            {
                return true
            }
            else
            {
                return false
            }
        }
        }
        
        return true
        
    }
    
    @IBAction func btnRegister_Click(sender: AnyObject) {
        
        
    }

     var pickOption = [" ","Canada", "China", "France", "Germany", "Italy", "Japan", "Korea", "Malaysia", "Singapore",  "Spain", "U.K.", "U.S.A."]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let picker: UIPickerView
        picker = UIPickerView(frame: CGRectMake(0, 200, view.frame.width, 200))
        picker.backgroundColor = .whiteColor()
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        txtNationality.inputView = picker
        txtNationality.inputAccessoryView = toolBar
        
        
        imagePicker.delegate = self
        
        self.txtEmail.returnKeyType = .Done
        self.txtFirstname.returnKeyType = .Done
        self.txtLastname.returnKeyType = .Done
        self.txtPhone.returnKeyType = .Done
        self.txtPW.returnKeyType = .Done
        self.txtPW2.returnKeyType = .Done
        

        self.txtEmail.delegate = self
        self.txtFirstname.delegate = self
        self.txtLastname.delegate = self
        self.txtPhone.delegate = self
        self.txtPW.delegate = self
        self.txtPW2.delegate = self
        
        
//        var pickerView = UIPickerView()
//        
//        pickerView.delegate = self
//        
//        txtNationality.inputView = pickerView
        
        ref = FIRDatabase.database().reference()


        // Do any additional setup after loading the view.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtNationality.text = pickOption[row]
    }
    
    func donePicker() {
        
        txtNationality.resignFirstResponder()
        
    }

    

    
    @IBAction func btnPhotoClick(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera)
        {
        
            let alertController = UIAlertController(title: "Pick Source", message: nil, preferredStyle: .ActionSheet)
            
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .Default) { (action) in
                
                self.imagePicker.sourceType = .PhotoLibrary
                self.imagePicker.allowsEditing = true
                
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
                
            }
            
            alertController.addAction(photoLibraryAction)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
                
                self.imagePicker.sourceType = .Camera
                self.imagePicker.allowsEditing = true
                
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
                
            }
            alertController.addAction(cameraAction)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            
            presentViewController(alertController, animated: true, completion: nil)
        
        }
        else
        {
            //self.imagePicker.sourceType = .PhotoLibrary
            self.imagePicker.allowsEditing = true
            
            
            presentViewController(self.imagePicker, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            imgPhoto.contentMode = .ScaleAspectFit
            imgPhoto.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    var userObj = [NSManagedObject]()
    
    
    func saveRec(lastname: String, firstname: String, email: String) {
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Test",
                                                        inManagedObjectContext:managedContext)
        
        let users = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        
        //3
        users.setValue(lastname, forKey: "lastname")
        users.setValue(lastname, forKey: "firstname")
        users.setValue(lastname, forKey: "email")
        
        //4
        do {
            try managedContext.save()
            //5
            userObj.append(users)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    var base64string:NSString!
    
    func saveUser(lastname: String, firstname: String, email: String, isTourist:Bool, phone:String, nationality:String, language:String, sex:String, pw:String) {
        
        
        FIRAuth.auth()?.createUserWithEmail(email, password: pw, completion: { (user, error) in
            //print(error)
            //print("created")
            if error == nil
            {
                var img:UIImage = self.imgPhoto.image!
                
                
                var imgData:NSData = UIImagePNGRepresentation(img)!
                
                self.base64string = imgData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
                
                //var quotestring = ["string":self.base64string]
                
                //1
                let key = self.ref.child("users").childByAutoId().key
                
                //let key = "-" + email
                
                let user = [
                    "uid":key,
                    "lastname":lastname,
                    "firstname":firstname,
                    "email":email,
                    "isTourist":isTourist,
                    "nationality":nationality,
                    "phone":phone,
                    "language":language,
                    "sex":sex,
                    "image":self.base64string,
                    "available":false,
                    "longitude":0,
                    "latitude":0,
                    "connected":"none"
                    
                    
                    
                ]
                
                let newuser = ["/users/\(key)": user]
                
                self.ref.updateChildValues(newuser)
                
                
                
                
                self.navigationController?.popViewControllerAnimated(true)
                
                var alert = UIAlertController(title: "Registration Completed", message:
                    "Done.", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: false, completion: nil)
                
                self.isRegistrationDone = true
            }

            else
            {
                if let errCode = FIRAuthErrorCode(rawValue: error!.code) {
                    
                    switch errCode {
                    case .ErrorCodeInvalidEmail:
                        self.navigationController?.popViewControllerAnimated(true)
                        
                        var alert = UIAlertController(title: "Registration Failed", message:
                            "Invalid email address.", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(alert, animated: false, completion: nil)
                        
                        
                        
                    case .ErrorCodeEmailAlreadyInUse:
                        self.navigationController?.popViewControllerAnimated(true)
                        
                        var alert = UIAlertController(title: "Registration Failed", message:
                            "Account already exisited with email address entered.", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(alert, animated: false, completion: nil)
                        
                        
                    default:
                        self.navigationController?.popViewControllerAnimated(true)
                        
                        var alert = UIAlertController(title: "Registration Failed", message:
                            "Unknown error.", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(alert, animated: false, completion: nil)

                    }
                    
                    
                    
                }
                
                self.isRegistrationDone = false
                
            }
            
            
            
        })

        
    }
    
    @IBAction func BacktoRegistration(sender:UIStoryboardSegue)
    {
        
    }


    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
