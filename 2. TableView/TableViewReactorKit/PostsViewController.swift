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

class PostsViewController: UIViewController, StoryboardView {
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = PostsReactor()
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
    }
    
    func bind(reactor: PostsReactor) {
        rx.viewWillAppear
            .map { _ in Reactor.Action.readPosts }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.posts }
            .bind(to: tableView.rx.items(cellIdentifier: "PostTableViewCell", cellType: PostTableViewCell.self)) { index, post, cell in
                cell.title.text = post.title
                cell.body.text = post.body
                cell.user.text = "\(post.userId)"
            }
            .disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
