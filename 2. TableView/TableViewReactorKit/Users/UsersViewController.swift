//
//  ViewController.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/20.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import RxViewController
import ReusableKit

class UsersViewController: UIViewController, StoryboardView {
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    enum Reusable {
        static let defaultCell = ReusableCell<UITableViewCell>()
        static let userHeader = ReusableView<UsersHeaderView>(nibName: "UsersHeaderView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = UsersReactor()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(Reusable.defaultCell)
        tableView.register(Reusable.userHeader)
    }
    
    fileprivate func presentAlert(_ user: ControlEvent<UserModel>.Element) {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "phone", style: .default, handler: { _ in
            if let url = URL(string: "tel://\(user.phone)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "e-mail", style: .default, handler: { _ in
            if let url = URL(string: "mailto://\(user.email)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "website", style: .default, handler: { _ in
            if let url = URL(string: "https://" + user.website) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func bind(reactor: UsersReactor) {
        bind(to: reactor)
        bind(to: reactor)
    }
    fileprivate func bind(to reactor: UsersReactor) {
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.readUsers }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        tableView.rx.modelSelected(UserModel.self)
            .bind(onNext: { [weak self] user in
                self?.presentAlert(user)
            })
            .disposed(by: disposeBag)
    }
    fileprivate func bind(from reactor: UsersReactor) {
        reactor.state.map { $0.filteredUsers }
            .bind(to: tableView.rx.items(Reusable.defaultCell)) { indexPath, user, cell in
                cell.textLabel?.text = user.name
            }
            .disposed(by: disposeBag)
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeue(Reusable.userHeader)
        header?.onFilter = { isFilter1 in
            if isFilter1 {
                self.reactor?.action.onNext(.onFilter(1))
            } else {
                self.reactor?.action.onNext(.onFilter(2))
            }
        }
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
}
