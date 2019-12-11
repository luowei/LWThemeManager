//
// Created by luowei on 2019/12/11.
//

#import "LWThemeExtension.h"


@implementation UIColor (LWTheme)

+ (UIColor *)theme_colorWithRGBAString:(NSString *)RGBAString {
    UIColor *color = nil;

    NSArray *rgbaComponents = [RGBAString componentsSeparatedByString:@","];
    float RED = 0.0f;
    float GREEN = 0.0f;
    float BLUE = 0.0f;
    float ALPHA = 0.0f;

    //string like : 127,127,127
    if ([rgbaComponents count] == 3) {
        RED = [(NSString *) rgbaComponents[0] floatValue] / 255;
        GREEN = [(NSString *) rgbaComponents[1] floatValue] / 255;
        BLUE = [(NSString *) rgbaComponents[2] floatValue] / 255;

        color = [UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:1.0f];

        //string like : 127,127,127,255
    } else if ([rgbaComponents count] == 4) {
        RED = [(NSString *) rgbaComponents[0] floatValue] / 255;
        GREEN = [(NSString *) rgbaComponents[1] floatValue] / 255;
        BLUE = [(NSString *) rgbaComponents[2] floatValue] / 255;
        ALPHA = [(NSString *) rgbaComponents[3] floatValue] / 255;

        color = [UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA];
    }

    return color;
}

//从UIColor得到RGBA字符串
+ (NSString *)theme_rgbaStringFromUIColor:(UIColor *)color {

    if (!color) {
        return nil;
    }

    if (color == [UIColor whiteColor]) {
        // Special case, as white doesn't fall into the RGB color space
        return @"255,255,255,255";
    }

    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;

    [color getRed:&red green:&green blue:&blue alpha:&alpha];

    int redDec = (int) (red * 255);
    int greenDec = (int) (green * 255);
    int blueDec = (int) (blue * 255);
    int alphaDec = (int) (alpha * 255);

    NSString *returnString = [NSString stringWithFormat:@"%d,%d,%d,%d", (unsigned int) redDec, (unsigned int) greenDec, (unsigned int) blueDec, (unsigned int) alphaDec];

    return returnString;

}



@end