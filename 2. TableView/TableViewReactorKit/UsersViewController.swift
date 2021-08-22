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

class UsersViewController: UIViewController, StoryboardView {
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = UsersReactor()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func bind(reactor: UsersReactor) {
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.readUsers }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(onNext: { indexPath in
                let user = reactor.currentState.users[indexPath.row]
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
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.users }
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) { indexPath, user, cell in
                cell.textLabel?.text = user.name
            }
            .disposed(by: disposeBag)
    }
}

