//
//  PostTableViewCell.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/23.
//

import UIKit
import RxSwift

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var user: UILabel!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
}
