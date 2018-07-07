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
    
    system([NSString stringWithFormat:@"echo `%@` > tmp.dat", command].UTF8String);
    handle(@"tmp.dat");
    system("rm tmp.dat");
}

@end
