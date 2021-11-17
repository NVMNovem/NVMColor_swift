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
  - [Code](#code)

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

You can use The Swift Package Manager (SPM) to install NVMRegion by adding the following description to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/NVMNovem/NVMColor", from: "1.0.0"),
    ]
)
```
Then run `swift build`. 

You can also install using SPM in your Xcode project by going to 
"Project->NameOfYourProject->Swift Packages" and placing "https://github.com/NVMNovem/NVMColor" in the 
search field. Then select the option that is most suited for your needs.


## Usage Guide

### Code
