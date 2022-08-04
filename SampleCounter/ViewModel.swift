//
//  ViewModel.swift
//  SampleCounter
//
//  Created by mtanaka on 2022/08/03.
//

import Foundation
import RxSwift
import RxCocoa

struct ViewModelInput {
    let countUpButton: Observable<Void>
    let countDownButton: Observable<Void>
    let countResetButton: Observable<Void>
}

protocol ViewModelOutput {
    var contText: Driver<String?> { get }
}

protocol ViewModelType {
    var output: ViewModelOutput? { get }
    func setup(input: ViewModelInput)
}

final class ViewModel: ViewModelType {
    
    var output: ViewModelOutput?
    private let countRelay = BehaviorRelay<Int>(value: 0)
    private let initialCount = 0
    private let disposeBag = DisposeBag()
    
    init() {
        
        self.output = self
        resetCount()
    }
    
    func setup(input: ViewModelInput) {
        
        input.countUpButton
            .subscribe(onNext: { [weak self] in
                self?.incrementCount()
            })
            .disposed(by: disposeBag)
        
        input.countDownButton
            .subscribe(onNext: { [weak self] in
                self?.decrementCount()
            })
            .disposed(by: disposeBag)
        
        input.countResetButton
            .subscribe(onNext: { [weak self] in
                self?.resetCount()
            })
            .disposed(by: disposeBag)
    }
    
    private func incrementCount() {
        let count = countRelay.value + 1
        countRelay.accept(count)
    }
    
    private func decrementCount() {
        let count = countRelay.value - 1
        countRelay.accept(count)
    }
    
    private func resetCount() {
        countRelay.accept(initialCount)
    }
}

extension ViewModel: ViewModelOutput {
    
    var contText: Driver<String?> {
        return countRelay
            .map { "Rxパターン：\($0)" }
            .asDriver(onErrorJustReturn: nil)
    }
}
