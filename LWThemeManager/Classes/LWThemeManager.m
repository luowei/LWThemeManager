//
//  LWThemeManager.m
//  MyInputMethod
//
//  Created by luowei on 15/8/18.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import "LWThemeManager.h"

@implementation LWThemeManager{
    NSDictionary *_defaultTheme;
}

+ (LWThemeManager *)sharedInstance {
    __strong static LWThemeManager *sharedInstance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LWThemeManager alloc] init];
    });

    return sharedInstance;
}

- (id)init {
    if ((self = [super init])) {

//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSString *themeName = [defaults objectForKey:Key_Theme] ?: @"defaultTheme";
//        NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:themeName ofType:@"plist"];
        
        NSString *themeName = @"defaultTheme";
        NSString *bundleFilePath = [LWThemeManager bundlePathNamed:@"defaultTheme.plist" ofBundle:@"KeyboardTheme.bundle"];

        NSFileManager *fmanager = [NSFileManager defaultManager];
        NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *docFilePath = [documentsDirectory stringByAppendingPathComponent:themeName];

        //在Document是不存在
        if (![fmanager fileExistsAtPath:docFilePath]) {
            //先拷贝Bundle里下的到docment目录下
            NSError *error;
            [fmanager copyItemAtPath:bundleFilePath toPath:docFilePath error:&error];
            if (error) {
                self.theme = [NSDictionary dictionaryWithContentsOfFile:bundleFilePath].mutableCopy;
                return self;
            }
        }
        self.theme = [NSDictionary dictionaryWithContentsOfFile:docFilePath].mutableCopy;

    }
    return self;

}

+(NSString*)bundlePathNamed:(NSString*)name ofBundle:(NSString*)bundleName{
    NSString *file_name = [NSString stringWithFormat:@"%@",name];
    NSString *resourcePath = [[NSBundle mainBundle]resourcePath];
    NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
    NSString *file_path = [bundlePath stringByAppendingPathComponent:file_name];
    
    return file_path;
}

-(NSDictionary *)defaultTheme{
    NSString *bundleFilePath = [LWThemeManager bundlePathNamed:@"defaultTheme.plist" ofBundle:@"KeyboardTheme.bundle"];
    //NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:@"defaultTheme" ofType:@"plist"];
    if(!_defaultTheme){
        _defaultTheme = [NSDictionary dictionaryWithContentsOfFile:bundleFilePath];
    }
    return _defaultTheme;
}

//把theme数据保存到文件
-(void)setThemeValue:(id)value forKey:(NSString *)key{
    [[LWThemeManager sharedInstance].theme setValue:value forKey:key];
    [self writeThemeToDoc];
}

//把theme数据写入到docment的文件中
-(void)writeThemeToDoc{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *themeName = [defaults objectForKey:Key_Theme] ?: @"defaultTheme";

    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *docFilePath = [documentsDirectory stringByAppendingPathComponent:themeName];
    [self.theme writeToFile:docFilePath atomically:YES];
}

//恢复默认主题设置
-(void)recoverDefaultTheme{
    //NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:@"defaultTheme" ofType:@"plist"];
    NSString *bundleFilePath = [LWThemeManager bundlePathNamed:@"defaultTheme.plist" ofBundle:@"KeyboardTheme.bundle"];

    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *docFilePath = [documentsDirectory stringByAppendingPathComponent:@"defaultTheme"];

    NSFileManager *fmanager = [NSFileManager defaultManager];
    NSError *error;
    //在Document是存在
    if ([fmanager fileExistsAtPath:docFilePath]) {
        [fmanager removeItemAtPath:docFilePath error:&error];   //删除
    }
    //拷贝Bundle里下的到docment目录下
    [fmanager copyItemAtPath:bundleFilePath toPath:docFilePath error:&error];
    if (error) {
        self.theme = [NSDictionary dictionaryWithContentsOfFile:bundleFilePath].mutableCopy;
    }else{
        self.theme = [NSDictionary dictionaryWithContentsOfFile:docFilePath].mutableCopy;
    }
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



