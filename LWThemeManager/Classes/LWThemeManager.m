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
    NSString *plistName = [NSString stringWithFormat:@"%@Theme.plist", _currentName];

    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *themePlistPath = [NSString stringWithFormat:@"%@/%@/%@/%@", documentsPath, Dir_Themes, _currentName, plistName];
    [self.theme writeToFile:themePlistPath atomically:YES];
}

//从当前主题新建一个主题
-(BOOL)copyANewThemeWithName:(NSString *)name {
    //判断当前Plist是否存在,不存在用default plist
    NSString *plistName = [NSString stringWithFormat:@"%@Theme.plist",_currentName ?: @"default"];
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *currentPlistPath = [NSString stringWithFormat:@"%@/%@/%@/%@", documentsPath, Dir_Themes, _currentName, plistName];

    NSFileManager *fmanager = [NSFileManager defaultManager];
    if(![fmanager fileExistsAtPath:currentPlistPath]){
        currentPlistPath = [LWThemeManager pathInBundleWithFileName:plistName];
    }

    //创建name子目录
    NSError *error;
    NSString *nameDirPath = [NSString stringWithFormat:@"%@/%@/%@", documentsPath, Dir_Themes, name];
    if(![fmanager fileExistsAtPath:nameDirPath]){
        [fmanager createDirectoryAtPath:nameDirPath withIntermediateDirectories:YES attributes:nil error:&error];
    }

    //拷贝
    NSString *nameFilePath = [NSString stringWithFormat:@"%@/%@Theme.plist", nameDirPath, name];
    [fmanager copyItemAtPath:currentPlistPath toPath:nameFilePath error:&error]; //拷贝
    if(error){
        return NO;
    }
    return YES;
}

//恢复默认主题设置
-(void)recoverDefaultTheme{
    //NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:@"defaultTheme" ofType:@"plist"];
    [self updateThemeWithName:@"default"];
}

//根据name更新主题
-(void)updateThemeWithName:(NSString *)name {
    //若theme设置没变化，且theme字典不为空
    if([name isEqualToString:_currentName] && _theme!=nil ){
        return;
    }

    //拼接path
    NSString *plistName = [NSString stringWithFormat:@"%@Theme.plist",name ?: @"default"];
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *nameDirPath = [NSString stringWithFormat:@"%@/%@/%@", documentsPath, Dir_Themes, name];
    NSString *docPlistPath = [NSString stringWithFormat:@"%@/%@", nameDirPath, plistName];
    NSString *bundPlistPath = [LWThemeManager pathInBundleWithFileName:plistName];
    NSString *defaultPlistPath = [LWThemeManager pathInBundleWithFileName:@"defaultTheme.plist"];

    //判断是否存在
    NSFileManager *fmanager = [NSFileManager defaultManager];
    if(![fmanager fileExistsAtPath:docPlistPath]){  //document下不存在

        NSError *error;
        //创建name子目录
        if(![fmanager fileExistsAtPath:nameDirPath]){
            [fmanager createDirectoryAtPath:nameDirPath withIntermediateDirectories:YES attributes:nil error:&error];
        }

        //拷贝,把 Bundle里下的文件拷贝到 name目录下
        if([fmanager fileExistsAtPath:docPlistPath]){  //如果已经存在了
            //[NSDictionary dictionaryWithContentsOfURL:[NSURL fileURLWithPath:plistPath] error:nil];
            _theme = [NSDictionary dictionaryWithContentsOfFile:docPlistPath].mutableCopy;
        }else{
            //判断bundPlistPath是否存在
            if([fmanager fileExistsAtPath:bundPlistPath]){
                [fmanager copyItemAtPath:bundPlistPath toPath:docPlistPath error:&error];
                if (error) {
                    _theme = [NSDictionary dictionaryWithContentsOfFile:bundPlistPath].mutableCopy;
                }else{
                    _theme = [NSDictionary dictionaryWithContentsOfFile:docPlistPath ].mutableCopy;
                }

            }else{
                _theme = [NSDictionary dictionaryWithContentsOfFile:defaultPlistPath].mutableCopy;
            }

        }

    }else{
        _theme = [NSDictionary dictionaryWithContentsOfFile:docPlistPath ].mutableCopy;
    }

    NSAssert(_theme!=nil, @"Error: 主题皮肤配置不能为空");

    _currentName=name;
}


@end

