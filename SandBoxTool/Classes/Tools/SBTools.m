//
//  SBTools.m
//  SandBoxTool
//
//  Created by wsong on 2018/7/7.
//  Copyright © 2018年 zbjt. All rights reserved.
//

#import "SBTools.h"

@implementation SBTools

+ (void)executeCommand:(NSString *)command
                handle:(void (^)(NSString *path))handle {
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.dat"];
    system([NSString stringWithFormat:@"%@ > %@", command, path].UTF8String);
    handle(path);
    system([NSString stringWithFormat:@"rm %@", path].UTF8String);
}

@end
