# BRQBottomSheet

## General Information

* BRQBottomSheet is a framework that transforms any ViewController or UITableViewController into a bottom sheet.
* **Attention**: The component will only work perfectly if your viewController has all the constraints defined (The ViewController needs to know whether to auto resize)

## How to Install

## How to Use 
* The framework already contains a ViewModel with two inits, one with some defaults and another fully customizable

```swift
public init() {
    cornerRadius = 20
    animationTransitionDuration = 0.3
    backgroundColor = UIColor.black.withAlphaComponent(0.5)
}

public init(cornerRadius: CGFloat,
            animationTransitionDuration: TimeInterval,
            backgroundColor: UIColor ) {

    self.cornerRadius = cornerRadius
    self.animationTransitionDuration = animationTransitionDuration
    self.backgroundColor = backgroundColor
}
``` 
* You can also create your own viewModel with some defaults values, you only need your class to implement the 
```BRQBottomSheetPresentable``` protocol

* To turn your ViewController into a BottomSheet you just need to do this:

``` swift
let myViewController = MyViewController()

let bottomSheetViewModel = BRQBottomSheetViewModel(
    cornerRadius: 20,
    animationTransitionDuration: 0.3,
    backgroundColor: UIColor.red.withAlphaComponent(0.5)
)

let bottomSheetVC = BRQBottomSheetViewController(
    viewModel: bottomSheetViewModel,
    childViewController: myViewController
)

presentBottomSheet(bottomSheetVC, completion: nil)
```
* We create a ```func presentBottomSheet(_ bottomSheet: BRQBottomSheetViewController, completion: (() -> Void)?)``` to help to present your bottomSheet

## Extra Informations
* If you have any trouble open a **Issue**
* If you want to contribute to the project, make a **PR** and explain what your change does.

## Contributors
* Bruno Faganello
