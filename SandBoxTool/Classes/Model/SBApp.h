//
//  SBApp.h
//  SandBoxTool
//
//  Created by wsong on 2018/7/6.
//  Copyright © 2018 zbjt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBApp : NSObject

@property (copy) NSString *name;

@property (copy) NSString *bundleId;

@property (copy) NSString *sandBoxPath;

+ (instancetype)appWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
