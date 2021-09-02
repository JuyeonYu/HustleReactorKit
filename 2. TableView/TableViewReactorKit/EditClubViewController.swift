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
            .subscribe(onNext: { [weak self] in
                UserInfo.name.onNext((self?.club.text!)!)
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        reactor.state
            .map { $0.name }
            .bind(to: club.rx.text)
            .disposed(by: disposeBag)
    }
}
