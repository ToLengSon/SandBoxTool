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

/** 设备名称 */
@property (copy) NSString *name;
/** 设备标识 */
@property (copy) NSString *udid;
/** 系统版本 */
@property (copy) NSString *systemVersion;

/** app列表 */
@property (nonatomic, strong, readonly) NSArray<SBApp *> *appList;

+ (instancetype)simulatorWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
