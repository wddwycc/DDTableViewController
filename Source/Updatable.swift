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
    static var height:CGFloat {get}
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
    public let height: CGFloat = Cell.height
    
    var viewData: Cell.ViewData
    
    public var initFromNib: Bool
    
    public func updateCell(cell: UITableViewCell) {
        if let cell = cell as? Cell {
            cell.updateWithViewData(viewData)
        }
    }
}
