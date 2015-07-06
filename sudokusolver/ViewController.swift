//
//  ViewController.swift
//  sudokusolver
//
//  Created by Rahul Sundararaman on 7/6/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for(var a = 25; a<225; a+=25){
            for(var b=25; b<225; b+=25){
                var xx:CGFloat = CGFloat(a)
                var yy:CGFloat = CGFloat(b)
                 var myTextField: UITextField = UITextField(frame: CGRect(x: xx, y: yy, width: 20.00, height: 20.00))
                self.view.addSubview(myTextField)
                myTextField.text = "0"
                myTextField.borderStyle = UITextBorderStyle.Line
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

