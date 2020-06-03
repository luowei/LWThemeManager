//
//  LWThemeManager.m
//  MyInputMethod
//
//  Created by luowei on 15/8/18.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import "LWThemeManager.h"

static NSString *const Dir_Themes = @"themes";

@implementation LWThemeManager{
    NSMutableDictionary *_theme;
    NSString *_currentName;
}

+ (LWThemeManager *)sharedInstance {
    __strong static LWThemeManager *sharedInstance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LWThemeManager alloc] init];
    });

    return sharedInstance;
}

//- (id)init {
//    if ((self = [super init])) {
//
////        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////        NSString *themeName = [defaults objectForKey:Key_Theme] ?: @"defaultTheme";
////        NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:themeName ofType:@"plist"];
//
//        NSString *bundleFilePath = [LWThemeManager pathInBundleWithFileName:@"defaultTheme.plist"];
//
//        NSFileManager *fmanager = [NSFileManager defaultManager];
//        NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//        NSString *docFilePath = [documentsDirectory stringByAppendingPathComponent:Dir_Themes];
//
//        //在Document是不存在
//        if (![fmanager fileExistsAtPath:docFilePath]) {
//            //先拷贝Bundle里下的到docment目录下
//            NSError *error;
//            [fmanager copyItemAtPath:bundleFilePath toPath:docFilePath error:&error];
//            if (error) {
//                self.theme = [NSDictionary dictionaryWithContentsOfFile:bundleFilePath].mutableCopy;
//            }
//        }else{
//            self.theme = [NSDictionary dictionaryWithContentsOfFile:docFilePath].mutableCopy;
//        }
//        _currentName=@"default";
//
//    }
//    return self;
//
//}

+(NSString *)pathInBundleWithFileName:(NSString *)fileName {
    return [LWThemeManager bundlePathNamed:fileName ofBundle:@"KeyboardTheme.bundle"];
}

+(NSString*)bundlePathNamed:(NSString*)name ofBundle:(NSString*)bundleName{
    NSString *file_name = [NSString stringWithFormat:@"%@",name];
    NSString *resourcePath = [[NSBundle mainBundle]resourcePath];
    NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
    NSString *file_path = [bundlePath stringByAppendingPathComponent:file_name];
    
    return file_path;
}

-(NSString *)currentName {
    return _currentName;
}

-(NSMutableDictionary *)theme {
    if(_currentName && _theme){
        return _theme;
    }
    [self updateThemeWithName:_currentName ?: @"default"];
    return _theme;
}

//把theme数据保存到文件
-(void)setThemeValue:(id)value forKey:(NSString *)key{
    [[LWThemeManager sharedInstance].theme setValue:value forKey:key];

    //把theme数据写入到docment的文件中
    NSString *themeName = [NSString stringWithFormat:@"%@Theme.plist",_currentName];

    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *themeDirPath = [documentsDirectory stringByAppendingPathComponent:themeName];
    [self.theme writeToFile:themeDirPath atomically:YES];
}

