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
        
    }
    
    @IBAction func customizedViewButton(_ sender: UIButton) {
        
    }
    
    @IBAction func bitmapViewButton(_ sender: UIButton) {
        
    }
    
    @IBAction func bitmapBuildViewButtom(_ sender: UIButton) {
        
    }
}

extension ViewController: DefaultScanDelegate {
    
    func defaultScanImagePickerDelegate(for image: UIImage!) {
        print("image: \(image)")
    }
    
    func defaultScanDelegate(forDicResult resultDic: [AnyHashable : Any]!) {
        print("res: \(resultDic)")
    }
    
}
