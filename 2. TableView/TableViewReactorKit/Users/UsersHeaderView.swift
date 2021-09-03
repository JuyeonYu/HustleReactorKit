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
        toggleOption(isFilter1: true)
    }
    @IBAction func onFilter2(_ sender: Any) {
        toggleOption(isFilter1: false)
    }
    func toggleOption(isFilter1: Bool) {
        filter1.layer.borderWidth = 1
        filter2.layer.borderWidth = 1
        onFilter?(false)
        if isFilter1 {
            filter1.layer.borderColor = UIColor.gray.cgColor
            filter1.backgroundColor = .blue
            filter2.layer.borderColor = UIColor.black.cgColor
            filter2.backgroundColor = .white
        } else {
            filter1.layer.borderColor = UIColor.black.cgColor
            filter1.backgroundColor = .white
            filter2.layer.borderColor = UIColor.gray.cgColor
            filter2.backgroundColor = .blue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
