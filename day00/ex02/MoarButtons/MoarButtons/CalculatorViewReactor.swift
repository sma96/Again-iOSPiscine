//
//  CalculatorReactor.swift
//  MoarButtons
//
//  Created by 마석우 on 4/27/25.
//

import UIKit
import ReactorKit

class CalculatorViewReactor: Reactor {
    enum Action {
        case tapNumber(Int)
        case tapPlus
        case tapMinus
        case tapMultiply
        case tapDivide
        case tapClear
        case tapNegate
        case tapEqual(String)
    }
    
    enum Mutation {
        case makeNumer(Int)
        case makeExpression(Operator)
        case clean
        case negate
        case calculate
    }
    
    struct State {
        var error = false
        var showResult = false
        var expression: String = ""
        var result: Double = 0.0
    }
    
    var initialState: State = State()
    
    var operators = [Operator]()
    var currentOperator: Operator?
    var numberString = String()
    var error = false
}

extension CalculatorViewReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapNumber(let number):
            return Observable.just(.makeNumer(number))
        case .tapPlus:
            return Observable.just(.makeExpression(.plus("+")))
        case .tapMinus:
            return Observable.just(.makeExpression(.minus("-")))
        case .tapMultiply:
            return Observable.just(.makeExpression(.multiply("*")))
        case .tapDivide:
            return Observable.just(.makeExpression(.divide("/")))
        case .tapClear:
            return Observable.just(.clean)
        case .tapNegate:
            return Observable.just(.negate)
        case .tapEqual(let str):
            print("str = \(str)")
            return Observable.just(.calculate)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .makeNumer(let number):
            if state.showResult {
                currentOperator = nil
                numberString = ""
                state = initialState
            }
            operators.append(.number(number))
            state.expression += "\(number)"
        case .makeExpression(let op):
            if state.showResult {
                currentOperator = nil
                state.showResult = false
                state.expression = numberString
            }
            operators.append(op)
            state.expression += op.symbolValue ?? ""
        case .clean:
            state = initialState
            allClean()
            return state
        case .negate:
            return state
        case .calculate:
            state.result = calculate()
            state.showResult = true
            clean()
            numberString = "\(state.result)"
            
            return state
        }
        return state
    }
}

extension CalculatorViewReactor {
    func clean() {
        operators.removeAll()
        currentOperator = nil
    }
    
    func allClean() {
        operators.removeAll()
        currentOperator = nil
        numberString = ""
    }
    
//    func calculate(_ op: Operator) {
//        switch op {
//        case .plus:
//            let num = Double(self.numberString)!
//
//            result += num
//
//        case .minus:
//            let num = Double(self.numberString)!
//
//            result -= num
//
//        case .divide:
//            let num = Double(self.numberString)!
//            let divided = result / num
//
//            result = divided.isInfinite ? 0 : divided
//
//        case .multiply:
//            let num = Double(self.numberString)!
//
//            result *= num
//        default:
//            break
//        }
//    }
    
    func calculate() -> Double {
        var result = 0.0
        
        for op in operators {
            switch op {
            case .plus:
                if let operatorSign = currentOperator {
                    result = operatorSign.calculate(result, Double(self.numberString)!)
                } else {
                    result = Double(numberString)!
                }

                currentOperator = .plus("+")
                numberString = ""
            case .minus:
                if let operatorSign = currentOperator {
                    result = operatorSign.calculate(result, Double(self.numberString)!)
                } else {
                    result = Double(numberString)!
                }

                currentOperator = .minus("-")
                numberString = ""
            case .divide:
                if let operatorSign = currentOperator {
                    result = operatorSign.calculate(result, Double(self.numberString)!)
                    
                    if result.isFinite {
                        error = true
                    }
                } else {
                    result = Double(numberString)!
                }

                currentOperator = .divide("/")
                numberString = ""
            case .multiply:
                if let operatorSign = currentOperator {
                    result = operatorSign.calculate(result, Double(self.numberString)!)
                } else {
                    result = Double(numberString)!
                }

                currentOperator = .multiply("*")
                numberString = ""
            case .number(let number):
                numberString += "\(number)"
            default:
                break
            }
        }

        if let operatorSign = currentOperator {
            result = operatorSign.calculate(result, Double(self.numberString)!)
        }
        
        return result
    }

}
extension CalculatorViewReactor {

//
//    func makeExpression(_ op: Operator) {
//        if currentOperator == .equal {
//            if !op.isOperator {
//                calculatorView.resultLabel.text = ""
//                currentOperator = nil
//                numberString = ""
//            } else {
//                currentOperator = nil
//            }
//        }
//        print("number = \(numberString)")
//
//        switch op {
//        case .number(let number):
//            operators.append(op)
//            calculatorView.resultLabel.text! += "\(number)"
//        case .plus:
//            operators.append(op)
//            calculatorView.resultLabel.text! += "+"
//        case .minus:
//            operators.append(op)
//            calculatorView.resultLabel.text! += "-"
//        case .divide:
//            operators.append(op)
//            calculatorView.resultLabel.text! += "/"
//        case .multiply:
//            operators.append(op)
//            calculatorView.resultLabel.text! += "*"
//        case .clear:
//            allClean()
//        case .negate:
//            negative()
//        case .equal:
//            calculate()
//            let result = formatNumber(result)
//            calculatorView.resultLabel.text = result
//            numberString = result
//            clean()
//            currentOperator = .equal
//        }
//    }
}

