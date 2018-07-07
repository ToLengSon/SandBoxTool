//
//  SBSimulator.h
//  SandBoxTool
//
//  Created by wsong on 2018/7/6.
//  Copyright © 2018 zbjt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SBApp;

@interface SBSimulator : NSObject

@property (copy) NSString *name;

@property (copy) NSString *udid;

@property (copy) NSString *systemVersion;

/** app列表 */
@property (nonatomic, strong, readonly) NSArray<SBApp *> *appList;

+ (instancetype)simulatorWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
