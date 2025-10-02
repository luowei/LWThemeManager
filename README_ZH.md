# LWThemeManager

[![CI Status](https://img.shields.io/travis/luowei/LWThemeManager.svg?style=flat)](https://travis-ci.org/luowei/LWThemeManager)
[![Version](https://img.shields.io/cocoapods/v/LWThemeManager.svg?style=flat)](https://cocoapods.org/pods/LWThemeManager)
[![License](https://img.shields.io/cocoapods/l/LWThemeManager.svg?style=flat)](https://cocoapods.org/pods/LWThemeManager)
[![Platform](https://img.shields.io/cocoapods/p/LWThemeManager.svg?style=flat)](https://cocoapods.org/pods/LWThemeManager)

## 简介

LWThemeManager 是一个轻量级、易用的 iOS 主题管理组件，最初为万能输入法开发，提供完整的主题切换和管理功能。该组件支持动态主题切换、主题自定义、主题持久化存储等特性，适用于需要多主题支持的 iOS 应用。

## 特性

- 单例模式管理，全局统一的主题访问接口
- 支持动态主题切换，无需重启应用
- 支持从 Bundle 资源和沙盒文档目录加载主题
- 提供主题的增删改查完整功能
- 支持从当前主题复制创建新主题
- 支持恢复默认主题设置
- 内置多种预设主题（26+ 种主题风格）
- 提供便捷的宏定义，简化主题值的读写操作
- 支持颜色、字体、数值等多种主题配置项
- UIColor 扩展，支持 RGBA 字符串与 UIColor 互转

## 系统要求

- iOS 8.0+
- Xcode 8.0+

## 安装

### CocoaPods

LWThemeManager 可通过 [CocoaPods](https://cocoapods.org) 安装。在 Podfile 中添加：

```ruby
pod 'LWThemeManager'
```

然后执行：

```bash
pod install
```

### Carthage

在 Cartfile 中添加：

```ruby
github "luowei/LWThemeManager"
```

然后执行：

```bash
carthage update
```

## 使用方法

### 1. 基础使用

#### 获取主题管理器实例

```objective-c
#import <LWThemeManager/LWThemeManager.h>

LWThemeManager *manager = [LWThemeManager sharedInstance];
```

#### 获取当前主题名称

```objective-c
NSString *themeName = [[LWThemeManager sharedInstance] currentName];
```

#### 获取主题字典

```objective-c
NSMutableDictionary *theme = [[LWThemeManager sharedInstance] theme];
```

### 2. 使用宏定义简化操作

LWThemeManager 提供了一组便捷的宏定义，用于快速读取和设置主题值：

#### 从主题中读取值

```objective-c
// 读取浮点数值
CGFloat buttonHeight = FloatValueFromThemeKey(@"btn.height");

// 读取字符串
NSString *fontName = StringValueFromThemeKey(@"font.name");

// 读取 UIColor
UIColor *bgColor = UIColorValueFromThemeKey(@"inputView.backgroundColor");

// 读取 CGColor
CGColorRef borderColor = CGColorValueFromThemeKey(@"btn.borderColor");
```

#### 向主题中写入值

```objective-c
// 写入浮点数值
FloatValueToThemeFileByKey(10.0, @"btn.cornerRadius");

// 写入字符串
StringValueToThemeFileByKey(@"Helvetica", @"font.name");

// 写入 UIColor
UIColorValueToThemeFileByKey([UIColor redColor], @"font.color");

// 写入 CGColor
CGColorValueToThemeFileByKey(button.layer.borderColor, @"btn.borderColor");
```

### 3. 主题管理

#### 切换主题

```objective-c
// 切换到指定主题
[[LWThemeManager sharedInstance] updateThemeWithName:@"darkTheme"];
```

#### 创建新主题

从当前主题复制创建一个新主题：

```objective-c
// 从当前主题复制创建名为 "myCustomTheme" 的新主题
BOOL success = [[LWThemeManager sharedInstance] copyANewThemeWithName:@"myCustomTheme"];
if (success) {
    NSLog(@"主题创建成功");
}
```

#### 更新主题配置

```objective-c
// 更新当前主题的某个配置项
[[LWThemeManager sharedInstance] setThemeValue:@"255,0,0,255" forKey:@"font.color"];

// 更新指定主题的某个配置项
[[LWThemeManager sharedInstance] updateThemeWithName:@"myCustomTheme"
                                                value:@"background.png"
                                               forKey:@"inputView.backgroundImage"];
```

#### 删除主题

```objective-c
// 删除指定主题
[[LWThemeManager sharedInstance] removeThemeWithName:@"myCustomTheme"];
```

#### 恢复默认主题

```objective-c
// 恢复当前主题为默认设置
[[LWThemeManager sharedInstance] recoverDefaultTheme];
```

### 4. 获取资源文件路径

```objective-c
// 获取 Bundle 中的资源文件路径
NSString *imagePath = [LWThemeManager pathInBundleWithFileName:@"background.png"];
UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
```

### 5. UIColor 扩展使用

LWThemeManager 提供了 UIColor 的扩展方法，用于在 RGBA 字符串和 UIColor 之间转换：

```objective-c
// 从 RGBA 字符串创建 UIColor
// 支持两种格式：
// 1. "R,G,B" - RGB 值，透明度默认为 1.0
// 2. "R,G,B,A" - RGBA 值
UIColor *color1 = [UIColor theme_colorWithRGBAString:@"255,0,0,255"];     // 红色，完全不透明
UIColor *color2 = [UIColor theme_colorWithRGBAString:@"127,127,127"];     // 灰色，完全不透明
UIColor *color3 = [UIColor theme_colorWithRGBAString:@"0,255,0,128"];     // 绿色，半透明

// 从 UIColor 获取 RGBA 字符串
NSString *rgbaString = [UIColor theme_rgbaStringFromUIColor:color1];
// 结果：@"255,0,0,255"
```

## 主题配置文件结构

主题配置使用 `.plist` 文件存储，采用 key-value 结构。以下是一个典型的主题配置示例：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- 输入视图背景色 (RGBA 格式) -->
    <key>inputView.backgroundColor</key>
    <string>244,244,244,255</string>

    <!-- 输入视图背景图片 -->
    <key>inputView.backgroundImage</key>
    <string></string>

    <!-- 按钮水平间距 -->
    <key>btn.space.horizon</key>
    <integer>0</integer>

    <!-- 按钮垂直间距 -->
    <key>btn.space.verticel</key>
    <string>0</string>

    <!-- 字体颜色 -->
    <key>font.color</key>
    <string>0,0,0,255</string>

    <!-- 字体名称 -->
    <key>font.name</key>
    <string>Helvetica-Light</string>

    <!-- 高亮字体颜色 -->
    <key>font.highlightColor</key>
    <string>255,255,255,255</string>

    <!-- 按钮背景色 -->
    <key>btn.content.color</key>
    <string>252,252,252,255</string>

    <!-- 按钮高亮颜色 -->
    <key>btn.content.highlightColor</key>
    <string>100,100,100,200</string>

    <!-- 按钮边框颜色 -->
    <key>btn.borderColor</key>
    <string>127,127,127,255</string>

    <!-- 按钮边框宽度 -->
    <key>btn.borderWidth</key>
    <real>0</real>

    <!-- 分隔线宽度 -->
    <key>separator.width</key>
    <real>0.5</real>

    <!-- 按钮圆角半径 -->
    <key>btn.cornerRadius</key>
    <integer>0</integer>

    <!-- 按钮透明度 -->
    <key>btn.opacity</key>
    <integer>0</integer>

    <!-- 按钮阴影颜色 -->
    <key>btn.shadow.color</key>
    <string>127,127,127,255</string>

    <!-- 按钮阴影高度 -->
    <key>btn.shadow.height</key>
    <integer>0</integer>

    <!-- 主标签字体大小 -->
    <key>btn.mainLabel.fontSize</key>
    <integer>22</integer>

    <!-- 顶部标签字体大小 -->
    <key>btn.topLabel.fontSize</key>
    <integer>10</integer>

    <!-- 底部文本字体大小 -->
    <key>footerText.fontSize</key>
    <integer>12</integer>
</dict>
</plist>
```

### 配置项说明

#### 颜色配置
- 使用 RGBA 格式字符串：`"R,G,B,A"`，每个值范围 0-255
- 示例：`"255,0,0,255"` 表示红色，完全不透明

#### 数值配置
- 支持整数 (`<integer>`) 和浮点数 (`<real>`)
- 用于设置尺寸、间距、透明度等数值属性

#### 字符串配置
- 用于设置字体名称、图片路径等文本属性

## 内置主题

LWThemeManager 内置了 26+ 种预设主题，包括：

- `defaultTheme` - 默认主题
- `lightTheme` - 浅色主题
- `classicTheme` - 经典主题
- `travelTheme` - 旅行主题
- `slightlyTheme` - 淡雅主题
- `sunsetTheme` - 日落主题
- `grayishTheme` - 灰调主题
- `versatileTheme` - 多彩主题
- `mysteriousTheme` - 神秘主题
- `vividTheme` - 鲜明主题
- `idarkTheme` - 暗黑主题
- `generalTheme` - 通用主题
- `darknessTheme` - 黑暗主题
- `braveryTheme` - 勇气主题
- `accentTheme` - 强调主题
- `clightTheme` - 清新主题
- `mediterTheme` - 地中海主题
- `cloudsTheme` - 云朵主题
- `calmTheme` - 平静主题
- `natureTheme` - 自然主题
- `swampTheme` - 沼泽主题
- `softTheme` - 柔和主题
- `violetTheme` - 紫罗兰主题
- `retroTheme` - 复古主题
- `vintageTheme` - 怀旧主题
- `magentasTheme` - 洋红主题

所有预设主题位于 `KeyboardTheme.bundle` 资源包中。

## 工作原理

### 主题存储机制

LWThemeManager 使用双层存储机制：

1. **Bundle 资源层**：包含预设的默认主题，位于 `KeyboardTheme.bundle` 中，只读
2. **沙盒文档层**：用户自定义或修改的主题，存储在 `Documents/themes/` 目录下，可读写

### 主题加载流程

1. 调用 `updateThemeWithName:` 切换主题时
2. 首先检查沙盒文档目录中是否存在该主题文件
3. 如果不存在，从 Bundle 资源中复制一份到沙盒文档目录
4. 如果 Bundle 中也不存在，使用 `defaultTheme.plist`
5. 加载主题配置到内存中的 `_theme` 字典

### 主题修改与持久化

- 调用 `setThemeValue:forKey:` 修改主题配置时，会同时更新内存和沙盒文档中的文件
- 这确保了主题修改的持久化，应用重启后配置仍然生效

## 示例项目

运行示例项目：

1. 克隆仓库
2. 进入 Example 目录
3. 执行 `pod install`
4. 打开 `.xcworkspace` 文件
5. 运行项目

```bash
git clone https://github.com/luowei/LWThemeManager.git
cd LWThemeManager/Example
pod install
open LWThemeManager.xcworkspace
```

## 完整使用示例

```objective-c
#import <LWThemeManager/LWThemeManager.h>

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 获取当前主题名称
    NSString *currentTheme = [[LWThemeManager sharedInstance] currentName];
    NSLog(@"当前主题: %@", currentTheme);

    // 使用主题配置设置 UI
    self.view.backgroundColor = UIColorValueFromThemeKey(@"inputView.backgroundColor");

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = UIColorValueFromThemeKey(@"btn.content.color");
    button.layer.cornerRadius = FloatValueFromThemeKey(@"btn.cornerRadius");
    button.layer.borderWidth = FloatValueFromThemeKey(@"btn.borderWidth");
    button.layer.borderColor = CGColorValueFromThemeKey(@"btn.borderColor");

    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorValueFromThemeKey(@"font.color");
    label.font = [UIFont fontWithName:StringValueFromThemeKey(@"font.name")
                                 size:FloatValueFromThemeKey(@"btn.mainLabel.fontSize")];
}

- (void)switchToDarkTheme {
    // 切换到暗黑主题
    [[LWThemeManager sharedInstance] updateThemeWithName:@"idarkTheme"];

    // 重新加载 UI（通知视图更新）
    [self reloadUI];
}

- (void)createCustomTheme {
    // 从当前主题创建自定义主题
    BOOL success = [[LWThemeManager sharedInstance] copyANewThemeWithName:@"myTheme"];

    if (success) {
        // 切换到新主题
        [[LWThemeManager sharedInstance] updateThemeWithName:@"myTheme"];

        // 自定义颜色
        UIColorValueToThemeFileByKey([UIColor redColor], @"font.color");
        UIColorValueToThemeFileByKey([UIColor blackColor], @"inputView.backgroundColor");

        // 自定义数值
        FloatValueToThemeFileByKey(8.0, @"btn.cornerRadius");

        // 重新加载 UI
        [self reloadUI];
    }
}

- (void)restoreDefaultTheme {
    // 恢复默认主题设置
    [[LWThemeManager sharedInstance] recoverDefaultTheme];
    [self reloadUI];
}

- (void)reloadUI {
    // 重新应用主题到所有 UI 元素
    // 实现您的 UI 更新逻辑
}

@end
```

## 高级用法

### 监听主题切换

建议使用通知机制来监听主题切换事件：

```objective-c
// 定义通知名称
NSString *const ThemeDidChangeNotification = @"ThemeDidChangeNotification";

// 在切换主题后发送通知
- (void)switchTheme:(NSString *)themeName {
    [[LWThemeManager sharedInstance] updateThemeWithName:themeName];
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeDidChangeNotification
                                                        object:themeName];
}

// 监听通知
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(themeDidChange:)
                                                 name:ThemeDidChangeNotification
                                               object:nil];
}

- (void)themeDidChange:(NSNotification *)notification {
    NSString *newTheme = notification.object;
    [self updateUIWithTheme:newTheme];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
```

### 主题预览

```objective-c
- (UIImage *)previewImageForTheme:(NSString *)themeName {
    // 保存当前主题
    NSString *currentTheme = [[LWThemeManager sharedInstance] currentName];

    // 临时切换到目标主题
    [[LWThemeManager sharedInstance] updateThemeWithName:themeName];

    // 创建预览视图
    UIView *previewView = [self createPreviewView];

    // 渲染为图片
    UIGraphicsBeginImageContextWithOptions(previewView.bounds.size, NO, 0.0);
    [previewView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *previewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // 恢复原主题
    [[LWThemeManager sharedInstance] updateThemeWithName:currentTheme];

    return previewImage;
}
```

## 最佳实践

1. **单例模式**：始终通过 `[LWThemeManager sharedInstance]` 访问主题管理器
2. **使用宏定义**：利用提供的宏定义简化代码，提高可读性
3. **主题命名规范**：使用有意义的主题名称，如 `darkTheme`、`lightTheme`
4. **配置键命名规范**：使用点分隔的层级结构，如 `btn.content.color`
5. **颜色格式统一**：统一使用 RGBA 字符串格式存储颜色
6. **主题备份**：在修改主题前使用 `copyANewThemeWithName:` 创建备份
7. **通知机制**：使用通知机制在主题切换时自动更新 UI
8. **避免频繁切换**：减少不必要的主题切换操作，提升性能

## 注意事项

1. 主题文件必须是有效的 `.plist` 格式
2. 颜色值必须使用 RGBA 格式字符串（0-255 范围）
3. 删除主题不会删除整个主题目录，只删除 plist 文件
4. 恢复默认主题会从 Bundle 中重新复制原始配置文件
5. 主题修改会立即持久化到沙盒文档目录
6. 确保主题配置文件中包含所有必需的键值对，避免运行时错误

## API 参考

### LWThemeManager

#### 实例方法

```objective-c
// 获取单例实例
+ (LWThemeManager *)sharedInstance;

// 获取 Bundle 中的资源文件路径
+ (NSString *)pathInBundleWithFileName:(NSString *)fileName;

// 获取当前主题名称
- (NSString *)currentName;

// 获取当前主题配置字典
- (NSMutableDictionary *)theme;

// 设置当前主题的配置值
- (void)setThemeValue:(id)value forKey:(NSString *)key;

// 更新指定主题的配置值
- (void)updateThemeWithName:(NSString *)name value:(id)value forKey:(NSString *)key;

// 删除主题
- (void)removeThemeWithName:(NSString *)themeName;

// 从当前主题复制创建新主题
- (BOOL)copyANewThemeWithName:(NSString *)name;

// 恢复默认主题
- (void)recoverDefaultTheme;

// 切换主题
- (void)updateThemeWithName:(NSString *)name;
```

#### 宏定义

```objective-c
// 读取主题值
FloatValueFromThemeKey(key)      // 读取浮点数
StringValueFromThemeKey(key)     // 读取字符串
UIColorValueFromThemeKey(key)    // 读取 UIColor
CGColorValueFromThemeKey(key)    // 读取 CGColor

// 写入主题值
FloatValueToThemeFileByKey(value, key)    // 写入浮点数
StringValueToThemeFileByKey(value, key)   // 写入字符串
UIColorValueToThemeFileByKey(value, key)  // 写入 UIColor
CGColorValueToThemeFileByKey(value, key)  // 写入 CGColor
```

### UIColor+LWTheme

```objective-c
// 从 RGBA 字符串创建 UIColor
+ (UIColor *)theme_colorWithRGBAString:(NSString *)RGBAString;

// 从 UIColor 获取 RGBA 字符串
+ (NSString *)theme_rgbaStringFromUIColor:(UIColor *)color;
```

## 常见问题

### Q: 如何在应用启动时设置默认主题？

A: 在 `AppDelegate` 的 `application:didFinishLaunchingWithOptions:` 中调用：

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[LWThemeManager sharedInstance] updateThemeWithName:@"defaultTheme"];
    return YES;
}
```

### Q: 主题切换后 UI 没有更新怎么办？

A: 需要手动刷新 UI。建议使用通知机制，在收到主题切换通知后重新设置 UI 属性。

### Q: 可以动态添加新的配置项吗？

A: 可以。使用 `setThemeValue:forKey:` 方法即可添加新的键值对。

### Q: 主题文件存储在哪里？

A: 预设主题在 Bundle 的 `KeyboardTheme.bundle` 中，用户自定义主题在 `Documents/themes/主题名称/` 目录下。

### Q: 如何导出和分享主题？

A: 可以直接拷贝 `Documents/themes/主题名称/` 目录下的 plist 文件，然后在其他设备上放置到相同位置。

## 版本历史

### 1.0.0
- 初始版本发布
- 支持基础的主题管理功能
- 内置 26+ 种预设主题
- 提供完整的 API 和宏定义

## 贡献

欢迎提交 Issue 和 Pull Request！

## 作者

luowei, luowei@wodedata.com

## 许可证

LWThemeManager 使用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。
