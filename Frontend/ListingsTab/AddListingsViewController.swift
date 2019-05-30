//
//  AddListingsViewController.swift
//  Frontend
//
//  Created by Zane Ali on 1/22/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit
import Alamofire

extension UIAlertController {
    
    private struct ActivityIndicatorData {
        static var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    }
    
    func addActivityIndicator() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 40,height: 40)
        ActivityIndicatorData.activityIndicator.color = UIColor.blue
        ActivityIndicatorData.activityIndicator.startAnimating()
        vc.view.addSubview(ActivityIndicatorData.activityIndicator)
        self.setValue(vc, forKey: "contentViewController")
    }
    
    func dismissActivityIndicator() {
        ActivityIndicatorData.activityIndicator.stopAnimating()
        self.dismiss(animated: false)
    }
}

class AddListingsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var itemName: UITextField!
    
 
    @IBOutlet weak var pickerView: UIPickerView!
    var pickerData: [String : String] = [String : String]()
    var pickerArray: [String] = [String]()
    
    var activityGlobal: UIAlertController?

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var itemDescription: UITextView!
    
    @IBOutlet weak var listingImage: UIImageView!
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var itemPrice: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemPrice.keyboardType = .numberPad
        
        itemDescription.layer.borderWidth = 1.0
        itemDescription.layer.cornerRadius = 5.0
        itemDescription.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        imagePicker.delegate = self
        
        loadData {
           self.pickerView.reloadAllComponents()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pickImage(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func dismessVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        print("TEST")
        if (itemDescription.text! == "" || itemPrice.text! == "" || itemName.text! == ""){
            print("Forms not filled: error")
        }else{

            guard let price = Float(String(format: "%.2f", itemPrice.text!)) else {
                print("Invalid Price")
                return
            }
            let item  = itemName.text!
            let row = self.pickerView.selectedRow(inComponent: 0)
            let artisanName = pickerArray[row]
            let artisanID = (pickerData[artisanName])
            let description = itemDescription.text!
            
            let newListing = Listing()
            newListing.price = price
            newListing.name = item
            newListing.artisanId = artisanID ?? "None"
            newListing.description = description
            postListing(listing: newListing){
                print("post listing completion callback...")
                self.dismiss(animated: true, completion: nil)

            }
    
        }
    }
    
    func displayActivityIndicatorAlert() {
        activityGlobal = UIAlertController(title: NSLocalizedString("Uploading image", comment: ""), message: NSLocalizedString("Please wait", comment: "") + "...", preferredStyle: UIAlertController.Style.alert)
        activityGlobal!.addActivityIndicator()
        var topController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while ((topController.presentedViewController) != nil) {
            topController = topController.presentedViewController!
        }
        topController.present(activityGlobal!, animated:true, completion:nil)
    }
    
    func dismissActivityIndicatorAlert() {
        activityGlobal!.dismissActivityIndicator()
        activityGlobal = nil
    }
    
    private func postListing(listing: Listing, completion: @escaping () -> ()) {
        
        displayActivityIndicatorAlert()
        print("posting listing with image....")
        let listingDict = listing.toStrDict()
        if let imgData = listingImage.image?.jpeg(.lowest){
            Alamofire.upload(
                multipartFormData: { MultipartFormData in
                    MultipartFormData.append(imgData, withName: "listingImage" , fileName: "image.png" , mimeType: "image/png")
                    for(key,value) in listingDict{
                        MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)}
            },  to: Constants.Database.serverUrl + "listings",
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            debugPrint("SUCCESS RESPONSE: \(response)")
                            self.dismissActivityIndicatorAlert()
                            completion()
                        }
                    case .failure(let encodingError):
                        print("listing post failure: ", encodingError)
                    }
            })
        }
        else {
            print("No image found, failed to post listing")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print (pickerArray.count)
        return pickerArray.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerArray[row]
    }
    func loadData(completion : @escaping () -> ()) {
        
        Alamofire.request("http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/users/" + Constants.userID + "/artisans").responseJSON { response in
            
            if let json = response.result.value {
                // serialized json response
                if let dict = json as? [[String: Any]] {
                        for x in dict  {
                            self.pickerData[(x["name"]! as! String)] = (x["_id"]! as! String)
                            self.pickerArray.append(x["name"]! as! String)
                        }
                }
            }
            completion()
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
}

extension AddListingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            listingImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

extension UIImage{
   
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
