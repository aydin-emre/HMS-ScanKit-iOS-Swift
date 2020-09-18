//
//  ViewController.swift
//  HMSScanKit
//
//  Created by Emre AYDIN on 9/16/20.
//  Copyright © 2020 Emre AYDIN. All rights reserved.
//

import UIKit
import ScanKitFrameWork

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func defaultViewButton(_ sender: UIButton) {
        let options = HmsScanOptions(scanFormatType: 0, photo: false)
        if let hmsDefaultScanViewController = HmsDefaultScanViewController(defaultScanWithFormatType: options) {
            hmsDefaultScanViewController.defaultScanDelegate = self
            
            self.view.addSubview(hmsDefaultScanViewController.view)
            self.addChild(hmsDefaultScanViewController)
            self.didMove(toParent: hmsDefaultScanViewController)
        }
    }
    
    @IBAction func customizedViewButton(_ sender: UIButton) {
        let hmsCustomScanViewController = HmsCustomScanViewController()
        hmsCustomScanViewController.customizedScanDelegate = self
        //hmsCustomScanViewController.backButtonHiden = true // You can hide back button, if you want
        hmsCustomScanViewController.cutArea = CGRect(x: 0, y: 0, width: 200, height: 200)
        hmsCustomScanViewController.backAction()
        
        self.view.addSubview(hmsCustomScanViewController.view)
        self.addChild(hmsCustomScanViewController)
        self.didMove(toParent: hmsCustomScanViewController)
    }
    
    @IBAction func bitmapViewButton(_ sender: UIButton) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .camera // or .photoLibrary or .savedPhotosAlbum
        self.present(pickerController, animated: true)
    }
    
    @IBAction func bitmapBuildViewButtom(_ sender: UIButton) {
        // Coming soon :)
    }
    
    func parseResult(_ dictionary: [AnyHashable : Any]?) {
        if let dictionary = dictionary, let text = dictionary["text"] {
            print("*** Text: \(text)")
            if let formatValue = dictionary["formatValue"] {
                print("*** CodeFormat: \(formatValue)")
            }
            if let sceneType = dictionary["sceneType"] {
                print("*** ResultType: \(sceneType)")
            }
        } else {
            print("*** Scanning code not recognized!")
        }
    }
    
}

// DefaultView Delegate
extension ViewController: DefaultScanDelegate {
    
    func defaultScanImagePickerDelegate(for image: UIImage!) {
        let dic = HmsBitMap.bitMap(for: image, with: HmsScanOptions(scanFormatType: 0, photo: true))
        parseResult(dic)
    }
    
    func defaultScanDelegate(forDicResult resultDic: [AnyHashable : Any]!) {
        parseResult(resultDic)
    }
    
}

// CustomizedView Delegate
extension ViewController: CustomizedScanDelegate {
    
    func customizedScanDelegate(forResult resultDic: [AnyHashable : Any]!) {
        parseResult(resultDic)
    }
    
}

// UIImagePickerControllerDelegate for Bitmap View
extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        let dic = HmsBitMap.bitMap(for: image, with: HmsScanOptions(scanFormatType: 0, photo: true))
        parseResult(dic)
    }
    
}
