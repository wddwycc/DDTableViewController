//
//  DDLoadingCell.swift
//  Demo
//
//  Created by 闻端 on 16/7/12.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

class DDLoadingCell: UITableViewCell {
    let dots: [CAShapeLayer] = {
        let layers = [CAShapeLayer(), CAShapeLayer(), CAShapeLayer()]
        layers.forEach({ (layer) in
            layer.cornerRadius
        })
        return layers
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DDLoadingCellViewData: DDUpdatable {
    typealias ViewData = TextCellViewData
    func updateWithViewData(viewData: ViewData) {
        
    }
    static func heightWithViewData(viewData: ViewData) -> CGFloat {
        return 60
    }
}

struct DDLoadingCellViewData {
    var loading = false
}
