//
//  CalcuratorView.swift
//  MoarButtons
//
//  Created by 마석우 on 4/18/25.
//

import UIKit
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa


enum Operator: Equatable {
    case number(Int)
    case plus(String)
    case minus(String)
    case divide(String)
    case multiply(String)
    case equal
    case clear
    case negate
    
    var isOperator: Bool {
        switch self {
        case .number:
            return false
        default:
            return true
        }
    }
    
    func calculate(_ lhs: Double, _ rhs: Double) -> Double {
        switch self {
        case .plus(_):
            return lhs + rhs
        case .minus(_):
            return lhs - rhs
        case .divide(_):
            return lhs / rhs
        case .multiply(_):
            return lhs * rhs            
        default:
            return 0
        }
    }
    var symbolValue: String? {
           switch self {
           case .plus(let value), .minus(let value), .divide(let value), .multiply(let value):
               return value
           default:
               return nil
           }
       }
}

class CalculatorView: UIView {
    
    let textfield = {
        var tf = UITextField()
        
        tf.text = "hello sma!"
        
        return tf
    }()
    
    let resultLabel = {
        var label = UILabel()
        
        label.textAlignment = .right
        label.textColor = .white
        label.numberOfLines = 1
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = ""
    
        return label
    }()
    
    let oneButton = {
        var button = UIButton()
        
        button.setTitle("1", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let twoButton = {
        var button = UIButton()
        
        button.setTitle("2", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let threeButton = {
        var button = UIButton()
        
        button.setTitle("3", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let fourButton = {
        var button = UIButton()
        
        button.setTitle("4", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let fiveButton = {
        var button = UIButton()
        
        button.setTitle("5", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let sixButton = {
        var button = UIButton()
        
        button.setTitle("6", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    let sevenButton = {
        var button = UIButton()
        
        button.setTitle("7", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let eightButton = {
        var button = UIButton()
        
        button.setTitle("8", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()

    let nineButton = {
        var button = UIButton()
        
        button.setTitle("9", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()

    let zeroButton = {
        var button = UIButton()
        
        button.setTitle("0", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()

    let allCleanButton = {
        let button = UIButton()
        
        button.setTitle("AC", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let negativeButton = {
        let button = UIButton()
        
        button.setTitle("NEG", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
        
    }()
    
    let plusButton = {
        let button = UIButton()
        
        button.setTitle("+", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let minusButton = {
        let button = UIButton()
        
        button.setTitle("-", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let multiplyButton = {
        let button = UIButton()
        
        button.setTitle("*", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let divideButton = {
        let button = UIButton()
        
        button.setTitle("/", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let equalButton = {
        let button = UIButton()
        
        button.setTitle("=", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    var rootFlexContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .blue
        rootFlexContainer.pin.all()
        rootFlexContainer.flex.layout()
    }
}

extension CalculatorView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.column).alignItems(.stretch).padding(5, 0).gap(5).grow(1).define { flex in
            
            flex.addItem(resultLabel).marginHorizontal(5).height(10%)
            
            flex.addItem().direction(.row).padding(0, 5).alignItems(.stretch).grow(1).gap(5).define { flex in
                flex.addItem(oneButton).grow(1).basis(0%)
                flex.addItem(twoButton).grow(1).basis(0%)
                flex.addItem(threeButton).grow(1).basis(0%)
                flex.addItem(allCleanButton).grow(1).basis(0%)
                flex.addItem(negativeButton).grow(1).basis(0%)
            }
            
            flex.addItem().direction(.row).padding(0, 5).alignItems(.stretch).grow(1).gap(5).define { flex in
                flex.addItem(fourButton).grow(1).basis(0%)
                flex.addItem(fiveButton).grow(1).basis(0%)
                flex.addItem(sixButton).grow(1).basis(0%)
                flex.addItem(plusButton).grow(1).basis(0%)
                flex.addItem(multiplyButton).grow(1).basis(0%)
            }
            
            flex.addItem().direction(.row).padding(0, 5).alignItems(.stretch).grow(1).gap(5).define { flex in
                flex.addItem(sevenButton).grow(1).basis(0%)
                flex.addItem(eightButton).grow(1).basis(0%)
                flex.addItem(nineButton).grow(1).basis(0%)
                flex.addItem(minusButton).grow(1).basis(0%)
                flex.addItem(divideButton).grow(1).basis(0%)
            }
            
            flex.addItem().direction(.row).alignItems(.stretch).padding(0, 5).grow(1).gap(5).define { flex in
                flex.addItem().grow(1).basis(0%)
                flex.addItem(zeroButton).grow(1).basis(0%)
                flex.addItem().grow(1).basis(0%)
                flex.addItem(equalButton).grow(1).basis(0%)
                flex.addItem().grow(1).basis(0%)
            }
        }
    }
}
