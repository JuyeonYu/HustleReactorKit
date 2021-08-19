//
//  ViewController.swift
//  HustleReactorKit
//
//  Created by Juyeon on 2021/08/19.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class TimeViewController: UIViewController, StoryboardView {
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = TimeReactor()
        // Do any additional setup after loading the view.
    }
    
    func bind(reactor: TimeReactor) {
        timeButton.rx.tap
            .map { Reactor.Action.readTime }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.time }
            .bind(to: time.rx.text)
            .disposed(by: disposeBag)
    }
}

