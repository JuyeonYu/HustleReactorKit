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
        bind(to: reactor)
        bind(from: reactor)
    }
    fileprivate func bind(to reactor: CreateClubReactor) {
        name.rx.text.orEmpty.skip(1)
            .map {  Reactor.Action.inputName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    fileprivate func bind(from reactor: CreateClubReactor) {
        reactor.state.map { $0.helpMessage }
            .bind(to: help.rx.text)
            .disposed(by: disposeBag)
        reactor.state.map { $0.helpMessage.isEmpty }
            .bind(to: help.rx.isHidden)
            .disposed(by: disposeBag)
        reactor.state.map { $0.separatorColor }
            .bind(to: separator.rx.backgroundColor)
            .disposed(by: disposeBag)
        reactor.state.map { !$0.name.isEmpty }
            .bind(to: placeHolder.rx.isHidden)
            .disposed(by: disposeBag)
        reactor.state.map { $0.name }
            .bind(to: name.rx.text)
            .disposed(by: disposeBag)
        reactor.state.map { $0.nameState == .valid }
            .bind(to: goNext.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
