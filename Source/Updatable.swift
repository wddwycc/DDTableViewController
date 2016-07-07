//
//  Updatable.swift
//  Demo
//
//  Created by Carrl on 16/4/18.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit


public protocol Updatable {
    associatedtype ViewData
    func updateWithViewData(viewData: ViewData)
    static func heightWithViewData(viewData: ViewData) -> CGFloat
}

public protocol CellConfiguratorType{
    var reuseIdentifier: String { get }
    var cellClass: AnyClass { get }
    var height:CGFloat { get }
    func updateCell(cell: UITableViewCell)
    var initFromNib:Bool { get set }
}

public struct CellConfigurator<Cell where Cell: Updatable, Cell: UITableViewCell>: CellConfiguratorType{
    public let reuseIdentifier: String = NSStringFromClass(Cell)
    public let cellClass: AnyClass = Cell.self
    public var height: CGFloat {
        return Cell.heightWithViewData(viewData)
    }
    var viewData: Cell.ViewData
    
    public var initFromNib: Bool
    
    public func updateCell(cell: UITableViewCell) {
        if let cell = cell as? Cell {
            cell.updateWithViewData(viewData)
        }
    }

    public init(viewData: Cell.ViewData, initFromNib: Bool) {
        self.viewData = viewData
        self.initFromNib = initFromNib
    }
}
