//
//  PostsViewController.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/23.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import RxViewController
import ReusableKit

class PostsViewController: UIViewController, StoryboardView {
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag: DisposeBag = DisposeBag()
    private let userCache = NSCache<NSString, NSString>()
    
    enum Reusable {
        static let postCell = ReusableCell<PostTableViewCell>(nibName: "PostTableViewCell")
        static let defaultCell = ReusableCell<UITableViewCell>()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = PostsReactor()
        tableView.register(Reusable.postCell)
        tableView.register(Reusable.defaultCell)
    }
    
    func bind(reactor: PostsReactor) {
        rx.viewWillAppear
            .map { _ in Reactor.Action.readPosts }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.posts }
            .bind(to: tableView.rx.items(Reusable.postCell)) { _, post, cell in
                cell.title.text = post.title
                cell.body.text = post.body
                
                if let user = self.userCache.object(forKey: "\(post.userId)" as NSString) {
                    cell.user.text = user as String
                } else {
                    APIManager.shared.readUser(id: post.userId)
                        .asDriver(onErrorJustReturn: "")
                        .drive { user in
                            cell.user.text = user
                            self.userCache.setObject(user as NSString, forKey: "\(post.userId)" as NSString)
                        }
                        .disposed(by: cell.disposeBag)
                }
            }
            .disposed(by: disposeBag)
    }
}
