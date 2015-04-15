//
//  UIPuniconView.m
//  punicon
//
//  Created by dpcc on 2015/04/15.
//  Copyright (c) 2015年 kdl. All rights reserved.
//

#import "UIPuniconView.h"

@implementation UIPuniconView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.bNeetDraw) {
        [self drawLine];
        [self draw];
    }
}

- (void)drawLine
{
    // UIBezierPath のインスタンス生成
    UIBezierPath *line = [UIBezierPath bezierPath];
    // 起点
    [line moveToPoint:self.ptStartPoint];
    // 帰着点
    [line addLineToPoint:self.ptEndPoint];
    // 色の設定
    [[UIColor redColor] setStroke];
    // ライン幅
    line.lineWidth = 2;
    // 描画
    [line stroke];
}

- (void)draw
{
    // startpoint周りに円を書く
    CGRect rect = CGRectMake(self.ptStartPoint.x - 10, self.ptStartPoint.y - 10, 20, 20);
    
    if (self.bFirstDraw) {
        
    }
    else {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextAddEllipseInRect(ctx, rect);
        CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
        CGContextFillPath(ctx);
    }
    
    // endpoint周りに円を書く
    
    
    // それをつなげる

}

@end
