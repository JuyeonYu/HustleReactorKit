//
//  PostTableViewCell.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/23.
//

import UIKit
import RxSwift
import ReactorKit

class PostTableViewCell: UITableViewCell, StoryboardView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var bookmark: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    func bind(reactor: PostCellReactor) {
        reactor.state
            .subscribe(onNext: {
                self.title.text = $0.title
                self.body.text = $0.body
                self.bookmark.isSelected = $0.isBookmarked
            })
            .disposed(by: disposeBag)
    }
}
