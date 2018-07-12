//
//  SBTools.h
//  SandBoxTool
//
//  Created by wsong on 2018/7/7.
//  Copyright © 2018年 zbjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBTools : NSObject

- (instancetype)init NS_UNAVAILABLE;

/**
 执行一个命令

 @param command 执行的命令
 @param handle 执行命令之后重定向输出的路径回调
 */
+ (void)executeCommand:(NSString *)command
                handle:(void (^)(NSString *path))handle;

@end