//从当前主题新建一个主题
-(BOOL)copyANewThemeWithName:(NSString *)themeName {
    NSString *plistName = [NSString stringWithFormat:@"%@Theme.plist",_currentName ?: @"default"];
    NSString *bundleFilePath = [LWThemeManager pathInBundleWithFileName:plistName];
    NSFileManager *fmanager = [NSFileManager defaultManager];
    if(![fmanager fileExistsAtPath:bundleFilePath]){
        return NO;
    }

    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *themeDirPath = [documentsDirectory stringByAppendingPathComponent:Dir_Themes];
    NSString *themeFilePath = [themeDirPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@Theme.plist", themeName]];

    //拷贝Bundle里下的到docment目录下
    NSError *error;
    [fmanager copyItemAtPath:bundleFilePath toPath:themeFilePath error:&error];

    if (error) {
        return NO;
    }else{
        return YES;
    }
}

//恢复默认主题设置
-(void)recoverDefaultTheme{
    //NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:@"defaultTheme" ofType:@"plist"];
    [self updateThemeWithName:@"default"];
}

//根据name更新主题
-(void)updateThemeWithName:(NSString *)name {
    if([name isEqualToString:_currentName] && _theme!=nil ){
        return;
    }

    NSString *plistName = [NSString stringWithFormat:@"%@Theme.plist",name ?: @"default"];
    NSString *bundleFilePath = [LWThemeManager pathInBundleWithFileName:plistName];
    NSFileManager *fmanager = [NSFileManager defaultManager];
    if(![fmanager fileExistsAtPath:bundleFilePath]){
        return;
    }

    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *themeDirPath = [documentsDirectory stringByAppendingPathComponent:Dir_Themes];

    NSError *error;
    //在Document是存在
    if ([fmanager fileExistsAtPath:themeDirPath]) {
        [fmanager removeItemAtPath:themeDirPath error:&error];   //删除
    }
    //拷贝Bundle里下的到docment目录下
    [fmanager copyItemAtPath:bundleFilePath toPath:themeDirPath error:&error];
    if (error) {
        _theme = [NSDictionary dictionaryWithContentsOfFile:bundleFilePath].mutableCopy;
    }else{
        _theme = [NSDictionary dictionaryWithContentsOfFile:themeDirPath].mutableCopy;
    }
    _currentName=name;
}


/*
#pragma mark - Current Theme Setting

+(UIColor *)inputView_backgroundColor{
    NSString *value = [LWThemeManager sharedInstance].theme[@"inputView.backgroundColor"];
    return [UIColor colorWithRGBAString:value];
}
+(NSString *)inputView_backgroundImage_{
    return  [LWThemeManager sharedInstance].theme[@"inputView.backgroundImage"];
}
+(NSString *)skinSetting_selectedIndexPath{
    return [LWThemeManager sharedInstance].theme[@"skinSetting.selectedIndexPath"];
}
+(CGFloat)btn_space_horizon{
    NSNumber *value = [LWThemeManager sharedInstance].theme[@"btn.space.horizon"];
    return value.floatValue;
}
+(UIColor *)font_color{
    NSString *value = [LWThemeManager sharedInstance].theme[@"font.color"];
    return [UIColor colorWithRGBAString:value];
}
+(NSString *)font_name{
    return [LWThemeManager sharedInstance].theme[@"font.name"];
}
+(UIColor *)font_highlightColor{
    NSString *value = [LWThemeManager sharedInstance].theme[@"font.highlightColor"];
    return [UIColor colorWithRGBAString:value];
}
+(UIColor *)btn_content_color{
    NSString *value = [LWThemeManager sharedInstance].theme[@"btn.content.color"];
    return [UIColor colorWithRGBAString:value];
}
+(UIColor *)btn_content_highlightColor{
    NSString *value = [LWThemeManager sharedInstance].theme[@"btn.content.highlightColor"];
    return [UIColor colorWithRGBAString:value];
}
+(UIColor *)btn_borderColor{
    NSString *value = [LWThemeManager sharedInstance].theme[@"btn.borderColor"];
    return [UIColor colorWithRGBAString:value];
}
+(CGFloat)btn_borderWidth{
    NSNumber *value = [LWThemeManager sharedInstance].theme[@"btn.borderWidth"];
    return value.floatValue;
}
+(CGFloat)btn_cornerRadius{
    NSNumber *value = [LWThemeManager sharedInstance].theme[@"btn.cornerRadius"];
    return value.floatValue;
}
+(CGFloat)btn_opacity{
    NSNumber *value = [LWThemeManager sharedInstance].theme[@"btn.opacity"];
    return value.floatValue;
}
+(UIColor *)btn_shadow_color{
    NSString *value = [LWThemeManager sharedInstance].theme[@"btn.shadow.color"];
    return [UIColor colorWithRGBAString:value];
}
+(CGFloat)btn_shadow_height{
    NSNumber *value = [LWThemeManager sharedInstance].theme[@"btn.shadow.height"];
    return value.floatValue;
}
+(CGFloat)btn_topAndMain_space{
    NSNumber *value = [LWThemeManager sharedInstance].theme[@"btn.topAndMain.space"];
    return value.floatValue;
}
+(CGFloat)btn_mainLabel_fontSize{
    NSNumber *value = [LWThemeManager sharedInstance].theme[@"btn.mainLabel.fontSize"];
    return value.floatValue;
}
+(CGFloat)btn_topLabel_fontSize{
    NSNumber *value = [LWThemeManager sharedInstance].theme[@"btn.topLabel.fontSize"];
    return value.floatValue;
}
+(CGFloat)footerText_fontSize{
    NSNumber *value = [LWThemeManager sharedInstance].theme[@"footerText.fontSize"];
    return value.floatValue;
}
+(CGFloat)predictive_first_fontSize{
    NSNumber *value = [LWThemeManager sharedInstance].theme[@"predictive.first.fontSize"];
    return value.floatValue;
}
+(CGFloat)predictive_fontSize{
    NSNumber *value = [LWThemeManager sharedInstance].theme[@"predictive.fontSize"];
    return value.floatValue;
}

#pragma mark - Write Method
//......

*/




@end



