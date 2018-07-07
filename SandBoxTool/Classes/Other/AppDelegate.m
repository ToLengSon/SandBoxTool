//
//  AppDelegate.m
//  SandBoxTool
//
//  Created by wsong on 2018/3/27.
//  Copyright © 2018年 zbjt. All rights reserved.
//

#import "AppDelegate.h"
#import "SBPopoverVC.h"

@interface AppDelegate ()

/** 沙盒状态栏item */
@property (nonatomic, strong) NSStatusItem *sandBoxToolItem;
/** 弹出视图 */
@property (nonatomic, strong) NSPopover *popover;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    // 创建沙盒状态栏item
    self.sandBoxToolItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    // 设置状态栏app的图标
    [self.sandBoxToolItem.button setImage:[NSImage imageNamed:@"box"]];
    // 给状态栏app绑定点击事件
    self.sandBoxToolItem.button.action = @selector(showPopover:);
    
    // 创建弹出视图
    self.popover = [[NSPopover alloc] init];
    __weak NSPopover *weakPopover = self.popover;
    // 创建一个控制器用于管理弹窗视图的软件界面
    SBPopoverVC *popoverVC = [[SBPopoverVC alloc] init];
    
    popoverVC.shouldHidden = ^(SBPopoverVC *popoverVC) {
        if (weakPopover.isShown) {
            [weakPopover close];
        }
    };
    self.popover.contentViewController = popoverVC;
    
    // 当用户点击弹窗视图之外的区域，使得弹窗视图消失
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskLeftMouseDown
                                           handler:^(NSEvent * _Nonnull event) {
                                               if (weakPopover.isShown) {
                                                   [weakPopover close];
                                               }
                                           }];
}

// 弹出视图
- (void)showPopover:(NSStatusBarButton *)button {
    [self.popover showRelativeToRect:button.bounds
                              ofView:button
                       preferredEdge:NSRectEdgeMaxY];
}

@end
