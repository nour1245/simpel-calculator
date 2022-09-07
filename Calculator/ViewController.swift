//
//  ViewController.swift
//  Calculator
//
//  Created by nour on 8/28/22.
//  Copyright © 2022 nour. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Holder: UIView!
    @IBOutlet weak var ResultLabel: UILabel!
    var FirstNum = 0
    
    var ResultNum = 0
    var currentOperation:operations?
    enum operations {
        case add , substract , multiply , divide
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ResultLabel.text = "0"
        ResultLabel.textColor = .white
        ResultLabel.textAlignment = .right
        ResultLabel.font = UIFont(name: "Helvetica", size: 80)
        ResultLabel.frame = CGRect(x: 20, y: Holder.frame.size.height - ((view.frame.size.width / 4 ) * 6) , width: view.frame.width - 40, height: 100)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNumPad()
    }
    
    private func setupNumPad(){
        let buttonSize = view.frame.size.width / 4
        
        let ZeroButton = UIButton(frame: CGRect(x: 0, y: Holder.frame.size.height - buttonSize, width: buttonSize * 3 , height: buttonSize))
        ZeroButton.setTitle("0", for: .normal)
        ZeroButton.tag = 1
        ZeroButton.backgroundColor = .white
        ZeroButton.setTitleColor(.black, for: .normal)
        ZeroButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        Holder.addSubview(ZeroButton)
        
        //buttons from 1 to 3
        for x in 0..<3{
            let Button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: Holder.frame.size.height - (buttonSize * 2), width: buttonSize , height: buttonSize))
            Button1.setTitle("\(x+1)", for: .normal)
            Button1.tag = x + 2
            Button1.backgroundColor = .white
            Button1.setTitleColor(.black, for: .normal)
            Button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            Holder.addSubview(Button1)
        }
        //buttons from 4 to 6
        for x in 0..<3{
            let Button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: Holder.frame.size.height - (buttonSize * 3), width: buttonSize , height: buttonSize))
            Button2.setTitle("\(x+4)", for: .normal)
            Button2.tag = x + 5
            Button2.backgroundColor = .white
            Button2.setTitleColor(.black, for: .normal)
            Button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            Holder.addSubview(Button2)
        }
        //buttons for 7 to 9
        for x in 0..<3{
            let Button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: Holder.frame.size.height - (buttonSize * 4), width: buttonSize , height: buttonSize))
            Button3.setTitle("\(x+7)", for: .normal)
            Button3.tag = x + 8
            Button3.backgroundColor = .white
            Button3.setTitleColor(.black, for: .normal)
            Button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            Holder.addSubview(Button3)
        }
        //clear button
        let ClearButton = UIButton(frame: CGRect(x: 0, y: Holder.frame.size.height - (buttonSize * 5), width: buttonSize * 3 , height: buttonSize))
        ClearButton.setTitle("Clear", for: .normal)
        ClearButton.backgroundColor = .white
        ClearButton.setTitleColor(.black, for: .normal)
        
        Holder.addSubview(ClearButton)
        
        //operations buttons
        let operations = ["=","+","-","/","X"]
        for x in 0..<5{
            let Button4 = UIButton(frame: CGRect(x: buttonSize * 3, y: Holder.frame.size.height - (buttonSize * CGFloat(x + 1)), width: buttonSize , height: buttonSize))
            Button4.setTitle(operations[x], for: .normal)
            Button4.backgroundColor = .orange
            Button4.setTitleColor(.white, for: .normal)
            Button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            Button4.tag = x+1
            Holder.addSubview(Button4)
        }
        
        //action
        ClearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        
    }
    @objc func clearResult(){
        ResultLabel.text = "0"
        currentOperation = nil
        FirstNum = 0
    }
    
    @objc func numberPressed(_ sender: UIButton){
        let tag = sender.tag - 1
        if ResultLabel.text == "0" {
            ResultLabel.text = "\(tag)"
        }else if let text = ResultLabel.text{
            ResultLabel.text = "\(text)\(tag)"
        }
        
    }
    
    @objc func operationPressed(_ sender: UIButton){
        let tag = sender.tag
        
        if let text = ResultLabel.text , FirstNum == 0{
            FirstNum = Int(text)!
            ResultLabel.text = "0"
        }
        
        // =
        if tag == 1 {
            if let operation = currentOperation{
                var secNum = 0
                if let text = ResultLabel.text{
                    secNum = Int(text)!
                }
                switch operation {
                case .add:
                    let result = FirstNum + secNum
                    ResultLabel.text = "\(result)"
                    break
                case .substract:
                    let result = FirstNum - secNum
                    ResultLabel.text = "\(result)"
                    break
                case .multiply:
                    let result = FirstNum * secNum
                    ResultLabel.text = "\(result)"
                    break
                case .divide:
                    let result = FirstNum / secNum
                    ResultLabel.text = "\(result)"
                    break
                    
                }
            }
        }
        else // +
            if tag == 2 {
                currentOperation = .add
            }
            else // -
                if tag == 3 {
                    currentOperation = .substract
                }
                else // /
                    if tag == 4 {
                        currentOperation = .divide
                    }
                    else // X
                        if tag == 5 {
                            currentOperation = .multiply
        }
        
        
    }
    
}

