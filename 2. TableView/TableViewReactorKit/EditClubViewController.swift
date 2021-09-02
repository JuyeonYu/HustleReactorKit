//
//  EditClubViewController.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/09/01.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import RxViewController


class EditClubViewController: UIViewController, StoryboardView {
    @IBOutlet weak var club: UITextField!
    @IBOutlet weak var edit: UIButton!
    var disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = EditClubReactor()
    }
    
    func bind(reactor: EditClubReactor) {
        edit.rx.tap
            .map { Reactor.Action.edit(name: self.club.text!) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        let name = reactor.state.map { $0.name }.share()
        name.bind(to: club.rx.text)
            .disposed(by: disposeBag)
        name.skip(1)
            .subscribe(onNext:  { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
