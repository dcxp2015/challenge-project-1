//
//  ViewController.swift
//  sudokusolver
//
//  Created by Rahul Sundararaman on 7/6/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /*let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
    if (firstLaunch)  {
        println("Not first launch.")
    }
    else {
        println("First launch, setting NSUserDefault.")
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
    
    }*/
    
    var arrayOfTextFields:[UITextField] = []
    var ccount = 0
    var ds:[[Int]] = [[]]
    var tempp:[[Int]] = [[]]
    var label:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var cc = 0;
        
        let vWidth = self.view.bounds.width
        println("\(vWidth)")
        let padding = floor(vWidth/4.75)
        let dimensions = floor(vWidth/18.75)
        let step = floor(vWidth/75)+dimensions
        let endpoint = (vWidth-padding)
        println("padding:\(padding)")
        println("dimensions:\(dimensions)")
        println("step:\(step)")
        println("endpoint:\(endpoint)")
        label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        var xx: CGFloat = 1.0
        var yy: CGFloat = 1.0
        for(var a = padding; a<endpoint; a+=step){
            for(var b=padding; b<endpoint; b+=step){
                xx = CGFloat(a)
                yy = CGFloat(b)
                 var myTextField: UITextField = UITextField(frame: CGRect(x: xx, y: yy, width: dimensions, height: dimensions))
                
                myTextField.text = ""
                myTextField.borderStyle = UITextBorderStyle.Line
                myTextField.keyboardType = UIKeyboardType.NumberPad
                self.arrayOfTextFields.append(myTextField)
                self.view.addSubview(myTextField)
            }
        }
        var xbutton = floor(vWidth/2)-(6*dimensions)
        println("\(xbutton)")
        let ybutton = yy+(2*dimensions)
        let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(xbutton, ybutton, dimensions*5, floor(dimensions*2.5))
        button.setTitle("Solve", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        xbutton = floor(vWidth/2)+dimensions
        let clear   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        clear.frame = CGRectMake(xbutton, ybutton, dimensions*5, floor(dimensions*2.5))
        clear.setTitle("Clear", forState: UIControlState.Normal)
        clear.addTarget(self, action: "buttonClear:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(clear)
         self.view.addSubview(button)
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = "IMPOSSIBLE"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender:UIButton!)
    {
        ccount=0
        label.hidden = true
        var x = 0
        var y = 0
        var arrayOfInts:[Int] = []
        var arrayOfArrays:[[Int]] = []
        var count = 0
        for textField in arrayOfTextFields{
            if(x == 9 || count==80){
                if(count == 80){
                    if(textField.text == ""){
                        arrayOfInts+=[0]
                    }
                    else{
                        let aaa:Int = textField.text.toInt()!
                        arrayOfInts+=[aaa]
                    }
                }
                arrayOfArrays += [arrayOfInts]
                arrayOfInts = []
                x=0
            }
            if(textField.text == ""){
                arrayOfInts+=[0]
            }
            else{
                let aaa:Int = textField.text.toInt()!
                arrayOfInts += [aaa]
            }
            x++
            count++
        }
        println(arrayOfArrays)
        var puzzle:[[Int]]=arrayOfArrays

        var a = fillSudoku(puzzle, row: 0, col: 0)
        println(tempp)
        x = 0
        y = 0
        //Fill in texfield
        if(tempp != [[]]){
            for textField in arrayOfTextFields{
                if(x == 8){
                    textField.text="\(tempp[y][x])"
                    y++
                    x = 0
                }
                else{
                    textField.text="\(tempp[y][x])"
                    x++
                }
            }
        }
        else{
            label.hidden = false
        }
        
        tempp = [[]]
    }
    func buttonClear(sender:UIButton!)
    {
        for textField in arrayOfTextFields{
            textField.text=""
        }
        label.hidden=true
    }
    func isAvailable(puzzle: [[Int]], row: Int, col: Int, num: Int)->Int{
        var i: Int
        var j: Int
        for(i=0; i<9; i++){
            if((puzzle[row][i]==num) || (puzzle[i][col]==num)){
                return 0
            }
        }
        var rowStart:Int = (row/3)*3
        var colStart:Int = (col/3)*3
        
        for(var i=rowStart; i<(rowStart+3); i++){
            for(j=colStart; j<(colStart+3); j++){
                if(puzzle[i][j]==num){
                    return 0
                }
            }
        }
        return 1
    }
    func fillSudoku(puzzle: [[Int]], row: Int, col: Int)->Int{
        if(ccount > 400000){
            println("Impossible!")
            self.view.addSubview(label)
            label.hidden = false
            return 0
        }
        var i:Int
        ccount++
        tempp = puzzle
       // println("row \(row)")
       // println("col \(col)")
        if(row<9 && col<9){
            var ttx = tempp[row][col] as Int
            if(ttx != 0){
                if((col+1)<9){
                    return fillSudoku(tempp, row: row, col: col+1)
                }
                else if((row+1)<9){
                    return fillSudoku(tempp, row: row+1, col: 0)
                }
                else{
                    return 1
                }
            }
            else{
                for(i=0; i<9; i++){
                    if(isAvailable(tempp, row: row, col: col, num: i+1)==1){
                        tempp[row][col]=i+1
                        if((col+1)<9){
                            if(fillSudoku(tempp, row: row, col: col+1)==1){
                                return 1
                            }
                            else{
                                tempp[row][col]=0
                            }
                        }
                        else if((row+1)<9){
                            if(fillSudoku(tempp, row: row+1, col: 0)==1){
                                return 1
                            }
                            else{
                                tempp[row][col]=0
                            }
                        }
                        else{
                            return 1
                        }
                    }
                }
            }
           // println(tempp)
            ds = tempp
            return 0
        }
        else{
            println("here")
            //println(tempp)
            return 1
        }
    }
}

