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
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "UsersHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "UsersHeaderView")
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

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UsersHeaderView") as! UsersHeaderView
        header.onFilter = { isFilter1 in
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
