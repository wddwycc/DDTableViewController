//
//  DDTableView.swift
//  Demo
//
//  Created by Carrl on 16/4/18.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

public class DDTableViewController: UITableViewController {
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Model
    public var cellConfigurators = [Array<CellConfiguratorType>]()
    
    
    // MARK: Public
    public init(cellConfigurators:[Array<CellConfiguratorType>]){
        super.init(style: UITableViewStyle.Plain)
        self.cellConfigurators = cellConfigurators
        self.registerCells()
        
    }
    
    
    /// Insert Cell
    public func insertCellAtIndexPath(indexPath indexPath:NSIndexPath, withCellConfigurator cellConfigurator:CellConfiguratorType, RowAnimation animation:UITableViewRowAnimation){
        let targetSection = min(max(indexPath.section, 0), self.cellConfigurators.count - 1)
        let targetRow = min(max(indexPath.row, 0), self.cellConfigurators[targetSection].count)
        
        self.cellConfigurators[targetSection].insert(cellConfigurator, atIndex: targetRow)
        self.registerCells()
        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: targetRow, inSection: targetSection)], withRowAnimation: animation)
    }
    /// Delete Cell
    public func deleteCellAtIndexPath(indexPath indexPath:NSIndexPath, withCellConfigurator cellConfigurator:CellConfiguratorType, withRowAnimation animation:UITableViewRowAnimation){
        let targetSection = min(max(indexPath.section, 0), self.cellConfigurators.count - 1)
        let targetRow = min(max(indexPath.row, 0), self.cellConfigurators[targetSection].count - 1)
        
        self.cellConfigurators[targetSection].removeAtIndex(targetRow)
        self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: targetRow, inSection: targetSection)], withRowAnimation: animation)
    }
    
    
    
    // MARK: Private
    private func registerCells(){
        for configuratorsInSection in self.cellConfigurators{
            for configurator in configuratorsInSection{
                if(configurator.initFromNib == false){
                    self.tableView.registerClass(configurator.cellClass, forCellReuseIdentifier: configurator.reuseIdentifier)
                }else{
                    self.tableView.registerNib(UINib(nibName: String(configurator.reuseIdentifier), bundle: nil), forCellReuseIdentifier: configurator.reuseIdentifier)
                }
            }
        }
    }
}


// MARK: Configurate TableView
extension DDTableViewController{
    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.cellConfigurators.count
    }
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellConfigurators[section].count
    }
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentConfigurator = self.cellConfigurators[indexPath.section][indexPath.row]
        let cell = self.tableView.dequeueReusableCellWithIdentifier(currentConfigurator.reuseIdentifier)!
        currentConfigurator.updateCell(cell)
        return cell
    }
    override public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let currentConfigurator = self.cellConfigurators[indexPath.section][indexPath.row]
        return currentConfigurator.height
    }
}
