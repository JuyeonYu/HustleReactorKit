//
//  UsersHeaderView.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/26.
//

import UIKit

class UsersHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var filter1: UIButton!
    @IBOutlet weak var filter2: UIButton!
    var onFilter: ((Bool) -> Void)?
    
    @IBAction func onFilter1(_ sender: Any) {
        filter1.layer.borderWidth = 1
        filter1.layer.borderColor = UIColor.black.cgColor
        filter2.layer.borderWidth = 1
        filter2.layer.borderColor = UIColor.gray.cgColor
        onFilter?(true)
    }
    @IBAction func onFilter2(_ sender: Any) {
        filter1.layer.borderWidth = 1
        filter1.layer.borderColor = UIColor.gray.cgColor
        filter2.layer.borderWidth = 1
        filter2.layer.borderColor = UIColor.black.cgColor
        onFilter?(false)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
