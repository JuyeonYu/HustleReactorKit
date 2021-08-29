//
//  CommentTableViewCell.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/29.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mail: UILabel!
    
    var disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
