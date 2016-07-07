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
    public var cellConfigurators = [Array<CellConfiguratorType>](){
        didSet{
            if self.cellConfigurators.count == 0 {
                self.cellConfigurators.append(Array<CellConfiguratorType>())
            }
            self.registerCells()
        }
    }
    
    public var clickHandler: ((indexPath: NSIndexPath, configurator: CellConfiguratorType)->())?
    
    // MARK: Public
    public init(cellConfigurators:[Array<CellConfiguratorType>]){
        super.init(style: UITableViewStyle.Plain)
        self.cellConfigurators = cellConfigurators
        self.registerCells()
    }
    
    init() {
        super.init(style: UITableViewStyle.Plain)
    }
    
    
    /// Insert Cell
    public func insertCellAtIndexPath(indexPath indexPath:NSIndexPath, withCellConfigurator cellConfigurator:CellConfiguratorType, RowAnimation animation:UITableViewRowAnimation){
        let targetSection = min(max(indexPath.section, 0), self.cellConfigurators.count - 1)
        let targetRow = min(max(indexPath.row, 0), self.cellConfigurators[targetSection].count)
        
        self.cellConfigurators[targetSection].insert(cellConfigurator, atIndex: targetRow)
        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: targetRow, inSection: targetSection)], withRowAnimation: animation)
    }
    /// Delete Cell
    public func deleteCellAtIndexPath(indexPath indexPath:NSIndexPath, withRowAnimation animation:UITableViewRowAnimation){
        let targetSection = min(max(indexPath.section, 0), self.cellConfigurators.count - 1)
        let targetRow = min(max(indexPath.row, 0), self.cellConfigurators[targetSection].count - 1)
        
        self.cellConfigurators[targetSection].removeAtIndex(targetRow)
        self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: targetRow, inSection: targetSection)], withRowAnimation: animation)
    }
    
    /// Scroll To Bottom
    public func scrollToBottom(animated animated:Bool){
        if(self.cellConfigurators.count == 0){return}
        var currentSectionIndex = self.cellConfigurators.count - 1
        while self.cellConfigurators[currentSectionIndex].count == 0 {
            currentSectionIndex -= 1
            if(currentSectionIndex < 0){return}
        }
        let targetSectionIndex = currentSectionIndex
        let bottomIndexPath = NSIndexPath(forRow: self.cellConfigurators[targetSectionIndex].count - 1, inSection: targetSectionIndex)
        self.tableView.scrollToRowAtIndexPath(bottomIndexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: animated)
    }
    
    /// Scroll To Top
    public func scrollToTop(animated animated:Bool){
        self.tableView.setContentOffset(CGPointMake(0, 0), animated: animated)
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
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        clickHandler?(indexPath: indexPath, configurator: self.cellConfigurators[indexPath.section][indexPath.row])
    }
}
