//
// Created by luowei on 2019/12/11.
//

#import <UIKit/UIKit.h>


@interface UIColor (LWTheme)

+ (UIColor *)theme_colorWithRGBAString:(NSString *)RGBAString;

//从UIColor得到RGBA字符串
+(NSString *)theme_rgbaStringFromUIColor:(UIColor *)color;


@end
