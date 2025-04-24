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
    var operators = [Operator]()
    var currentOperator: Operator?
    var numberString = String()
    var result: Double = 0
    
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
            calculatorView.oneButton.rx.tap.map { return Operator.number(1) },
            calculatorView.twoButton.rx.tap.map { return Operator.number(2) },
            calculatorView.threeButton.rx.tap.map { return Operator.number(3) },
            calculatorView.fourButton.rx.tap.map { return Operator.number(4) },
            calculatorView.fiveButton.rx.tap.map { return Operator.number(5) },
            calculatorView.sixButton.rx.tap.map { return Operator.number(6) },
            calculatorView.sevenButton.rx.tap.map { return Operator.number(7) },
            calculatorView.eightButton.rx.tap.map { return Operator.number(8) },
            calculatorView.nineButton.rx.tap.map { return Operator.number(9) },
            calculatorView.zeroButton.rx.tap.map { return Operator.number(0) },
            calculatorView.plusButton.rx.tap.map { return Operator.plus },
            calculatorView.minusButton.rx.tap.map { return Operator.minus },
            calculatorView.multiplyButton.rx.tap.map { return Operator.multiply },
            calculatorView.divideButton.rx.tap.map { return Operator.divide },
            calculatorView.allCleanButton.rx.tap.map { return Operator.clear },
            calculatorView.negativeButton.rx.tap.map { return Operator.negate },
            calculatorView.equalButton.rx.tap.map { return Operator.equal }
        ).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            
            makeExpression($0)
            
        }).disposed(by: disposeBag)
        
    }
    
    func clean() {
        operators.removeAll()
        currentOperator = nil
    }
    
    func allClean() {
        operators.removeAll()
        currentOperator = nil
        result = 0
        numberString = ""
        calculatorView.resultLabel.text = ""
    }
    
    func negative() {
        
    }
    
    func calculate() {
        for op in operators {
            calculate(with: op)
        }
        
        if let operatorSign = currentOperator {
            calculate(operatorSign)
        }
    }
    
    func calculate(with op: Operator) {
        switch op {
        case .plus:
            if let operatorSign = currentOperator {
                calculate(operatorSign)
            } else {
                print("numberstirng = \(numberString)")
                result = Double(numberString)!
            }
            
            currentOperator = .plus
            numberString = ""
        case .minus:
            if let operatorSign = currentOperator {
                calculate(operatorSign)
            } else {
                result = Double(numberString)!
            }
            
            currentOperator = .minus
            numberString = ""
        case .divide:
            if let operatorSign = currentOperator {
                calculate(operatorSign)
            } else {
                result = Double(numberString)!
            }
            
            currentOperator = .divide
            numberString = ""
        case .multiply:
            if let operatorSign = currentOperator {
                calculate(operatorSign)
            } else {
                result = Double(numberString)!
            }
            
            currentOperator = .multiply
            numberString = ""
        case .number(let number):
            numberString += "\(number)"
        default:
            break
        }
    }
    
    func calculate(_ op: Operator) {
        switch op {
        case .plus:
            let num = Double(self.numberString)!
            
            result += num

        case .minus:
            let num = Double(self.numberString)!
            
            result -= num

        case .divide:
            let num = Double(self.numberString)!
            let divided = result / num
            
            result = divided.isInfinite ? 0 : divided
            
        case .multiply:
            let num = Double(self.numberString)!
            
            result *= num
        default:
            break
        }
    }
    
    func makeExpression(_ op: Operator) {
        if currentOperator == .equal {
            if !op.isOperator {
                calculatorView.resultLabel.text = ""
                currentOperator = nil
                numberString = ""
            } else {
                currentOperator = nil
            }
        }
        print("number = \(numberString)")
        
        switch op {
        case .number(let number):
            operators.append(op)
            calculatorView.resultLabel.text! += "\(number)"
        case .plus:
            operators.append(op)
            calculatorView.resultLabel.text! += "+"
        case .minus:
            operators.append(op)
            calculatorView.resultLabel.text! += "-"
        case .divide:
            operators.append(op)
            calculatorView.resultLabel.text! += "/"
        case .multiply:
            operators.append(op)
            calculatorView.resultLabel.text! += "*"
        case .clear:
            allClean()
        case .negate:
            negative()
        case .equal:
            calculate()
            let result = formatNumber(result)
            calculatorView.resultLabel.text = result
            numberString = result
            clean()
            currentOperator = .equal
        }
    }
    
    func formatNumber(_ value: Double) -> String {
        let formatter = NumberFormatter()
        
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 10
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}
