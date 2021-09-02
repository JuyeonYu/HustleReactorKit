//
//  TestViewController.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/25.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

class CreateClubViewController: UIViewController, StoryboardView {

    @IBOutlet weak var goNext: UIBarButtonItem!
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var help: UILabel!
    @IBOutlet weak var placeHolder: UILabel!
    
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = CreateClubReactor()
        goNext.rx.tap
            .asDriver()
            .drive(onNext: {
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EditClubViewController")
                self.present(viewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    func bind(reactor: CreateClubReactor) {
        name.rx.text.orEmpty.skip(1)
//            .map {  Reactor.Action.inputName($0) }
//            .bind(to: reactor.action)
            .subscribe(onNext: {
                UserInfo.name.onNext($0)
            })
            .disposed(by: disposeBag)
        reactor.state.map { $0.helpMessage }
            .debug()
            .bind(to: help.rx.text)
            .disposed(by: disposeBag)
        reactor.state.map { $0.helpMessage.isEmpty }
            .debug()
            .bind(to: help.rx.isHidden)
            .disposed(by: disposeBag)
        reactor.state.map { $0.separatorColor }
            .debug()
            .bind(to: separator.rx.backgroundColor)
            .disposed(by: disposeBag)
        reactor.state.map { !$0.name.isEmpty }
            .debug()
            .bind(to: placeHolder.rx.isHidden)
            .disposed(by: disposeBag)
        reactor.state.map { $0.name }
            .bind(to: name.rx.text)
            .disposed(by: disposeBag)
//        reactor.state.map { $0.nameState == .valid }
//            .debug()
//            .bind(to: goNext.rx.isEnabled)
//            .disposed(by: disposeBag)
        
//        UserInfo.name
//            .subscribe { print("x-> \($0)")
//        }
//            .disposed(by: disposeBag)
    }
}
