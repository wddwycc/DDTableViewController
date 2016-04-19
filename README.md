# DDTableViewController


It's lifetime mission for iOS developers to optimize the use of UITableView. Fortunately, I managed a brilliant way to use it inspired by [Arkadiusz Holko's Article](http://holko.pl/2016/01/05/typed-table-view-controller/)

## Install

#### CocoaPods

```ruby
use_frameworks!
pod 'DDTableViewController'
```

#### Manual
Drop files in `Source`folder into your project.


## Use it
Adopt the protocol `Updatable` for all your `UITableViewCell` subclasses. Follow this format:


```swift
import DDTableViewController

class CustomCell:UITableViewCell{
    ...
}

struct CustomCellViewData {
    // Declare all properties you need to decorate the cell
    var image:UIImage
}

extension CustomCell: Updatable {
    typealias ViewData = CustomCellViewData
    func updateWithViewData(viewData: ViewData) {
        // Decorate your cell with the viewData
    }
    static var height: CGFloat{
        // Return the height of your cell here
        return 200
    }
}
```

Then,forget about all `UITableView` delegate methods,use `DDTableViewController`:

```swift
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

let tableVC = DDTableViewController(cellConfigurators: cellConfigurators)
self.addChildViewController(tableVC)
self.view.addSubview(tableVC.view)
tableVC.didMoveToParentViewController(self)
```


**Mission Complete!** (See example in Demo folder)


## Other APIs

#### Insert Cell

```swift
func insertCellAtIndexPath(indexPath indexPath:NSIndexPath, withCellConfigurator cellConfigurator:CellConfiguratorType, RowAnimation animation:UITableViewRowAnimation)
```

#### Delete Cell

```swift
func deleteCellAtIndexPath(indexPath indexPath:NSIndexPath, withRowAnimation animation:UITableViewRowAnimation)
```

#### Reload

```swift
// Manually manipulate the model layer
tableVC.cellConfigurators.append(...)
tableVC.tableView.reloadData()
```
