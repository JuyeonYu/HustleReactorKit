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
    // MARK: - Property
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(configureCell: { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeue(Reusable.commentCell, for: indexPath)
        cell.body.text = item.body
        cell.name.text = item.name
        cell.mail.text = item.email
        return cell
    })
    enum Reusable {
        static let commentCell = ReusableCell<CommentTableViewCell>(nibName: "CommentTableViewCell")
        static let defaultCell = ReusableCell<UITableViewCell>()
    }
    @IBOutlet weak var tableView: UITableView!
    var disposeBag: DisposeBag = DisposeBag()
    private let userCache = NSCache<NSString, NSString>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = CommentReactor()
        tableView.register(Reusable.commentCell)
        tableView.register(Reusable.defaultCell)
        
        
    }
    
    func bind(reactor: CommentReactor) {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        rx.viewWillAppear
            .map { _ in Reactor.Action.readComments }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        reactor.state
            .map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension CommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}
