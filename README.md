# LWThemeManager

[English](./README.md) | [中文版](./README_ZH.md) | [Swift Version](./README_SWIFT_VERSION.md)

[![CI Status](https://img.shields.io/travis/luowei/LWThemeManager.svg?style=flat)](https://travis-ci.org/luowei/LWThemeManager)
[![Version](https://img.shields.io/cocoapods/v/LWThemeManager.svg?style=flat)](https://cocoapods.org/pods/LWThemeManager)
[![License](https://img.shields.io/cocoapods/l/LWThemeManager.svg?style=flat)](https://cocoapods.org/pods/LWThemeManager)
[![Platform](https://img.shields.io/cocoapods/p/LWThemeManager.svg?style=flat)](https://cocoapods.org/pods/LWThemeManager)

## Overview

LWThemeManager is a powerful and flexible iOS theme management framework that provides dynamic theme switching capabilities with 26+ beautiful built-in themes. Originally developed for the Universal Input Method (万能输入法) app, it offers a complete solution for apps requiring customizable theming, especially keyboard extensions and applications with complex UI requirements.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Built-in Themes](#built-in-themes)
- [Requirements](#requirements)
- [Installation](#installation)
  - [CocoaPods](#installation)
  - [Carthage](#carthage)
- [Quick Start Example](#quick-start-example)
- [Usage](#usage)
  - [Quick Start](#quick-start)
  - [Accessing Theme Values](#accessing-theme-values)
  - [Theme Management](#theme-management)
  - [Get Resources File Path](#get-resources-file-path)
- [Complete Usage Example](#complete-usage-example)
- [Swift Usage Example](#swift-usage-example)
- [Theme Configuration](#theme-configuration)
- [Architecture & Storage Mechanism](#architecture--storage-mechanism)
- [Best Practices](#best-practices)
- [Advanced Features](#advanced-features)
- [API Reference](#api-reference)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)
- [Contributing](#contributing)
- [Changelog](#changelog)
- [Support & Community](#support--community)
- [Credits](#credits)
- [Author](#author)
- [License](#license)

## Features

- **Dynamic Theme Switching**: Change themes at runtime without restarting the app
- **26+ Built-in Themes**: Professionally designed themes covering various styles and moods
- **Complete Theme Management**: Create, update, delete, and recover themes with simple API calls
- **Persistent Storage**: Theme preferences and customizations are automatically saved
- **Simple Macro-based API**: Access theme values with intuitive, easy-to-use macros
- **Flexible Type Support**: Colors (RGBA), floats, strings, and image paths
- **Dual Storage Layer**: Bundle resources for default themes, sandboxed documents for customizations
- **UIColor Extensions**: Convert between RGBA strings and UIColor objects seamlessly
- **Lightweight & Efficient**: Minimal overhead with optimized performance
- **Perfect for Keyboard Extensions**: Originally developed for the Universal Input Method app

## Built-in Themes

LWThemeManager comes with 26 carefully crafted themes out of the box:

- **accent** - Bold accent colors
- **bravery** - Strong and courageous tones
- **calm** - Peaceful and serene colors
- **classic** - Timeless traditional theme
- **clight** - Clean light appearance
- **clouds** - Soft cloud-inspired palette
- **darkness** - Deep dark mode
- **default** - Standard default theme
- **general** - General purpose theme
- **grayish** - Elegant grayscale tones
- **idark** - iOS-style dark theme
- **light** - Bright and clean light theme
- **magentas** - Vibrant magenta colors
- **mediter** - Mediterranean-inspired colors
- **mysterious** - Enigmatic dark tones
- **nature** - Natural earth colors
- **retro** - Vintage retro style
- **slightly** - Subtle color variations
- **soft** - Gentle pastel colors
- **sunset** - Warm sunset gradients
- **swamp** - Earthy swamp tones
- **travel** - Adventurous travel theme
- **versatile** - Adaptable multi-purpose theme
- **vintage** - Classic vintage aesthetic
- **violet** - Purple and violet shades
- **vivid** - Bright vibrant colors

## Requirements

- iOS 8.0 or later
- Xcode 7.0 or later
- Objective-C

## Installation

LWThemeManager is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'LWThemeManager'
```

Then run:

```bash
pod install
```

### Carthage

Add the following line to your Cartfile:

```ruby
github "luowei/LWThemeManager"
```

Then run:

```bash
carthage update
```

## Quick Start Example

To run the example project, clone the repo and run `pod install` from the Example directory:

```bash
git clone https://github.com/luowei/LWThemeManager.git
cd LWThemeManager/Example
pod install
open LWThemeManager.xcworkspace
```

## Usage

### Quick Start

```Objective-C
#import <LWThemeManager/LWThemeManager.h>

// Get the shared theme manager instance
LWThemeManager *manager = [LWThemeManager sharedInstance];

// Switch to a built-in theme
[manager updateThemeWithName:@"sunset"];

// Access theme values using macros
UIColor *bgColor = UIColorValueFromThemeKey(@"inputView.backgroundColor");
CGFloat fontSize = FloatValueFromThemeKey(@"btn.mainLabel.fontSize");
NSString *fontName = StringValueFromThemeKey(@"font.name");
```

### Accessing Theme Values

LWThemeManager provides convenient macros to access theme values. The macros are already defined in the header file:

#### Reading Theme Values
```Objective-C
// Get float value from theme
CGFloat fontSize = FloatValueFromThemeKey(@"label.fontSize");

// Get string value from theme
NSString *imageName = StringValueFromThemeKey(@"button.imageName");

// Get UIColor from theme (RGBA string format)
UIColor *backgroundColor = UIColorValueFromThemeKey(@"view.backgroundColor");

// Get CGColor from theme
CGColorRef borderColor = CGColorValueFromThemeKey(@"view.borderColor");
```

#### Writing Theme Values
```Objective-C
// Save float value to current theme
FloatValueToThemeFileByKey(@(14.0), @"label.fontSize");

// Save string value to current theme
StringValueToThemeFileByKey(@"icon.png", @"button.imageName");

// Save UIColor to current theme
UIColorValueToThemeFileByKey([UIColor redColor], @"view.backgroundColor");

// Save CGColor to current theme
CGColorValueToThemeFileByKey([UIColor blueColor].CGColor, @"view.borderColor");
```

#### Macro Definitions
The following macros are available for use:
```Objective-C
#define FloatValueFromThemeKey(key) (((NSNumber *)[LWThemeManager sharedInstance].theme[(key)]).floatValue)
#define StringValueFromThemeKey(key) ((NSString *)[LWThemeManager sharedInstance].theme[(key)])
#define UIColorValueFromThemeKey(key) ([UIColor theme_colorWithRGBAString:((NSString *)[LWThemeManager sharedInstance].theme[(key)])])
#define CGColorValueFromThemeKey(key) ([UIColor theme_colorWithRGBAString:((NSString *)[LWThemeManager sharedInstance].theme[(key)])].CGColor)

#define FloatValueToThemeFileByKey(fValue,key) ([[LWThemeManager sharedInstance] setThemeValue:(fValue) forKey:(key)])
#define StringValueToThemeFileByKey(strValue,key) ([[LWThemeManager sharedInstance] setThemeValue:(strValue) forKey:(key)])
#define UIColorValueToThemeFileByKey(uicolor,key) ([[LWThemeManager sharedInstance] setThemeValue:([UIColor theme_rgbaStringFromUIColor:uicolor]) forKey:(key)])
#define CGColorValueToThemeFileByKey(cgcolor,key) ([[LWThemeManager sharedInstance] setThemeValue:([UIColor theme_rgbaStringFromUIColor:[[UIColor alloc] initWithCGColor:cgcolor]]) forKey:(key)])
```


### Theme Management

#### Switch Theme
Switch to any of the 26 built-in themes or your custom themes:
```Objective-C
// Switch to a different theme
[[LWThemeManager sharedInstance] updateThemeWithName:@"sunset"];
[[LWThemeManager sharedInstance] updateThemeWithName:@"darkness"];
[[LWThemeManager sharedInstance] updateThemeWithName:@"nature"];
```

#### Get Current Theme
```Objective-C
// Get the current theme name
NSString *currentThemeName = [[LWThemeManager sharedInstance] currentName];

// Access theme dictionary
NSMutableDictionary *themeData = [[LWThemeManager sharedInstance] theme];
```

#### Create Custom Theme
```Objective-C
// Copy current theme to create a new custom theme
[[LWThemeManager sharedInstance] copyANewThemeWithName:@"myCustomTheme"];
```

#### Update Theme Values
```Objective-C
// Update a specific key-value pair in a theme
[[LWThemeManager sharedInstance] updateThemeWithName:@"myCustomTheme"
                                                 value:@"255,100,50,1.0"
                                                forKey:@"inputView.backgroundColor"];
```

#### Delete Theme
```Objective-C
// Remove a custom theme
[[LWThemeManager sharedInstance] removeThemeWithName:@"myCustomTheme"];
```

#### Recover Default Theme
```Objective-C
// Reset to the default theme
[[LWThemeManager sharedInstance] recoverDefaultTheme];
```


### Get Resources File Path
Access theme resource files (images, assets, etc.) from the theme bundle:
```Objective-C
// Get file path for a resource in the theme bundle
NSString *imagePath = [LWThemeManager pathInBundleWithFileName:@"background.png"];
UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
```

## Complete Usage Example

Here's a comprehensive example showing how to integrate LWThemeManager in a real application:

```Objective-C
#import <LWThemeManager/LWThemeManager.h>

// Define notification for theme changes
NSString *const ThemeDidChangeNotification = @"ThemeDidChangeNotification";

@interface MyViewController ()
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Register for theme change notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleThemeChange:)
                                                 name:ThemeDidChangeNotification
                                               object:nil];

    // Setup UI with current theme
    [self setupUI];
    [self applyTheme];
}

- (void)setupUI {
    // Create UI elements
    self.customView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.customView];

    self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.actionButton.frame = CGRectMake(50, 200, 200, 50);
    [self.actionButton setTitle:@"Action" forState:UIControlStateNormal];
    [self.customView addSubview:self.actionButton];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    self.titleLabel.text = @"Hello, Theme!";
    [self.customView addSubview:self.titleLabel];
}

- (void)applyTheme {
    // Get current theme name
    NSString *currentTheme = [[LWThemeManager sharedInstance] currentName];
    NSLog(@"Applying theme: %@", currentTheme);

    // Apply theme colors using macros
    self.view.backgroundColor = UIColorValueFromThemeKey(@"inputView.backgroundColor");
    self.customView.backgroundColor = UIColorValueFromThemeKey(@"view.backgroundColor");

    // Configure button with theme values
    self.actionButton.backgroundColor = UIColorValueFromThemeKey(@"btn.content.color");
    [self.actionButton setTitleColor:UIColorValueFromThemeKey(@"font.color")
                            forState:UIControlStateNormal];
    self.actionButton.layer.cornerRadius = FloatValueFromThemeKey(@"btn.cornerRadius");
    self.actionButton.layer.borderWidth = FloatValueFromThemeKey(@"btn.borderWidth");
    self.actionButton.layer.borderColor = CGColorValueFromThemeKey(@"btn.borderColor");

    // Configure label with theme values
    self.titleLabel.textColor = UIColorValueFromThemeKey(@"font.color");
    NSString *fontName = StringValueFromThemeKey(@"font.name");
    CGFloat fontSize = FloatValueFromThemeKey(@"btn.mainLabel.fontSize");
    self.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
}

#pragma mark - Theme Management Actions

- (void)switchToTheme:(NSString *)themeName {
    // Switch to selected theme
    [[LWThemeManager sharedInstance] updateThemeWithName:themeName];

    // Post notification to update all views
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeDidChangeNotification
                                                        object:themeName];
}

- (void)createCustomTheme {
    // Create a new theme based on current theme
    BOOL success = [[LWThemeManager sharedInstance] copyANewThemeWithName:@"myCustomTheme"];

    if (success) {
        NSLog(@"Custom theme created successfully");

        // Customize the new theme
        UIColorValueToThemeFileByKey([UIColor colorWithRed:0.2 green:0.3 blue:0.8 alpha:1.0],
                                      @"inputView.backgroundColor");
        UIColorValueToThemeFileByKey([UIColor whiteColor], @"font.color");
        FloatValueToThemeFileByKey(@(12.0), @"btn.cornerRadius");
        StringValueToThemeFileByKey(@"Helvetica-Bold", @"font.name");

        // Switch to the new custom theme
        [self switchToTheme:@"myCustomTheme"];
    }
}

- (void)updateCurrentTheme {
    // Update specific values in current theme
    [[LWThemeManager sharedInstance] setThemeValue:@"200,100,50,255"
                                             forKey:@"btn.content.color"];

    // Refresh UI to reflect changes
    [self applyTheme];
}

- (void)deleteCustomTheme:(NSString *)themeName {
    // Remove a custom theme
    [[LWThemeManager sharedInstance] removeThemeWithName:themeName];
    NSLog(@"Theme '%@' deleted", themeName);
}

- (void)restoreDefaultTheme {
    // Restore the default theme settings
    [[LWThemeManager sharedInstance] recoverDefaultTheme];
    [self applyTheme];
}

#pragma mark - Notification Handler

- (void)handleThemeChange:(NSNotification *)notification {
    NSString *newTheme = notification.object;
    NSLog(@"Theme changed to: %@", newTheme);

    // Reapply theme to all UI elements
    [self applyTheme];
}

#pragma mark - Theme Picker Example

- (void)showThemePicker {
    NSArray *availableThemes = @[
        @"default", @"light", @"darkness", @"sunset", @"nature",
        @"vintage", @"retro", @"calm", @"vivid", @"violet"
    ];

    UIAlertController *picker = [UIAlertController alertControllerWithTitle:@"Select Theme"
                                                                    message:nil
                                                             preferredStyle:UIAlertControllerStyleActionSheet];

    for (NSString *theme in availableThemes) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:theme
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
            [self switchToTheme:theme];
        }];
        [picker addAction:action];
    }

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
    [picker addAction:cancelAction];

    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - Advanced: Theme Preview

- (UIImage *)generatePreviewForTheme:(NSString *)themeName {
    // Save current theme
    NSString *currentTheme = [[LWThemeManager sharedInstance] currentName];

    // Temporarily switch to target theme
    [[LWThemeManager sharedInstance] updateThemeWithName:themeName];

    // Create a preview view
    UIView *previewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    previewView.backgroundColor = UIColorValueFromThemeKey(@"inputView.backgroundColor");

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 180, 30)];
    label.text = themeName;
    label.textColor = UIColorValueFromThemeKey(@"font.color");
    label.textAlignment = NSTextAlignmentCenter;
    [previewView addSubview:label];

    // Render to image
    UIGraphicsBeginImageContextWithOptions(previewView.bounds.size, NO, 0.0);
    [previewView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *previewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // Restore original theme
    [[LWThemeManager sharedInstance] updateThemeWithName:currentTheme];

    return previewImage;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
```

### Swift Usage Example

For Swift projects, you can use LWThemeManager with a bridging header:

```Swift
import Foundation
import UIKit

class ThemeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Apply theme
        applyCurrentTheme()

        // Listen for theme changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(themeDidChange),
            name: NSNotification.Name("ThemeDidChangeNotification"),
            object: nil
        )
    }

    func applyCurrentTheme() {
        let manager = LWThemeManager.sharedInstance()

        // Access theme values
        view.backgroundColor = UIColorValueFromThemeKey("inputView.backgroundColor")

        // Get current theme name
        let themeName = manager.currentName()
        print("Current theme: \\(themeName ?? "unknown")")
    }

    @objc func themeDidChange() {
        applyCurrentTheme()
    }

    func switchTheme(to name: String) {
        LWThemeManager.sharedInstance().updateTheme(withName: name)
        NotificationCenter.default.post(name: NSNotification.Name("ThemeDidChangeNotification"), object: name)
    }
}
```

## Theme Configuration

### Theme File Structure

Themes are stored as `.plist` files with key-value pairs. Here's an example structure:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- Background colors (RGBA format: R,G,B,A where each value is 0-255) -->
    <key>inputView.backgroundColor</key>
    <string>244,244,244,255</string>

    <key>view.backgroundColor</key>
    <string>255,255,255,255</string>

    <!-- Button styling -->
    <key>btn.content.color</key>
    <string>252,252,252,255</string>

    <key>btn.content.highlightColor</key>
    <string>100,100,100,200</string>

    <key>btn.borderColor</key>
    <string>127,127,127,255</string>

    <key>btn.borderWidth</key>
    <real>0.5</real>

    <key>btn.cornerRadius</key>
    <real>8.0</real>

    <!-- Font settings -->
    <key>font.color</key>
    <string>0,0,0,255</string>

    <key>font.highlightColor</key>
    <string>255,255,255,255</string>

    <key>font.name</key>
    <string>Helvetica-Light</string>

    <!-- Font sizes -->
    <key>btn.mainLabel.fontSize</key>
    <integer>22</integer>

    <key>btn.topLabel.fontSize</key>
    <integer>10</integer>

    <!-- Spacing -->
    <key>btn.space.horizon</key>
    <integer>2</integer>

    <key>btn.space.verticel</key>
    <integer>2</integer>

    <!-- Background image (optional) -->
    <key>inputView.backgroundImage</key>
    <string></string>
</dict>
</plist>
```

### Architecture & Storage Mechanism

### Dual-Layer Storage System

LWThemeManager uses an efficient dual-layer storage architecture:

1. **Bundle Resources Layer** (`KeyboardTheme.bundle`):
   - Contains 26+ default themes (read-only)
   - Embedded in the app bundle
   - Serves as the source for default theme configurations

2. **Sandbox Documents Layer** (`Documents/themes/`):
   - Stores custom and modified themes (read-write)
   - Enables theme persistence across app sessions
   - Allows users to create and customize themes

### Theme Loading Flow

When you switch to a theme using `updateThemeWithName:`:

1. System first checks the sandbox documents directory (`Documents/themes/`)
2. If theme not found, copies from bundle resources to documents directory
3. If not in bundle, falls back to `defaultTheme.plist`
4. Loads theme configuration into memory (`_theme` dictionary)
5. Theme is now ready for use

### Theme Modification & Persistence

When you modify a theme using `setThemeValue:forKey:`:

- Changes are immediately written to both memory and disk
- Theme file in sandbox documents directory is updated
- Modifications persist across app restarts
- Original bundle themes remain untouched

## Best Practices

1. **Use Notification Pattern**: Implement theme change notifications to automatically update UI across your app
2. **Centralize Theme Logic**: Create a theme coordinator/manager class that handles all theme-related operations
3. **Cache Theme Values**: For frequently accessed values, consider caching them in memory to improve performance
4. **Consistent Naming**: Use consistent key naming conventions (e.g., `component.property.attribute`)
5. **Backup Before Customization**: Always create a copy of a theme before modifying it
6. **Document Custom Keys**: If you add custom configuration keys, document them for your team
7. **Test Theme Switching**: Ensure your UI updates correctly when themes change
8. **Handle Missing Keys**: Provide fallback values for theme keys that might not exist in all themes
9. **Use RGBA Format**: Always use the RGBA string format (0-255) for colors to ensure compatibility
10. **Version Your Themes**: If distributing themes, consider versioning them for backward compatibility

## Advanced Features

### Theme Inheritance

Create variations of existing themes by copying and modifying:

```Objective-C
// Create a dark variant of the sunset theme
[[LWThemeManager sharedInstance] updateThemeWithName:@"sunset"];
[[LWThemeManager sharedInstance] copyANewThemeWithName:@"sunset-dark"];
[[LWThemeManager sharedInstance] updateThemeWithName:@"sunset-dark"];

// Modify to make it darker
UIColorValueToThemeFileByKey([UIColor darkGrayColor], @"inputView.backgroundColor");
UIColorValueToThemeFileByKey([UIColor whiteColor], @"font.color");
```

### Dynamic Theme Generation

Generate themes programmatically based on user preferences:

```Objective-C
- (void)createThemeFromColor:(UIColor *)baseColor name:(NSString *)themeName {
    // Copy default theme
    [[LWThemeManager sharedInstance] copyANewThemeWithName:themeName];
    [[LWThemeManager sharedInstance] updateThemeWithName:themeName];

    // Generate color variations
    UIColor *lightVariant = [self lightenColor:baseColor by:0.2];
    UIColor *darkVariant = [self darkenColor:baseColor by:0.2];

    // Apply colors
    UIColorValueToThemeFileByKey(baseColor, @"btn.content.color");
    UIColorValueToThemeFileByKey(lightVariant, @"inputView.backgroundColor");
    UIColorValueToThemeFileByKey(darkVariant, @"font.color");
}
```

### Theme Export/Import

Share themes between devices or users:

```Objective-C
- (BOOL)exportTheme:(NSString *)themeName toPath:(NSString *)exportPath {
    NSString *themePath = [NSString stringWithFormat:@"%@/Documents/themes/%@/%@.plist",
                          NSHomeDirectory(), themeName, themeName];
    return [[NSFileManager defaultManager] copyItemAtPath:themePath
                                                   toPath:exportPath
                                                    error:nil];
}

- (BOOL)importTheme:(NSString *)themePath {
    NSString *themeName = [[themePath lastPathComponent] stringByDeletingPathExtension];
    NSString *destPath = [NSString stringWithFormat:@"%@/Documents/themes/%@/%@.plist",
                         NSHomeDirectory(), themeName, themeName];

    // Create directory if needed
    NSString *themeDir = [destPath stringByDeletingLastPathComponent];
    [[NSFileManager defaultManager] createDirectoryAtPath:themeDir
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];

    return [[NSFileManager defaultManager] copyItemAtPath:themePath
                                                   toPath:destPath
                                                    error:nil];
}
```

## API Reference

### LWThemeManager Class Methods

```objective-c
// Get the shared singleton instance
+ (LWThemeManager *)sharedInstance;

// Get resource file path from bundle
+ (NSString *)pathInBundleWithFileName:(NSString *)fileName;
```

### Instance Methods

```objective-c
// Get current theme name
- (NSString *)currentName;

// Get current theme dictionary
- (NSMutableDictionary *)theme;

// Update value in current theme
- (void)setThemeValue:(id)value forKey:(NSString *)key;

// Update value in specified theme
- (void)updateThemeWithName:(NSString *)name
                      value:(id)value
                     forKey:(NSString *)key;

// Switch to a different theme
- (void)updateThemeWithName:(NSString *)name;

// Create new theme from current theme
- (BOOL)copyANewThemeWithName:(NSString *)name;

// Delete a theme
- (void)removeThemeWithName:(NSString *)themeName;

// Restore default theme
- (void)recoverDefaultTheme;
```

### Convenience Macros

#### Reading Theme Values

```objective-c
// Get float value from theme
FloatValueFromThemeKey(key)

// Get string value from theme
StringValueFromThemeKey(key)

// Get UIColor from theme
UIColorValueFromThemeKey(key)

// Get CGColor from theme
CGColorValueFromThemeKey(key)
```

#### Writing Theme Values

```objective-c
// Save float value to theme
FloatValueToThemeFileByKey(value, key)

// Save string value to theme
StringValueToThemeFileByKey(value, key)

// Save UIColor to theme
UIColorValueToThemeFileByKey(value, key)

// Save CGColor to theme
CGColorValueToThemeFileByKey(value, key)
```

### UIColor+LWTheme Category

```objective-c
// Create UIColor from RGBA string (format: "R,G,B,A" where values are 0-255)
+ (UIColor *)theme_colorWithRGBAString:(NSString *)RGBAString;

// Get RGBA string from UIColor
+ (NSString *)theme_rgbaStringFromUIColor:(UIColor *)color;
```

## Troubleshooting

### Theme doesn't load
- **Issue**: Theme fails to load or switches to default
- **Solutions**:
  - Verify the theme name is spelled correctly
  - Check that the theme file exists in bundle or documents directory
  - Ensure the plist file is properly formatted XML
  - Review console logs for specific error messages

### Colors appear incorrect
- **Issue**: Colors don't match expected values
- **Solutions**:
  - Confirm RGBA values are in the range 0-255 (not 0-1)
  - Verify the string format is "R,G,B,A" with commas
  - Check for typos in color value strings
  - Ensure no extra spaces in RGBA strings

### UI doesn't update after theme change
- **Issue**: Visual appearance doesn't reflect new theme
- **Solutions**:
  - Implement notification handling for theme changes
  - Call your UI refresh methods after theme switch
  - Verify you're reading theme values after the switch
  - Check that views are properly using theme macros
  - Ensure `applyTheme` or equivalent method is called

### Custom theme not persisting
- **Issue**: Theme modifications are lost after app restart
- **Solutions**:
  - Check file permissions in documents directory
  - Verify theme is saved after modifications
  - Ensure app has write access to documents directory
  - Confirm theme file exists in `Documents/themes/themeName/`
  - Check for iOS storage restrictions or errors

## FAQ

### Q: Can I use LWThemeManager with SwiftUI?
**A**: LWThemeManager is primarily designed for UIKit applications. For SwiftUI projects, you'll need to create a wrapper using `ObservableObject` or use SwiftUI's native `Environment`/`EnvironmentObject` pattern for theme management. You can still use LWThemeManager as the underlying storage mechanism.

### Q: How do I add custom theme keys?
**A**: Simply use `setThemeValue:forKey:` with your custom key name. The key-value pair will be automatically added to the theme dictionary and persisted to disk. For example:
```objective-c
[[LWThemeManager sharedInstance] setThemeValue:@"CustomValue" forKey:@"custom.key"];
```

### Q: Can I delete built-in themes?
**A**: You can delete them from the documents directory, but they'll be automatically restored from the bundle resources if you switch to them again. Built-in themes in the bundle are read-only and cannot be permanently deleted.

### Q: Is LWThemeManager thread-safe?
**A**: The shared instance is thread-safe, but it's strongly recommended to perform all theme operations on the main thread, especially when updating UI elements. File I/O operations are synchronous and should not block the main thread significantly.

### Q: How do I reset all themes to factory defaults?
**A**: Delete the entire `Documents/themes/` directory, or call `recoverDefaultTheme` for the current theme. Themes will be automatically restored from the bundle when accessed next time.

### Q: Can I use images in themes?
**A**: Yes! Store image file names as string values in your theme, then use `pathInBundleWithFileName:` to retrieve the full path:
```objective-c
NSString *imagePath = [LWThemeManager pathInBundleWithFileName:StringValueFromThemeKey(@"background.image")];
UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
```

### Q: How do I handle theme changes across multiple view controllers?
**A**: Use `NSNotificationCenter` to broadcast theme change events. Post a notification when switching themes, and have all view controllers observe and respond to this notification by refreshing their UI.

### Q: What's the performance impact of theme switching?
**A**: Theme switching is very fast - it only involves loading a plist file and updating the in-memory dictionary. The main performance consideration is updating your UI elements, which you control in your code.

### Q: Can I preview themes without actually switching?
**A**: Yes! Save the current theme name, switch to the preview theme temporarily, capture what you need (screenshot, values, etc.), then switch back to the original theme. See the "Advanced Features" section for an example.

## Contributing

Contributions are welcome and appreciated! Here's how you can contribute to LWThemeManager:

### How to Contribute

1. **Fork the repository** on GitHub
2. **Create your feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit your changes** with clear, descriptive messages
   ```bash
   git commit -am 'Add amazing feature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open a Pull Request** with a detailed description of your changes

### Contribution Guidelines

- Follow the existing code style and conventions
- Add appropriate comments and documentation
- Include unit tests for new features
- Update the README if adding new functionality
- Test your changes thoroughly before submitting
- Keep pull requests focused on a single feature or fix

### Areas for Contribution

- Additional built-in themes
- Performance optimizations
- Bug fixes and improvements
- Documentation enhancements
- Example projects and tutorials
- SwiftUI wrapper/bridge

## Changelog

### Version 1.0.0 (Initial Release)
- Complete theme management system
- 26+ professionally designed built-in themes
- Dynamic theme switching without app restart
- Full CRUD operations for themes
- Persistent storage with dual-layer architecture
- UIColor extensions for RGBA string conversion
- Convenient macro-based API for value access
- Support for colors, floats, strings, and image paths
- Comprehensive documentation and examples

## Support & Community

### Getting Help

If you encounter issues or have questions:

- **Issues**: Open an issue on [GitHub Issues](https://github.com/luowei/LWThemeManager/issues)
- **Documentation**: Review this README and the example project
- **Existing Solutions**: Check [existing issues](https://github.com/luowei/LWThemeManager/issues?q=is%3Aissue) for similar problems
- **Example Project**: Run the demo app for implementation reference

### Reporting Bugs

When reporting bugs, please include:
- iOS version and device information
- LWThemeManager version
- Steps to reproduce the issue
- Expected vs actual behavior
- Relevant code snippets and error messages
- Console logs if applicable

## Credits

LWThemeManager was originally developed for the **Universal Input Method** (万能输入法) app, a popular Chinese input method for iOS. The framework was created to provide flexible, dynamic theming capabilities for keyboard extensions, which have unique constraints and requirements.

The project has since evolved into a general-purpose theming solution suitable for any iOS application requiring customizable themes and dynamic appearance switching.

## Author

**luowei**
Email: luowei@wodedata.com
GitHub: [@luowei](https://github.com/luowei)

## License

LWThemeManager is available under the **MIT License**. See the [LICENSE](LICENSE) file for complete details.

```
MIT License - Copyright (c) 2025 luowei

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files, to deal in the Software
without restriction, including the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software.
```

---

**Made with ❤️ for the iOS developer community**

If you find LWThemeManager helpful, please consider:
- Starring the repository on GitHub
- Sharing it with other developers
- Contributing improvements and new themes
- Providing feedback and suggestions
