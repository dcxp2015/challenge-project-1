//
//  ViewController.swift
//  sudokusolver
//
//  Created by Rahul Sundararaman on 7/6/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var arrayOfTextFields:[UITextField] = []
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
        
        var a = fillSudoku(arrayOfArrays, row: 0, col: 0)
        println("done")
        
    }
    func isAvailable(puzzle: [[Int]], row: Int, col: Int, num: Int)->Int{
        var rowStart:Int = (row/3)*3
        var colStart:Int = (col/3)*3
        var i: Int
        var j: Int
        for(var i = 0; i<9; i++){
            var puzz=puzzle[row][i]
            if(puzz == num){
                return 0
            }
            puzz=puzzle[i][col]
            if(puzz == num){
                return 0
            }
            puzz=puzzle[rowStart+(i%3)][colStart+(i/3)]
            if(puzz == num){
                return 0
            }
        }
        return 1
    }
    func fillSudoku(puzzle: [[Int]], row: Int, col: Int)->[[Int]]{
        var tempp = puzzle
        if(row<9 && col<9){
            var pp = tempp[row][col]
            
            if(pp != 0){
                if((col+1)<9){
                    return fillSudoku(tempp, row: row, col: col+1)
                }
                else if((row+1)<9){
                    return fillSudoku(tempp, row: row+1, col: 0)
                }
                else{
                    return [[]]
                }
            }
            else{
                for(var k=0; k<9; k++){
                    if(isAvailable(tempp, row: row, col: col, num: k+1) == 1){
                        tempp[row][col] = (k+1)
                        var ttm = col+1
                        if((ttm)<9){
                            if(fillSudoku(tempp, row: row, col: ttm) != [[]]){
                                return tempp
                            }
                            else{
                                tempp[row][col]=0
                            }
                        }
                        else if((row+1)<9){
                            var fswift = row+1
                            if(fillSudoku(tempp, row: fswift, col: 0) == tempp){
                                return tempp
                            }
                            else{
                                tempp[row][col] = 0
                            }
                        }
                        else{
                            return tempp
                        }
                    }
                }
            }
            return [[]]
        }
        else{
            println(tempp)
            return tempp
            
        }
    }
}

