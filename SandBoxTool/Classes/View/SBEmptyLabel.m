//
//  SBEmptyLabel.m
//  SandBoxTool
//
//  Created by wsong on 2018/7/7.
//  Copyright © 2018年 zbjt. All rights reserved.
//

#import "SBEmptyLabel.h"

@implementation SBEmptyLabel

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    static NSString *const tip = @"请启动模拟器";
    NSDictionary *attris = @{NSFontAttributeName : [NSFont systemFontOfSize:17]};
    CGFloat width = [tip boundingRectWithSize:dirtyRect.size
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attris].size.width;
    CGFloat x = (dirtyRect.size.width - width) * 0.5;
    
    [tip drawInRect:NSMakeRect(x, dirtyRect.origin.y, width, dirtyRect.size.height)
           withAttributes:attris];
}

@end
