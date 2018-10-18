//
//  ViewController.swift
//  handWritten
//
//  Created by corepress on 2018/10/18.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let gestureView = CPSTopGestureView(frame: self.view.bounds) { (image) in
            self.imageView.image = image
        }
        view.addSubview(gestureView)
        
    }


}

