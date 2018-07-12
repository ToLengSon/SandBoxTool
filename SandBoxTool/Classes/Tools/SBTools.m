//
//  SBTools.m
//  SandBoxTool
//
//  Created by wsong on 2018/7/7.
//  Copyright © 2018年 zbjt. All rights reserved.
//

#import "SBTools.h"

@implementation SBTools

// 执行一个命令
+ (void)executeCommand:(NSString *)command
                handle:(void (^)(NSString *path))handle {
    // 获取系统上的tmp目录
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.dat"];
    // 将命令执行重定向至tmp目录的tmp文件
    system([NSString stringWithFormat:@"%@ > %@", command, path].UTF8String);
    // 将路径回调至外部使用
    handle(path);
    // 删除tmp文件
    system([NSString stringWithFormat:@"rm %@", path].UTF8String);
}

@end
