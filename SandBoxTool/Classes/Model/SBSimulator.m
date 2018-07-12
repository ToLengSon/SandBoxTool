//
//  SBSimulator.m
//  SandBoxTool
//
//  Created by wsong on 2018/7/6.
//  Copyright © 2018 zbjt. All rights reserved.
//

#import "SBSimulator.h"
#import "SBApp.h"
#import "SBTools.h"

@implementation SBSimulator

@synthesize appList = _appList;

+ (instancetype)simulatorWithDict:(NSDictionary *)dict {
    
    SBSimulator *simulator = [[self alloc] init];
    [simulator setValuesForKeysWithDictionary:dict];
    return simulator;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (NSArray<SBApp *> *)appList {
    if (_appList == nil) {
        
        __block NSDictionary *appDictList = nil;
        // 获取指定设备上的app列表
        [SBTools executeCommand:[NSString stringWithFormat:@"xcrun simctl listapps %@", self.udid]
                         handle:^(NSString *path) {
                             appDictList = [NSDictionary dictionaryWithContentsOfFile:path];
                         }];
 
        NSMutableArray *appList = [NSMutableArray array];
        
        for (NSString *key in appDictList) {
            // 只获取用户应用
            if ([appDictList[key][@"ApplicationType"] caseInsensitiveCompare:@"user"] == NSOrderedSame) {
                [appList addObject:[SBApp appWithDict:appDictList[key]]];
            }
        }
        _appList = appList;
    }
    return _appList;
}

@end
