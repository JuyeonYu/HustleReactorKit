//
//  CommentsViewController.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/29.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import RxViewController
import ReusableKit
import RxDataSources

class CommentsViewController: UIViewController, StoryboardView, UIScrollViewDelegate {
    enum Reusable {
        static let commentCell = ReusableCell<CommentTableViewCell>(nibName: "CommentTableViewCell")
        static let postCell = ReusableCell<PostTableViewCell>(nibName: "PostTableViewCell")
    }
    @IBOutlet weak var tableView: UITableView!
    var disposeBag: DisposeBag = DisposeBag()
    private let userCache = NSCache<NSString, NSString>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = CommentReactor()
        tableView.register(Reusable.commentCell)
        tableView.register(Reusable.postCell)
    }
    
    func bind(reactor: CommentReactor) {
        bind(to: reactor)
        bind(from: reactor)
    }
    fileprivate func bind(to reactor: CommentReactor) {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        rx.viewWillAppear
            .map { _ in Reactor.Action.readComments }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    fileprivate func bind(from reactor: CommentReactor) {
        reactor.state
            .map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: CommentsViewController.dataSource()))
            .disposed(by: disposeBag)
    }
    
}

extension CommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}

extension CommentsViewController {
    static func dataSource() -> RxTableViewSectionedReloadDataSource<MultipleSectionModel> {
        return RxTableViewSectionedReloadDataSource<MultipleSectionModel>(
            configureCell: { dataSource, table, idxPath, _ in
                switch dataSource[idxPath] {
                case .CommentSectionItem(let item):
                    let cell = table.dequeue(Reusable.commentCell)!
                    cell.reactor = CommentCellReactor(comment: item)
                    return cell
                case .PostSectionItem(let post):
                    let cell = table.dequeue(Reusable.postCell)!
                    cell.reactor = PostCellReactor(title: post.title, body: post.body)
                    cell.title.text = post.title
                    cell.body.text = post.body
                    return cell
                }
            },
            titleForHeaderInSection: { dataSource, index in
                let section = dataSource[index]
                return section.title
            }
        )
    }
}
