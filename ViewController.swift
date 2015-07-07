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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var cc = 0;
        for(var a = 50; a<275; a+=25){
            for(var b=50; b<275; b+=25){
                var xx:CGFloat = CGFloat(a)
                var yy:CGFloat = CGFloat(b)
                 var myTextField: UITextField = UITextField(frame: CGRect(x: xx, y: yy, width: 20.00, height: 20.00))
                
                myTextField.text = "0"
                myTextField.borderStyle = UITextBorderStyle.Line
                myTextField.keyboardType = UIKeyboardType.NumberPad
                self.arrayOfTextFields.append(myTextField)
                self.view.addSubview(myTextField)
            }
        }
        let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(120, 320, 100, 50)
        button.setTitle("Solve", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
         self.view.addSubview(button)
        
        /*var puzzle:[[Int]]=[[0, 0, 0, 0, 0, 0, 0, 9, 0],
            [1, 9, 0, 4, 7, 0, 6, 0, 8],
            [0, 5, 2, 8, 1, 9, 4, 0, 7],
            [2, 0, 0, 0, 4, 8, 0, 0, 0],
            [0, 0, 9, 0, 0, 0, 5, 0, 0],
            [0, 0, 0, 7, 5, 0, 0, 0, 9],
            [9, 0, 7, 3, 6, 4, 1, 8, 0],
            [5, 0, 6, 0, 8, 1, 0, 7, 4],
            [0, 8, 0, 0, 0, 0, 0, 0, 0]];
        println(puzzle)
        var a = fillSudoku(puzzle, row: 0, col: 0)
//        for(var jj = 0; jj<9; jj++){
//            for(var gg = 0; gg<9; gg++){
//                a = fillSudoku(ds, row: jj, col: gg)
//                println(ds)
//            }
//        }
        println("done")
//        println(ds)
//        println(ccount)
        println(tempp)*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender:UIButton!)
    {
        var x = 0
        var y = 0
        var arrayOfInts:[Int] = []
        var arrayOfArrays:[[Int]] = []
        var count = 0
        for textField in arrayOfTextFields{
            if(x == 9 || count==80){
                if(count == 80){
                    let aaa:Int = textField.text.toInt()!
                    arrayOfInts+=[aaa]
                }
                arrayOfArrays += [arrayOfInts]
                arrayOfInts = []
                x=0
            }
            let aaa:Int = textField.text.toInt()!
            arrayOfInts += [aaa]
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
        if(ccount > 800000){
            println("Impossible!")
            
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

