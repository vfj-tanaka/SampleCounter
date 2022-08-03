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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

