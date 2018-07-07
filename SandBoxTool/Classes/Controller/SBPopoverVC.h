//
//  SBPopoverVC.h
//  SandBoxTool
//
//  Created by wsong on 2018/3/27.
//  Copyright © 2018年 zbjt. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SBPopoverVC : NSViewController

@property (nonatomic, copy) void (^shouldHidden)(SBPopoverVC *popoverVC);

@end
