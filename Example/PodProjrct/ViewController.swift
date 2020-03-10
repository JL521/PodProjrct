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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let titles = ["test1", "test2", "test3"]
        let childs = [UIViewController(), UIViewController(), UIViewController()]
        let pagevc = RCPagemenController(titles: titles, childs: childs, count: 3 )
        pagevc.selectBlock = {
            (index: Int) in
            print("\(titles[index])")
        }
        self.present(pagevc, animated: true, completion: nil)
    }

}

