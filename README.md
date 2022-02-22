![NVMColor_header](https://user-images.githubusercontent.com/44820440/141615439-fc093b8e-4a88-4898-9e10-46ed760f76fc.png)

<h3 align="center">iOS · macOS · watchOS · tvOS</h3>

---

A pure Swift library that allows you to easily convert SwiftUI Colors to Hex String and vice versa.

This framework extends the **Color**, **UIColor** and **NSColor** types.
Depending on the target version, you have the same functions as SwifUI's **Color**.

This project is created and maintained by Novem.

---

- [Installation](#installation)
  - [Swift Package Manager](#swift-package-manager)
- [Usage Guide](#usage-guide)
  - [Hex string to Color](#hex-string-to-color)
  - [Color to Hex string](#color-to-hex-string)
  - [Compare 2 Colors](#compare-2-colors)
  - [Themed Color](#themed-colors)

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

You can use The Swift Package Manager (SPM) to install NVMRegion by adding the following description to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/NVMNovem/NVMColor_swift", from: "1.0.0"),
    ]
)
```
Then run `swift build`. 

You can also install using SPM in your Xcode project by going to 
"Project->NameOfYourProject->Swift Packages" and placing "https://github.com/NVMNovem/NVMColor" in the 
search field. Then select the option that is most suited for your needs.


## Usage Guide

### Hex string to Color
```swift
let color = Color(hex: "159F84")
```

### Color to Hex string
```swift
let hexColor = Color.green.hex
```

### Compare 2 Colors

Non valid comparisson
```swift
if Color.green.isEqual(to: .red) {
   //Will not be executed
}
```

Non valid comparisson using tolerance
```swift
if Color.green.isEqual(to: .red, tolerance: 0.5) {
   //Will not be executed
}
```

Valid comparisson
```swift
if Color.green.isEqual(to: Color(hex: "34C759")) {
   //Will be executed
}
```

Valid comparisson using tolerance
```swift
if Color.green.isEqual(to: Color(hex: "34C759"), tolerance: 0.5) {
   //Will be executed
}
```

You can also compare by using the NVMColor function.
```swift
if NVMColor.colorsAreEqual(.green, to: Color(hex: "34C759")) {
   //Will be executed
}
```

### Themed Color

You can get a color that fits the current device sheme if the input color is to close to the device scheme color.
```swift
struct MyView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Text("My custom text")
            .foregroundColor(Color(hex: "2E3240")!.themedColor(colorScheme))
    }
}
```
