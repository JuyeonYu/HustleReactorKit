//
//  CommentTableViewCell.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/29.
//

import UIKit
import ReactorKit
import RxSwift

class CommentTableViewCell: UITableViewCell, StoryboardView {
    var disposeBag = DisposeBag()
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    func bind(reactor: CommentCellReactor) {
        reactor.state
            .subscribe(onNext: { [weak self] in
                self?.body.text = $0.body
                self?.name.text = $0.name
                self?.mail.text = $0.mail
            })
            .disposed(by: disposeBag)
    }
}
