//
//  DDLoadingCell.swift
//  Demo
//
//  Created by 闻端 on 16/7/12.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

private let loadingCellHeight: CGFloat = 60

public class DDLoadingCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let width = UIScreen.mainScreen().bounds.width
        let dots = [CALayer(), CALayer(), CALayer()]
        for i in 0 ..< dots.count {
            dots[i].frame.size = CGSize(width: 12, height: 12)
            dots[i].backgroundColor = UIColor(white: 204.0 / 255.0, alpha: 1).CGColor
            dots[i].cornerRadius = 6
            dots[i].position = CGPoint(x: width / 2 + (CGFloat(i) - 1) * 22, y: 30)
            dots[i].transform = CATransform3DMakeScale(0, 0, 0)
            contentView.layer.addSublayer(dots[i])
            let animation = CABasicAnimation(keyPath: "transform")
            animation.repeatCount = HUGE
            animation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0))
            animation.toValue = NSValue(CATransform3D: CATransform3DIdentity)
            animation.duration  = 0.6
            animation.autoreverses = true
            animation.beginTime = CACurrentMediaTime() + 0.2 * Double(i)
            dots[i].addAnimation(animation, forKey: "transform")
        }
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DDLoadingCell: DDUpdatable {
    public typealias ViewData = DDLoadingCellViewData
    public func updateWithViewData(viewData: ViewData) {
        
    }
    public static func heightWithViewData(viewData: ViewData) -> CGFloat {
        return loadingCellHeight
    }
}

public struct DDLoadingCellViewData {
    var loading = false
}
