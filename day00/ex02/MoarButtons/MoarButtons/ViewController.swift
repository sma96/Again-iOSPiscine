//
//  ViewController.swift
//  MoarButtons
//
//  Created by 마석우 on 4/16/25.
//

import UIKit
import FlexLayout
import PinLayout
import RxSwift
import RxRelay

class ViewController: UIViewController {
    var calculatorView = CalculatorView()
    var elements = [String]()
    var currentOperator: String?
    var numberString = String()
    var result = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bind()
        view.addSubview(calculatorView)
//        view.addSubview(viewA)
//        view.addSubview(viewB)
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calculatorView.pin.vCenter().left(view.pin.safeArea).right(view.pin.safeArea).height(55%)
    }
    
    func bind() {
        Observable.merge(
            calculatorView.oneButton.rx.tap.map { return "1" },
            calculatorView.twoButton.rx.tap.map { return "2" },
            calculatorView.threeButton.rx.tap.map { return"3" },
            calculatorView.fourButton.rx.tap.map { return "4" },
            calculatorView.fiveButton.rx.tap.map { return "5" },
            calculatorView.sixButton.rx.tap.map { return "6" },
            calculatorView.sevenButton.rx.tap.map { return "7" },
            calculatorView.eightButton.rx.tap.map { return "8" },
            calculatorView.nineButton.rx.tap.map { return "9" },
            calculatorView.zeroButton.rx.tap.map { return "0" },
            calculatorView.plusButton.rx.tap.map { return "+" },
            calculatorView.minusButton.rx.tap.map { return "-" },
            calculatorView.multiplyButton.rx.tap.map { return "*" },
            calculatorView.divideButton.rx.tap.map { return "/" },
            calculatorView.allCleanButton.rx.tap.map { return "AC" },
            calculatorView.negativeButton.rx.tap.map { return "NEG" },
            calculatorView.equalButton.rx.tap.map { return "=" }
        ).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            
            makeExpression($0)
            
        }).disposed(by: disposeBag)
        
    }
    
    func clean() {
        elements.removeAll()
        currentOperator = nil
        result = 0
        numberString = ""
    }
    func allClean() {
        elements.removeAll()
        currentOperator = nil
        result = 0
        calculatorView.resultLabel.text = ""
    }
    
    func negative() {
        
    }
    
    func calculate() {
        for element in elements {
            calculate(element)
        }
        
        if let operatorSign = currentOperator {
            calculate(with: operatorSign)
        }
    }
    
    func calculate(_ element: String) {
        switch element {
        case "+":
            if let operatorSign = currentOperator {
                calculate(with: operatorSign)
            } else {
                result = Int(numberString)!
            }
            
            currentOperator = "+"
            numberString = ""
        case "-":
            if let operatorSign = currentOperator {
                calculate(with: operatorSign)
            } else {
                result = Int(numberString)!
            }

            currentOperator = "-"
            numberString = ""
        case "/":
            if let operatorSign = currentOperator {
                calculate(with: operatorSign)
            } else {
                result = Int(numberString)!
            }

            currentOperator = "/"
            numberString = ""
        case "*":
            if let operatorSign = currentOperator {
                calculate(with: operatorSign)
            } else {
                result = Int(numberString)!
            }

            currentOperator = "*"
            numberString = ""
        default:
            numberString += element
        }
    }

    func calculate(with op: String) {
        switch op {
        case "+":
            let num = Int(self.numberString)!

            result += num
        case "-":
            let num = Int(self.numberString)!
            
            result -= num
        case "/":
            let num = Int(self.numberString)!
            
            result /= num
        case "*":
            let num = Int(self.numberString)!
            
            result *= num
        default:
            break
            
        }
    }
    
    func makeExpression(_ input: String) {
        if currentOperator == "=" {
            calculatorView.resultLabel.text = ""
            currentOperator = nil
        }
        switch input {
        case "AC":
            allClean()
        case "NEG":
            print("neg")
        case "=":
            calculate()
            calculatorView.resultLabel.text = "\(result)"
            clean()
            currentOperator = "="
        default:
            elements.append(input)
            calculatorView.resultLabel.text! += input
        }
    }
}

