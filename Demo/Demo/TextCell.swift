//
//  TextCell.swift
//  Demo
//
//  Created by Carrl on 16/4/18.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {
    
    let label = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.label.frame = CGRectMake(0, 30, 200, 60)
        self.contentView.addSubview(self.label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }

}

extension TextCell: DDUpdatable {
    typealias ViewData = TextCellViewData
    func updateWithViewData(viewData: ViewData) {
        self.label.text = viewData.text
    }
    static func heightWithViewData(viewData: ViewData) -> CGFloat {
        return 60
    }
}


struct TextCellViewData {
    let text:String
}

