//
//  SBEmptyLabel.m
//  SandBoxTool
//
//  Created by wsong on 2018/7/7.
//  Copyright © 2018年 zbjt. All rights reserved.
//

#import "SBLabel.h"

@interface SBLabel ()

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *height;

@end

@implementation SBLabel

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    /** 判断是否是夜间模式 */
    BOOL isNight = [[NSAppearance currentAppearance].name isEqualToString:NSAppearanceNameVibrantDark];
    
    NSDictionary *attris = @{NSFontAttributeName : [NSFont systemFontOfSize:17],
                             NSForegroundColorAttributeName : isNight? [NSColor whiteColor] : [NSColor blackColor]};
    CGSize size = [self.text boundingRectWithSize:NSMakeSize(dirtyRect.size.width, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:attris].size;
    
    self.height.constant = size.height;
    
    CGFloat x = (dirtyRect.size.width - size.width) * 0.5;
    
    [self.text drawInRect:NSMakeRect(x, dirtyRect.origin.y, size.width, size.height)
           withAttributes:attris];
}

- (void)setText:(NSString *)text {
    _text = text;
    [self setNeedsDisplay:YES];
}

@end
