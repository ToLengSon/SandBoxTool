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

+ (void)executeCommand:(NSString *)command
                handle:(void (^)(NSString *path))handle;

@end
