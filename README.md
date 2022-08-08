# LWThemeManager

[![CI Status](https://img.shields.io/travis/luowei/LWThemeManager.svg?style=flat)](https://travis-ci.org/luowei/LWThemeManager)
[![Version](https://img.shields.io/cocoapods/v/LWThemeManager.svg?style=flat)](https://cocoapods.org/pods/LWThemeManager)
[![License](https://img.shields.io/cocoapods/l/LWThemeManager.svg?style=flat)](https://cocoapods.org/pods/LWThemeManager)
[![Platform](https://img.shields.io/cocoapods/p/LWThemeManager.svg?style=flat)](https://cocoapods.org/pods/LWThemeManager)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Usage in macro substitution   

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


### update theme  
```Objective-C
[[LWThemeManager sharedInstance] updateThemeWithName:skinName];

[[LWThemeManager sharedInstance] removeThemeWithName:name];

[[LWThemeManager sharedInstance] copyANewThemeWithName:idString];

[[LWThemeManager sharedInstance] updateThemeWithName:idString value:idString forKey:@"inputView.backgroundImage"];

[[LWThemeManager sharedInstance] recoverDefaultTheme];
```


### get resources file path  
```Objective-C
NSString *filePath = [LWThemeManager pathInBundleWithFileName:imgName];
```

## Requirements

## Installation

LWThemeManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LWThemeManager'
```

**Carthage**
```ruby
github "luowei/LWThemeManager"
```

## Author

luowei, luowei@wodedata.com

## License

LWThemeManager is available under the MIT license. See the LICENSE file for more info.
