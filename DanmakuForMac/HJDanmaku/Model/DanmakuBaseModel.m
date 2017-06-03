//
//  DanmakuBaseModel.m
//  DanmakuDemo
//
//  Created by Haijiao on 15/2/28.
//  Copyright (c) 2015年 olinone. All rights reserved.
//

#import "DanmakuBaseModel.h"
#import "DanmakuView.h"

static NSTextField *sharedTxtField;

@implementation DanmakuBaseModel

- (void)measureSizeWithPaintHeight:(CGFloat)paintHeight;
{
    if (self.isMeasured) {
        return;
    }
    
//    self.size = CGSizeMake([self.text sizeWithAttributes:@{NSFontAttributeName: [NSFont systemFontOfSize:self.textSize]}].width, paintHeight);
    self.size = CGSizeMake([self widthOfString:self.text withFont:[NSFont systemFontOfSize:self.textSize]], paintHeight);
    self.isMeasured = YES;
}

- (CGFloat)widthOfString:(NSString *)string withFont:(NSFont *)font {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTxtField = [[NSTextField alloc] init];
        sharedTxtField.font = font;
    });
    sharedTxtField.frame = CGRectZero;
    sharedTxtField.stringValue = string;
    [sharedTxtField sizeToFit];
    return sharedTxtField.frame.size.width;
}

- (void)layoutWithScreenWidth:(float)width;
{
    
}

- (float)pxWithScreenWidth:(float)width RemainTime:(float)remainTime
{
    return -self.size.width;
}

- (BOOL)isDraw:(float)curTime
{
    return self.time>=curTime;
}

- (BOOL)isLate:(float)curTime
{
    return (curTime+1)<self.time;
}

@end

@implementation DanmakuLRModel

- (void)layoutWithScreenWidth:(float)width;
{
    self.px = [self pxWithScreenWidth:width RemainTime:self.remainTime];
}

- (float)pxWithScreenWidth:(float)width RemainTime:(float)remainTime
{
    return -self.size.width+(width+self.size.width)/self.duration*remainTime;
}

@end

@implementation DanmakuFTModel

- (void)layoutWithScreenWidth:(float)width;
{
    self.px = (width-self.size.width)/2;
    float alpha = 0;
    if (self.remainTime>0 && self.remainTime<self.duration) {
        alpha= 1;
    }
    [self.label setAlphaValue:alpha];
}

@end

@implementation DanmakuFBModel

@end

@implementation DanmakuLabel

- (id)init
{
    if (self = [super init]) {
        self.bordered = self.editable = self.drawsBackground = NO;
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [NSColor blackColor];
//        shadow.shadowOffset = _shadowOffset;
        shadow.shadowBlurRadius = 1;
        self.shadow = shadow;
    }
    return self;
}

//- (void)drawRect:(NSRect)dirtyRect
//{
//    NSColor *textColor = self.textColor;
//    CGContextRef c = [[NSGraphicsContext currentContext] graphicsPort];
//    CGContextSetLineWidth(c, 2);
//    CGContextSetLineJoin(c, kCGLineJoinRound);
//    
//    CGContextSetTextDrawingMode(c, kCGTextStroke);
//    self.textColor = [NSColor colorWithWhite:0.2 alpha:1.0];
//    [super drawRect:dirtyRect];
//    
//    CGContextSetTextDrawingMode(c, kCGTextFill);
//    self.textColor = textColor;
//    [super drawRect:dirtyRect];
//    
//    if (self.underLineEnable) {
//        CGContextSetStrokeColorWithColor(c, [NSColor redColor].CGColor);
//        CGContextSetLineWidth(c, 2.0f);
//        CGPoint leftPoint = CGPointMake(0, self.frame.size.height);
//        CGPoint rightPoint = CGPointMake(self.frame.size.width, self.frame.size.height);
//        CGContextMoveToPoint(c, leftPoint.x, leftPoint.y);
//        CGContextAddLineToPoint(c, rightPoint.x, rightPoint.y);
//        CGContextStrokePath(c);
//    }
//}

@end
