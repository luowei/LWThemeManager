//
//  LWThemeManager.h
//  MyInputMethod
//
//  Created by luowei on 15/8/18.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWThemeExtension.h"

#define FloatValueFromThemeKey(key) (((NSNumber *)[LWThemeManager sharedInstance].theme[(key)]).floatValue)
#define StringValueFromThemeKey(key) ((NSString *)[LWThemeManager sharedInstance].theme[(key)])
#define UIColorValueFromThemeKey(key) ([UIColor theme_colorWithRGBAString:((NSString *)[LWThemeManager sharedInstance].theme[(key)])])
#define CGColorValueFromThemeKey(key) ([UIColor theme_colorWithRGBAString:((NSString *)[LWThemeManager sharedInstance].theme[(key)])].CGColor)

#define FloatValueToThemeFileByKey(fValue,key) ([[LWThemeManager sharedInstance] setThemeValue:(fValue) forKey:(key)])
#define StringValueToThemeFileByKey(strValue,key) ([[LWThemeManager sharedInstance] setThemeValue:(strValue) forKey:(key)])
#define UIColorValueToThemeFileByKey(uicolor,key) ([[LWThemeManager sharedInstance] setThemeValue:([UIColor theme_rgbaStringFromUIColor:uicolor]) forKey:(key)])
#define CGColorValueToThemeFileByKey(cgcolor,key) ([[LWThemeManager sharedInstance] setThemeValue:([UIColor theme_rgbaStringFromUIColor:[[UIColor alloc] initWithCGColor:cgcolor]]) forKey:(key)])


//主题设置的键值
#define Key_Theme @"Key_Theme"

@interface LWThemeManager : NSObject

+ (LWThemeManager *)sharedInstance;

+(NSString *)pathInBundleWithFileName:(NSString *)fileName;

//theme name
-(NSString *)currentName;

-(NSMutableDictionary *)theme;

//把theme数据保存到文件
-(void)setThemeValue:(id)value forKey:(NSString *)key;

//更新指定theme文件的key、value
-(void)updateThemeWithName:(NSString *)name value:(id)value forKey:(NSString *)key;

//从当前主题新建一个主题
-(BOOL)copyANewThemeWithName:(NSString *)name;

//恢复默认主题设置
-(void)recoverDefaultTheme;

//更新主题
-(void)updateThemeWithName:(NSString *)name;

@end


