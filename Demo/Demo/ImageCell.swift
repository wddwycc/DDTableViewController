//
//  ImageViewCell.swift
//  Demo
//
//  Created by Carrl on 16/4/18.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    let mainImageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.mainImageView.frame = CGRectMake(24, 20, 160, 160)
        self.mainImageView.clipsToBounds = true
        self.mainImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.contentView.addSubview(self.mainImageView)
        
    }
    

    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ImageCell: DDUpdatable {
    typealias ViewData = ImageCellViewData
    func updateWithViewData(viewData: ViewData) {
        self.mainImageView.image = viewData.image
    }
    static func heightWithViewData(viewData: ViewData) -> CGFloat {
        return 200
    }
}


struct ImageCellViewData {
    var image:UIImage
}

