//
//  SBApp.m
//  SandBoxTool
//
//  Created by wsong on 2018/7/6.
//  Copyright © 2018 zbjt. All rights reserved.
//

#import "SBApp.h"

@implementation SBApp

+ (instancetype)appWithDict:(NSDictionary *)dict {
    
    SBApp *app = [[self alloc] init];
    
    app.name = dict[@"CFBundleDisplayName"];
    app.bundleId = dict[@"CFBundleIdentifier"];
    app.sandBoxPath = dict[@"DataContainer"];
    return app;
}

@end
