//
//  ViewController.swift
//  Demo
//
//  Created by Carrl on 16/4/18.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableVC:DDTableViewController! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let cellConfigurators:[Array<CellConfiguratorType>] = [
            // section 0
            [
                // section 0 row 0
                CellConfigurator<ImageCell>(viewData: ImageCellViewData(image: UIImage(named: "sample.png")!), initFromNib: false),
                // section 0 row 1
//                CellConfigurator<TextCell>(viewData: TextCellViewData(text: "Hello World"), initFromNib: false)
            ],
            //section 1
            [
                CellConfigurator<ImageCell>(viewData: ImageCellViewData(image: UIImage(named: "sample.png")!), initFromNib: false)
            ]
            // ...
        ]
        self.tableVC = DDTableViewController(cellConfigurators: cellConfigurators)
        self.addChildViewController(tableVC)
        self.view.addSubview(tableVC.view)
        tableVC.view.frame = CGRectMake(0, 0, self.view.bounds.width, 300)
        tableVC.didMoveToParentViewController(self)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didPressAddCell(sender: AnyObject) {
//        let imageCellViewData = ImageCellViewData(image: UIImage(named: "sample.png")!)
        let configurator = CellConfigurator<TextCell>(viewData: TextCellViewData(text: "Hello World"), initFromNib: false)
        self.tableVC.insertCellAtIndexPath(indexPath: NSIndexPath(forRow: 0, inSection: 0), withCellConfigurator: configurator, RowAnimation: .Fade)
        
        
    }
    @IBAction func didPressScrollToBottom(sender: AnyObject) {
        self.tableVC.scrollToBottom(animated: true)
    }
    @IBAction func didPressScrollToTop(sender: AnyObject) {
        self.tableVC.scrollToTop(animated: true)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
    }

}

