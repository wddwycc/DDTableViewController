# DDTableViewController
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/wddwycc/DDTableViewController/master/LICENSE)

It's lifetime mission for iOS developers to optimize the use of UITableView. Fortunately, I managed a declarative way to use it inspired by [Arkadiusz Holko's Article](http://holko.pl/2016/01/05/typed-table-view-controller/).

This approach allows crafting a tableView with different kind of cells much easier and faster.


Here is how you initialize a full feature UITableView

```swift
import DDTableViewController

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
        DDCellConfigurator<ImageCell>(viewData: ImageCellViewData(image: UIImage(named: "sample2.png")!), initFromNib: false)
    ]
    // ...
]

let tableVC = DDTableViewController(cellConfigurators: cellConfigurators)
```

Adopt the protocol `Updatable` for all your `UITableViewCell` subclasses:

```swift
class CustomCell:UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ...
    }

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
    static func heightWithViewData(viewData: ViewData) -> CGFloat {
        return 60
    }
}
```



## Install

#### CocoaPods

```ruby
use_frameworks!
pod 'DDTableViewController'
```

#### Carthage

```sh
git "https://github.com/wddwycc/DDTableViewController" "master"
```

#### Manual
Drop files in `Source` folder into your project.


## Other APIs

#### Insert/Delete Cell

```swift
func insertCellAtIndexPath(indexPath indexPath:NSIndexPath, withCellConfigurator cellConfigurator:CellConfiguratorType, RowAnimation animation:UITableViewRowAnimation)
func deleteCellAtIndexPath(indexPath indexPath:NSIndexPath, withRowAnimation animation:UITableViewRowAnimation)
```

#### Reload Table

```swift
// Manually manipulate the model layer
tableVC.cellConfigurators.append(...)
tableVC.tableView.reloadData()
```

#### Scroll

```swift
func scrollToBottom(animated animated:Bool)
func scrollToTop(animated animated:Bool)
```

## Best Practices

#### Load Web image In Cell Asynchronously
I recommend to use [Kingfisher](https://github.com/onevcat/Kingfisher) to Simplify Cell Logic

```swift
func updateWithViewData(viewData: ViewData) {
    ...

    imageView.kf_setImageWithURL(NSURL(string: viewData.imageURL)!,
                                 placeholderImage: nil,
                                 optionsInfo: nil,
                                 progressBlock: { (receivedSize, totalSize) -> () in
                                    print("Download Progress: \(receivedSize)/\(totalSize)")
        },
                                 completionHandler: { (image, error, cacheType, imageURL) -> () in
                                    print("Downloaded and set!")
        }
    )
}

// when cell disappear, cancel the download task and later presentation.
override func prepareForReuse() {
    super.prepareForReuse()
    imageView.kf_cancelDownloadTask()
}


```
