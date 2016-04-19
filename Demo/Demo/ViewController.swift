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
                CellConfigurator<TextCell>(viewData: TextCellViewData(text: "Hello World"), initFromNib: false)
            ],
            //section 1
            [
                CellConfigurator<ImageCell>(viewData: ImageCellViewData(image: UIImage(named: "sample2.png")!), initFromNib: false)
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
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        let imageCellViewData = ImageCellViewData(image: UIImage(named: "sample.png")!)
        let configurator = CellConfigurator<ImageCell>(viewData: imageCellViewData, initFromNib: false)
        
        self.tableVC.insertCellatIndexPath(indexPath: NSIndexPath(forRow: 0, inSection: 2), withCellConfigurator: configurator, RowAnimation: .Fade)
        
    }

}

