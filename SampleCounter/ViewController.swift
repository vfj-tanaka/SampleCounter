//
//  ViewController.swift
//  SampleCounter
//
//  Created by mtanaka on 2022/08/03.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
    
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var countUpButton: UIButton!
    @IBOutlet private weak var countDownButton: UIButton!
    @IBOutlet private weak var countResetButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindInput()
        bindOutput()
    }
    
    private func bindInput() {
        
        
        let input = ViewModelInput(
            countUpButton: countUpButton.rx.tap.asObservable(),
            countDownButton: countDownButton.rx.tap.asObservable(),
            countResetButton: countResetButton.rx.tap.asObservable()
        )
        
        viewModel.setup(input: input)
    }
    
    private func bindOutput() {
        
        viewModel.output?.contText
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

