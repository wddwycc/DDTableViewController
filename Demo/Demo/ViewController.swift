//
//  ViewController.swift
//  Demo
//
//  Created by Carrl on 16/4/18.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableVC:DDTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        let cellConfigurators:[Array<DDCellConfiguratorType>] = [
            // section 0
            [
                // section 0 row 0
                DDCellConfigurator<ImageCell>(viewData: ImageCellViewData(image: UIImage(named: "sample.png")!), initFromNib: false),
                // section 0 row 1
                DDCellConfigurator<TextCell>(viewData: TextCellViewData(text: "Hello World"), initFromNib: false)
            ],
            //section 1
            [
                DDCellConfigurator<ImageCell>(viewData: ImageCellViewData(image: UIImage(named: "sample.png")!), initFromNib: false),
                DDCellConfigurator<ImageCell>(viewData: ImageCellViewData(image: UIImage(named: "sample.png")!), initFromNib: false),
                DDCellConfigurator<ImageCell>(viewData: ImageCellViewData(image: UIImage(named: "sample.png")!), initFromNib: false),
                DDCellConfigurator<ImageCell>(viewData: ImageCellViewData(image: UIImage(named: "sample.png")!), initFromNib: false)
            ]
            // ...
        ]
        self.tableVC = DDTableViewController(cellConfigurators: cellConfigurators)
        self.tableVC.headerConfigurators = {
            let configurators = [
                DDHeaderFooterConfigurator(title: "I am usual header", view: nil),
                DDHeaderFooterConfigurator(title: nil, view: nil)
            ]
            return configurators
        }()
        self.tableVC.footerConfigurators = {
            let footerHeight: CGFloat = 40
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: 0, height: footerHeight)
            view.backgroundColor = UIColor.greenColor()
            let label = UILabel()
            label.frame = CGRect(x: 0, y: 0, width: 300, height: footerHeight)
            label.text = "I am custimized footer"
            view.addSubview(label)
            let configurator = DDHeaderFooterConfigurator(title: nil, height: footerHeight, view: view)
            let footerConfigurators = [
                DDHeaderFooterConfigurator.emptyConfigurator(),
                configurator
            ]
            return footerConfigurators
        }()
        self.addChildViewController(tableVC)
        self.view.addSubview(tableVC.view)
        tableVC.view.frame = CGRectMake(0, 20, self.view.bounds.width, self.view.bounds.height - 120)
        tableVC.didMoveToParentViewController(self)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didPressAddCell(sender: AnyObject) {
//        let imageCellViewData = ImageCellViewData(image: UIImage(named: "sample.png")!)
        let configurator = DDCellConfigurator<TextCell>(viewData: TextCellViewData(text: "Hello World"), initFromNib: false)
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

