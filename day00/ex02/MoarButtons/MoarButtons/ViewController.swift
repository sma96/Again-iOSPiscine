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
import ReactorKit

class ViewController: UIViewController {
    var calculatorView = CalculatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(calculatorView)
    }
    
    var disposeBag = DisposeBag()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calculatorView.pin.vCenter().left(view.pin.safeArea).right(view.pin.safeArea).height(55%)
    }
    func formatNumber(_ value: Double) -> String {
        let formatter = NumberFormatter()
        
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 10
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}

extension ViewController: View {
    
    func bind(reactor: CalculatorViewReactor) {
        // action
        Observable.merge(
            calculatorView.oneButton.rx.tap.map { Reactor.Action.tapNumber(1) },
            calculatorView.twoButton.rx.tap.map { Reactor.Action.tapNumber(2) },
            calculatorView.threeButton.rx.tap.map { Reactor.Action.tapNumber(3) },
            calculatorView.fourButton.rx.tap.map { Reactor.Action.tapNumber(4) },
            calculatorView.fiveButton.rx.tap.map { Reactor.Action.tapNumber(5) },
            calculatorView.sixButton.rx.tap.map { Reactor.Action.tapNumber(6) },
            calculatorView.sevenButton.rx.tap.map { Reactor.Action.tapNumber(7) },
            calculatorView.eightButton.rx.tap.map { Reactor.Action.tapNumber(8) },
            calculatorView.nineButton.rx.tap.map { Reactor.Action.tapNumber(9) },
            calculatorView.zeroButton.rx.tap.map { Reactor.Action.tapNumber(0) },
            calculatorView.plusButton.rx.tap.map { Reactor.Action.tapPlus },
            calculatorView.minusButton.rx.tap.map { Reactor.Action.tapMinus },
            calculatorView.multiplyButton.rx.tap.map { Reactor.Action.tapMultiply },
            calculatorView.divideButton.rx.tap.map { Reactor.Action.tapDivide },
            calculatorView.allCleanButton.rx.tap.map { Reactor.Action.tapClear },
            calculatorView.negativeButton.rx.tap.map { Reactor.Action.tapNegate },
            calculatorView.equalButton.rx.tap.map { Reactor.Action.tapEqual }
        )
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        // state
        reactor.state
            .map {
                if $0.showResult {
                    self.formatNumber($0.result)
                } else {
                    $0.expression
                }
            }
            .bind(to: calculatorView.resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
