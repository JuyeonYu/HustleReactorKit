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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
