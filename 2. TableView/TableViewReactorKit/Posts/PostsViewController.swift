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
        bind(to: reactor)
        bind(from: reactor)
    }
    fileprivate func bind(to reactor: PostsReactor) {
        rx.viewWillAppear
            .map { _ in Reactor.Action.readPosts }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        tableView.rx.prefetchRows
            .distinctUntilChanged()
            .filter { indexPaths in
                for indexPath in indexPaths
                where indexPath.row == reactor.currentState.posts.count - 1 {
                    return true
                }
                return false
            }
            .map { _ in Reactor.Action.loadMore}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    fileprivate func bind(from reactor: PostsReactor) {
        reactor.state
            .map { $0.posts }
            .bind(to: tableView.rx.items) { tableView, row, post in
                if row % 5 == 0 {
                    guard let cell = tableView.dequeue(Reusable.defaultCell) else { return UITableViewCell() }
                    cell.textLabel?.text = "deleted"
                    cell.textLabel?.textColor = .red
                    return cell
                } else {
                    guard let cell = tableView.dequeue(Reusable.postCell) else { return UITableViewCell() }
                    cell.reactor = PostCellReactor(title: post.title,
                                                   body: post.body)
                    cell.bookmark.rx.tap
                        .map { Reactor.Action.obBookmark(row) }
                        .bind(to: reactor.action)
                        .disposed(by: cell.disposeBag)
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
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
}
