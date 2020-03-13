//
//  ViewController.swift
//  PodProjrct
//
//  Created by JL521 on 03/03/2020.
//  Copyright (c) 2020 JL521. All rights reserved.
//

import UIKit
import PodProjrct

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isTranslucent = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func pagemenu(_ sender: Any) {
        let titles = ["test1", "test2", "test3", "test4"]
        let childs = [UIViewController(), UIViewController(), UIViewController(),RCAddressViewController(height:250)]
        let pagevc = RCPagemenController(titles: titles, childs: childs, count: 3 )
        pagevc.selectBlock = {
            (index: Int) in
            print("\(titles[index])")
        }
        self.navigationController?.pushViewController(pagevc, animated: true)
    }
    @IBAction func address(_ sender: Any) {
        let addressPicker = RCAddressViewController(title: "地址选择")
        addressPicker.modalPresentationStyle = .custom
        addressPicker.selectBlock = {
            (pModel: RCAddressModel?, cModel: RCAddressModel?, dModel: RCAddressModel?) in
            print("\(pModel?.adcode ?? 0)\(cModel?.adcode ?? 0)\(dModel?.adcode ?? 0)")
        }
        self.present(addressPicker, animated: false, completion: nil)
    }
}

