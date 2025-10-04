# LWThemeManager Swift Version

## 概述

LWThemeManager_swift 是 LWThemeManager 的 Swift 版本实现，提供了现代化的 Swift API 用于主题管理，特别适合万能输入法等需要主题切换的应用。

## 安装

### CocoaPods

在您的 `Podfile` 中添加：

```ruby
pod 'LWThemeManager_swift'
```

然后运行：

```bash
pod install
```

## 使用方法

### Swift

```swift
import LWThemeManager_swift

// 使用 LWThemeManager
let themeManager = LWThemeManager.shared
themeManager.loadTheme(named: "dark")

// 获取当前主题
let currentTheme = themeManager.currentTheme

// 切换主题
themeManager.switchTheme(to: "light")
```

### SwiftUI (使用 Observable)

```swift
import SwiftUI
import LWThemeManager_swift

struct ContentView: View {
    @ObservedObject var themeManager = LWThemeManagerObservable.shared

    var body: some View {
        VStack {
            Text("Current Theme: \(themeManager.currentTheme)")
            Button("Switch Theme") {
                themeManager.switchToNextTheme()
            }
        }
    }
}
```

## 主要特性

- **主题管理**: 支持多主题加载和切换
- **SwiftUI 集成**: 提供 ObservableObject 支持响应式更新
- **主题扩展**: 通过 LWThemeExtension 扩展主题功能
- **资源管理**: 内置键盘主题资源包

## 系统要求

- iOS 11.0+
- Swift 5.0+
- Xcode 12.0+

## 与 Objective-C 版本的关系

- **LWThemeManager**: Objective-C 版本，适用于传统的 Objective-C 项目
- **LWThemeManager_swift**: Swift 版本，提供现代化的 Swift API 和 SwiftUI 支持

您可以根据项目需要选择合适的版本。两个版本功能相同，但 Swift 版本提供了更好的类型安全性和 SwiftUI 集成。

## License

LWThemeManager_swift is available under the MIT license. See the LICENSE file for more info.
