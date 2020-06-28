# Personal Notes

[![](https://img.shields.io/badge/Modern%20Auto%20Layout-v1.2-36A9AE?logo=gumroad)](https://useyourloaf.com/autolayout/) [![](https://img.shields.io/badge/Xcode-10.3-3d8af0?logo=xcode)](#) [![](https://img.shields.io/badge/Swift-5.0-FA7343?logo=swift)](#)

#### Table of Contents
1. [Programmatic Constraints](#programmatic-constraints)
    - [NSLayoutConstraint](#nslayoutconstraint)
    - [Visual Format Language](#visual-format-language-vfl)
    - [Layout Anchors](#layout-anchors)
2. [Safe Areas & Layout Margins](#safe-areas--layout-margins)
3. [Layout Priorities & Content Sizes](#layout-priorities--content-sizes)
    - [Content Size Priority](#content-size-priority)
4. [Stack Views](#stack-views)
5. [Understanding the Layout Engine](#understanding-the-layout-engine)
6. [Debugging](#debugging)
7. [Scroll Views](#scroll-views)
    - [Managing the Keyboard](#managing-the-keyboard)
8. [Dynamic Type](#dynamic-type)
    - [Scaling Dynamic Type](#scaling-dynamic-type)
    - [Custom Fonts](#custom-fonts)
9. [Table Views](#table-views)
    - [Self-Sizing Table View Cells](#self-sizing-table-view-cells)
10. [Adapting for Size](#adapting-for-size)
    - [Supporting iPad Multitasking](#supporting-ipad-multitasking)
    - [The UITraitEnvironment Protocol](#the-uitraitenvironment-protocol)
    - [The UIContentContainer Protocol](#the-uicontentcontainer-protocol)
    - [Variable-Width Strings](#variable-width-strings)

- [Links & Acknowledgments](#links--acknowledgments)

## Programmatic Constraints

There are multiple ways to create constraints within code, although certain methods have specific use-cases or demonstrable advantages over others. However, please note the following important caveats:

- before activating a constraint between two views, ensure both have been added to view hierarchy
- programmatic constraints are **inactive** by default
- removing a view deactivates and removes any corresponding constraints to it or its subviews
- you must disable a view's autoresizing mask manually when creating constraints in code

### NSLayoutConstraint

Easily the most verbose, unsafe and tedious of methods due to lots of unreadable boilerplate code. To make matters worse, there are no compile-time warnings for invalid constraints.

```swift
  NSLayoutConstraint.init(
    item: UIView,                               // source view
    attribute: NSLayoutConstraint.Attribute,    // element of source view used in relation to reference view
    relatedBy: NSLayoutConstraint.Relation,     // .equal, .lessThanOrEqual, .greaterThanOrEqual
    toItem: UIView,                             // reference view (or nil)
    attribute: NSLayoutConstraint.Attribute,    // element of reference view to be used
    multiplier: CGFloat,                        // percentage-based calculations
    constant: CGFloat)                          // static calculations
```

### Visual Format Language (VFL)

Allows you to describe constraints within ASCII-style format strings, providing a (potentially) concise visual element to layout code.

```swift
  NSLayoutConstraint.constraints(
    withVisualFormat: String,                   // string visualizing layout
    options: [NSLayoutFormatOptions],           //
    metrics: [String: Any]?,                    // dictionary for styling metrics
    views: [String: Any])                       // dictionary for included views
```

### Layout Anchors

The `NSLayoutAnchor` class is a factory class for `NSLayoutConstraint` introduced in **iOS 9**, providing methods to interact with each view's similar constraint attributes. This enhancement also allows you to utilize `leading` and `trailing` anchors to support RTL (right-to-left) languages and flip the interface when necessary.

```swift
  NSLayoutConstraint.activate[
    subView.leadingAnchor.constraint(equalTo: superView.layoutMarginsGuide.leadingAnchor),
    subView.centerYAnchor.constraint(equalTo: superView.centerYAnchor),
    subView.widthAnchor.constraint(lessThanOrEqualTo: superView.widthAnchor),
    superView.bottomAnchor.constraint(equalToSystemSpacingBelow: subView.bottomAnchor, multiplier: 1.0)]
```

You are only allowed to create constraints between anchors of the same type (see below for list). Xcode will do its best to prevent you from coupling incompatible anchors; however, it's not foolproof, still allowing you to create conflicting constraints for anchors within the corresponding type.

#### Horizontal Constraints
- `centerXAnchor`
- `leadingAnchor`, `trailingAnchor`
- `leftAnchor`, `rightAnchor`

#### Vertical Constraints
- `centerYAnchor`
- `topAnchor`, `bottomAnchor`
- `firstBaselineAnchor`, `lastBaselineAnchor`

#### Size-Based Constraints
- `heightAnchor`, `widthAnchor`

## Safe Areas & Layout Margins

Added by Apple in **iOS 11**, safe area layout guides help to define a rectangular area for you to display content without having it obstructed by the status or navigation bars, the home control indicator, or the "notch" cutout.

- a view must be loaded and displayed on-screen for its safe area layout area to be set
- you **cannot** change the safe area layout guide or insets
  - however, you can increase a view controller's safe area by adjusting the `additionalSafeAreaInsets` property
- if a view controller must respond to changes to its safe area insets, use `viewSafeAreaInsetsDidChange()`
  - use `safeAreaInsetsDidChange()` for a custom view
- disable safe area relative margins by setting a view's `insetsLayoutMarginsFromSafeArea` property to `false`
- a `UILayoutGuide` is **not** part of the view hierarchy, but **does** need a superview

#### Changing Margin Sizes
- custom views automatically have a layout margin of `8`
- margins for a view controller's root view are managed and enforced by the system, but can be modified if target is **iOS 11** or newer
  - minimum left and right margins will be `16.0` or `20.0` depending on view width
  - top and bottom margins are `0` by default
  - accessible via `minimumSystemLayoutMargins` property
  - can be ignored by changing the value of the `viewRespectsSystemMinimumLayoutMargins` property to `false`
  - preserve a superview's margins by setting the `preservesSuperviewLayoutMargins` property to `true`

## Layout Priorities & Content Sizes

Any constraints you create, once activated, are interpreted by the layout engine as required by default, which may result in an invalid layout when the engine attempts to satisfy the erroneous constraints. However, before activating the constraint you have the ability to make a constraint optional. Additionally, as long as a constraint remains optional, you can modify its `priority`.

Certain views have natural sizes due to their content, accessible by its `intrinsicContentSize` property. These views also contain a `contentMode` property which dictates how the view's content adjusts to bound changes. There are 13 different options which fall into any of three main categories:

#### Scaling
- `scaleToFill`: stretches the content to fill available space, ignoring the original aspect ratio
- `scaleAspectFit`: stretches the content until either the height or width fill the available corresponding space, preserving the aspect ratio
- `scaleAspectFill`: stretches the content until **both** the height and width fill the available space, preserving the aspect ratio

#### Positioning
- these modes allow you to pin the content to one of nine (9) possible positions inside the view:
  - `center`
  - `top`, `bottom`, `left`, `right`
  - `topLeft`, `topRight`, `bottomLeft`, `bottomRight`

#### Redrawing
- `redraw`: triggers the `setNeedsDisplay()` method on the view when its bounds change

### Content Size Priority

There may be times where a view's natural content size does not conform to the defined constraints and it must be squeezed or stretched in order to create a valid layout. When there are multiple elements like present, you can mark which one you'd like to squeeze or stretch by setting the element's content-hugging or compression-resistance priority.

By default, most views created programmatically have a default content-hugging priority of `defaultLow` (250) and a compression-resistance of `defaultHigh` (750).

```swift
  private let sampleButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Sample", for: .normal)
    button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    return button
  }()
```

## Stack Views

Introduced in **iOS 9**, `UIStackView` is a class that removes the need for a lot of boilerplate layout code, automatically adding constraints for views it manages. For example, by embedding stack views within stack views, you're able to build complex layouts, possibly by only adding constraints for the parent stack view's size and position.

- initialized with following defaults:
  - `axis = .horizontal`
  - `distribution = .fill`
  - `alignment = .fill`
- will not add or honor constraints from hidden subviews
- automatically updates the layout of arranged subviews when a change is made
- is a non-rendering subclass of `UIView`
  - this means it still has a `subviews` property which can be modified
- only the top-most stack view needs to disable `translatesAutoresizingMaskIntoConstraints`
- to remove visibility from a subview, either call `removeFromSuperview()` or hide the view manually
- can accept custom margins configured in order to pad the internal content
  - be sure to set the `isLayoutMarginsRelativeArrangement` property to `true` to adhere to custom margins

## Understanding the Layout Engine

When your views are updated, either by adding or removing subviews, activating or deactivating constraints, etc., the layout engine begins its first of two layout passes. During this first pass, the engine's internal model is updated to reflect new information related to the equations that describe the relationships between the existing views. Once this is complete, any view that has been modified calls `setNeedsLayout()`, scheduling the second layout pass where the user-visible changes are implemented.

:100: **Animation Protip:** After making changes to constraints, call `layoutIfNeeded()` on a main thread to force an update.

## Debugging

Adding identifiers to constraints can help reduce troubleshooting difficulties.

```swift
let centerConstraint = subView.centerXAnchor.constraint(equalTo: superView.centerXAnchor)
centerConstraint.identifier = "CenterConstraint"
```

Several private debugging methods -- which should not be used within a released version of your application -- are available which provide broader information regarding specific properties or ambiguities. For example, by setting a breakpoint and utilizing the `constraintsAffectingLayout(for:)` method, you can investigate all constraints related to a target view along a defined axis. Alternatively, you can check a view's `hasAmbiguousLayout` property to see if your constraints have allowed for multiple valid layouts.

As a final resort, it might be easiest to simply trace and dump the entire view hierarchy:

```swift
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print(view.value(forKey: "_autolayoutTrace")!)
  }
```

If your app seems to lock up while the CPU utilization spikes to 100% and memory usage steadily grows, you may have found yourself in a layout loop. Add the launch argument `-UIViewLayoutFeedbackLoopDebuggingThreshold <50|1000>` to your app, selecting a threshold higher than the number of subviews in your layout. In the console, print the debug data with `po [_UIViewLayoutFeedbackLoopDebugger layoutFeedbackLoopDebugger]`. A layout loop will appear like this within the (verbose) logs:

```
  [LayoutLoop] Degenerate layout!
    Layout feedback loop detected in subtree of <UIView: 0x7fc47f407f90; frame = (0 0; 375 667); >.
```

## Scroll Views

Scroll views help to construct layouts that allow the user to view content that does not fit within the available space.

- `contentOffset`: a `CGPoint` which sets the origin of the scroll view frame in relation to the origin of the content view
- `contentInset`: a `UIEdgeInsets` which allows you to add extra space between the content and the edge of the content view
  - `UIKit` automatically adds content inset to allow for the safe area; this can be changed with the `contentInsetAdjustmentBehavior` property
- `contentSize`: a `CGSize` that sets the width and height of the content area, controlling how far a user can scroll
  - ex. if the content's size is wider than the scroll view's width, the user will be able to scroll horizontally

Apple added two layout guides in **iOS 11** to reduce the headache surrounding a layout involving a scroll view:
  - `frameLayoutGuide`: used to constraint the scroll view to an external view
  - `contentLayoutGuide`: used to constrain the contents of a scroll view to its size

:100: **Floating Content Protip:** To creating a floating view, pinned to a fixed position instead of scrolling with the rest of the scroll view's content, constraint the respective view to a scroll view's `layoutMarginsGuide`.

### Managing the Keyboard

You may not be expecting (or even support) a keyboard in any specific view within your app, but if used in iPad split-screen mode, it's possible that your content becomes obstructed by a keyboard on-screen. To account for and manage this possibility, use the `contentInset` of the scroll view.

1. Add observers for system keyboard notifications: `keyboardDidShow(_:)` and `keyboardDidHide(_:)`
2. Check the `userInfo` dictionary for the key `UIResponder.keyboardFrameEndUserInfoKey`. It's an `NSValue` containing a `CGRect` for the keyboard frame.
3. Set the scroll view's `contentInsets` and `scrollIndicatorInsets` to account for the keyboard's height.

```swift
  let adjustedInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
  scrollView.contentInsets = adjustedInsets
  scrollView.scrollIndicatorInsets = adjustedInsets
```

4. When the keyboard is hidden, reset the properties to `.zero`

:100: **Adaptive Scroll View Protip:** See Keith's custom subclass [here](https://github.com/seventhaxis/modern-auto-layout/blob/master/ch11.scroll-views/ch11e.managing-keyboard/chapter11e/AdaptiveScrollView.swift).

## Dynamic Type

Rather than hard-code the font across your app, you can use dynamic type and honor the user's preference for how large or small they'd like their text to appear. There are **12** potential user-defined sizes for **11** different styles:

- **iOS 7:** `headline`, `subheadline`, `body`, `footnote`, `caption1`, `caption2`
- **iOS 9:** `title1`, `title2`, `title3`, `callout`
- **iOS 11:** `largeTitle`

The simplest way to honor a user's dynamic type preference is to call `UIFont.preferredFont(forTextStyle:)` and set the element's `adjustsFontForContentSizeCategory` property to `true`.

```swift
  exampleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
  exampleLabel.adjustsFontForContentSizeCategory = true
```

Additionally, for wide viewing frames, it may make sense to constrain an element to a superview's `readableContentGuide`, ensuring you're not displaying a massive wall of text on-screen.

:100: **Readable Stack View Protip:** Embed your `UIStackView` inside a container `UIView` and constrain the stack to the containing view's readable guide.

### Scaling Dynamic Type

It's possible to change an attribute for a font with a `UIFontDescriptor`. You can use the font descriptor to define a specific `UITextStyle` by using the `UIFontDescriptor.preferredFontDescriptor(withTextStyle:)` method, then add your trait variation(s) like so:

```swift
  let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
  if let boldDescriptor = descriptor.withSymbolicTraits(.traitBold) {
    exampleLabel.font = UIFont(descriptor: boldDescriptor, size: 0)
  }
```

Next, ensure that you aren't enabling the `adjustsFontForContentSizeCategory` property for the element. Lastly, setup an observer for the notification `UIContentSizeCategory.didChangeNotification`, adjusting the view(s) as necessary:

```swift
  NotificationCenter.default.addObserver(self, selector: #selector(didChangePreferredFont(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
```

### Custom Fonts

Apple introduced `UIFontMetrics` in **iOS 11**, making it much easier to load custom fonts for use with dynamic type. Also, remember to enable to `adjustsFontForContentSizeCategory` property.

```swift
  let bodyMetrics = UIFontMetrics(forTextStyle: .body)
  let myFont = UIFont(name: "CustomFontName", size: largeFontSize)
  exampleLabel.font = bodyMetrics.scaledFont(for: myFont)
  exampleLabel.adjustsFontForContentSizeCategory = true
```

:100: **Custom Font Protip:** Check for all loaded and available fonts with the following loop:

```swift
  UIFont.familyNames.sorted().forEach { family in
    print(family)
    let names = UIFont.fontNames(forFamilyName: family)
    print(names)
  }
```

## Table Views

- table cells have an inherent width set by the table view
- to set the row height, you can:
  1. define a static `rowHeight` for all cells
  2. override `tableView(_:, heightForRowAt:)`, requiring this to be called _every_ time a cell is displayed
  3. create dynamic, self-sizing cells

### Self-Sizing Table View Cells
- ensure views are added as subviews to the cell's `contentView`
- set the table view's `rowHeight` and `estimatedRowHeight` to `automaticDimension`
- subviews can be set to follow the cell's `readableContentGuide`
  - the default for **iOS 12** is `false`; for earlier versions, the default is `true`

## Adapting for Size

By using the `UITraitCollection` class, you can design layouts with respect to a variety of different device properties:

- `horizontalSizeClass`, `verticalSizeClass`
- `displayScale`, `displayGamut`
- `userInterfaceIdiom`, `userInterfaceStyle`
- `forceTouchCapability`
- `layoutDirection`
- `preferredContentSizeCategory`

Please note that many traits have a default value of `unspecified` when the system has not set a value because the object is not yet added to the view hierarchy.

The two most commonly used traits are the horizontal and vertical size classes. There are too many size class configurations due to the sheer amount of device types, sizes, and orientations; for a good baseline however, remember the following:

- all portrait iPhones have `hSC.compact` and `vSC.regular`
- _most_ landscape iPhones have `hSC.compact` and `vSC.compact`
  - exceptions are landscape **XR**, **Plus** and **Max** models with `hSC.regular`
- iPads always have `vSC.regular` regardless of orientation or split-screen utilization
- fullscreen iPads will also always have `hSC.regular`

For more information about each trait, visit the [developer documentation](https://developer.apple.com/documentation/uikit/uitraitcollection).

### Supporting iPad Multitasking
- supported in **Xcode 10** by default
- you **must** use a launch screen storyboard rather than launch images
- also, you are **required** to support all four (4) device orientations
- _should_ embed layouts within a scroll view to account for potential keyboard on-screen
  - see [Managing the Keyboard](#managing-the-keyboard)

### The UITraitEnvironment Protocol
- call `super.traitCollectionDidChange(_:)` first when overriding method
- only compare relevant properties to efficiently evaluate changes from previous trait collection
- the method is called **after** view has been added to the view hierarchy, so it can be used for trait-based layout setup
- available in view controllers **and** subclasses of `UIView`

### The UIContentContainer Protocol
- only adopted by view controllers
- provides two methods for responding to trait or size changes
- ensure you call `super` if overriding either method
- neither method is called with first adding view(s) to hierarchy; **cannot** be used for initial setup

```swift
  willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionController)
```
- called before changing trait collection; old traits are still available at this point

```swift
  viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionController)
```
- called before changing the size of a view controller's view
- the view has not yet changed; old size is still accessible


### Variable-Width Strings
1. Create `Localizable.stringsdict` file within `Base.lproj`.
2. Create a dictionary key for your variable-width string; the value will be a another dictionary with the key `NSStringVariableWidthRuleType`.
3. Inside this nested dictionary are strings that will act as width-variation keys, represented in _em_ units (see [What & How Big is an Em?](#what--how-big-is-an-em)).
4. The value for each rule should be the variable-width string.
5. When assigning the text for your element, use the following format, substituting your key:

```swift
  let sampleText = NSLocalizedString("YourKey", comment: "")
  sampleButton.setTitle(sampleText, for: .normal)
```

#### What & How Big is an Em?
> An _em_ is a typographical measure that defines a distance equal to the type size or a space equal to the square of the type size. The name comes from the traditional use of the width of the capital **M** to approximate the type size.

> In Session 227 from WWDC 2015 on internalization, Apple says they calculate an em value from the number of **M** characters that fit in the visible screen width at the standard system font size of 14 points.

Device | Portrait _(em)_ | Landscape _(em)_
----|----|----
iPhone SE | 22 | 39
iPhone 8 | 25 | 46
iPhone 8 Plus | 28 | 50
iPhone XS | 25 | 56
iPhone XR/XS Max | 28 | 61
iPad Pro 10.5" | 57 | 76
iPad Pro 11" | 57 | 82
iPad Pro 12.9" | 70 | 94

## Links & Acknowledgments
* [Modern Auto Layout](https://useyourloaf.com/autolayout/) by **[Keith Harrison](https://github.com/kharrison)**
