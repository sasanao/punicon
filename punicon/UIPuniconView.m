//
//  UIPuniconView.m
//  punicon
//
//  Created by dpcc on 2015/04/15.
//  Copyright (c) 2015年 kdl. All rights reserved.
//

#import "UIPuniconView.h"

@implementation UIPuniconView

//角度→ラジアン変換
#if !defined(RADIANS)
#define RADIANS(D) (D * M_PI / 180)
#endif

//static inline CGFloat lerp(CGFloat a, CGFloat b, CGFloat p)
//{
//    return a + (b - a) * p;
//}

CGPoint midPoint(CGPoint p1, CGPoint p2)
{
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _sublayer1 = [CAShapeLayer layer];
    _sublayer1.fillColor = nil;
    _sublayer1.opacity = 1.0;
    _sublayer1.strokeColor = [UIColor redColor].CGColor;
    //アニメーションの中心点を設定　0.5,0.5なら中心を起点として膨張・縮小する。
//    _sublayer1.anchorPoint = CGPointMake(0.5,0.5);
//    _sublayer1.bounds = CGRectMake(0, 0, 50, 50);
//    _sublayer1.contentsRect = CGRectMake(0, 0, 1.0, 1.0);
    [self.layer addSublayer:_sublayer1];
    
    _sublayer2 = [CAShapeLayer layer];
    _sublayer2.fillColor = nil;
    _sublayer2.opacity = 1.0;
    _sublayer2.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:_sublayer2];
    
    _sublayer3 = [CAShapeLayer layer];
    _sublayer3.fillColor = nil;
    _sublayer3.opacity = 1.0;
    _sublayer3.strokeColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:_sublayer3];
}

//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray* allTouches = [event.allTouches allObjects];
    UITouch *touch = [allTouches objectAtIndex:0];
    CGPoint pt = [touch locationInView:self];
    
    self.ptStartPoint = pt;
    self.ptEndPoint = pt;
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];

//    [self drawStartCircle];
    [self drawStartImage];
//    [self doBeatAnimation];
    //[self setNeedsDisplay];

    [CATransaction commit];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
    
    NSArray* allTouches = [event.allTouches allObjects];
    UITouch *touch = [allTouches objectAtIndex:0];
    CGPoint pt = [touch locationInView:self];
    
    self.ptEndPoint = pt;
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    
//    [self drawEndCircle];
    [self drawLine];
    
    [self drawEndImage];

    [CATransaction commit];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");

    _sublayer1.path = nil;
    _sublayer1.contents = nil;
    _sublayer2.path = nil;
    _sublayer2.contents = nil;
    _sublayer3.path = nil;
    _sublayer3.contents = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");

    _sublayer1.path = nil;
    _sublayer1.contents = nil;
    _sublayer2.path = nil;
    _sublayer2.contents = nil;
    _sublayer3.path = nil;
    _sublayer3.contents = nil;
}

- (void)drawStartImage
{
    // startpoint周りに円を書く
    NSInteger imageSize = 150;
    CGRect rect = CGRectMake(self.ptStartPoint.x - (imageSize / 2), self.ptStartPoint.y - (imageSize / 2), imageSize, imageSize);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    UIImage* image = [UIImage imageNamed:@"analogue_bg"];
//    
//    CGContextSetAlpha(ctx, 0.1);
//    CGContextDrawImage(ctx, rect, [image CGImage]);
    
    _sublayer1.frame = rect;
    _sublayer1.contents = (id)[UIImage imageNamed:@"analogue_bg"].CGImage;
}

- (void)drawEndImage
{
    // startpoint周りに円を書く
    NSInteger imageSize = 94;
    CGRect rect = CGRectMake(self.ptEndPoint.x - (imageSize / 2), self.ptEndPoint.y - (imageSize / 2), imageSize, imageSize);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    UIImage* image = [UIImage imageNamed:@"analogue_handle"];
//    
//    CGContextSetAlpha(ctx, 0.1);
//    CGContextDrawImage(ctx, rect, [image CGImage]);

    _sublayer2.frame = rect;
    _sublayer2.contents = (id)[UIImage imageNamed:@"analogue_handle"].CGImage;
}

- (void)drawStartCircle
{
    // startpoint周りに円を書く
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:self.ptStartPoint radius:50 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    _sublayer1.path=bezierPath.CGPath;
}

- (void)drawEndCircle
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:self.ptEndPoint radius:20 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    _sublayer2.path=bezierPath.CGPath;
}

- (void)drawLine
{
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    
    // circle1からみた2点の角度
    float x1 = _ptEndPoint.x - _ptStartPoint.x;
    float y1 = _ptEndPoint.y - _ptStartPoint.y;
    float radian1 = atan2f(y1, x1);
    
    // circle2からみた2点の角度
    float x2 = _ptStartPoint.x - _ptEndPoint.x;
    float y2 = _ptStartPoint.y - _ptEndPoint.y;
    float radian2 = atan2f(y2, x2);
    
    // circle1の90度曲げた角度、半径分はなれた位置
    float radian1_right = radian1 - RADIANS(90);
    float x1_right = cosf(radian1_right) * 50;
    float y1_right = sinf(radian1_right) * 50;
    //    [linePath addLineToPoint:CGPointMake(center.x + x2, center.y + y2)];
    
    // circle2の90度曲げた角度、半径分はなれた位置
    float radian2_left = radian2 - RADIANS(90);
    float x2_left = cosf(radian2_left) * 10;
    float y2_left = sinf(radian2_left) * 10;
    
    // circle1の-90度曲げた角度、半径分はなれた位置
    float radian1_left = radian1 - RADIANS(-90);
    float x1_left = cosf(radian1_left) * 50;
    float y1_left = sinf(radian1_left) * 50;
    
    // circle2の-90度曲げた角度、半径分はなれた位置
    float radian2_right = radian2 - RADIANS(-90);
    float x2_right = cosf(radian2_right) * 10;
    float y2_right = sinf(radian2_right) * 10;
    
    // 中間ポイント
    CGPoint middlePoint = midPoint(_ptStartPoint, _ptEndPoint);
    
    // 右側スタート地点
    [linePath moveToPoint: CGPointMake(_ptStartPoint.x + x1_right, _ptStartPoint.y + y1_right)];

    // 右側の線
    [linePath addQuadCurveToPoint:CGPointMake(_ptEndPoint.x + x2_right, _ptEndPoint.y + y2_right) controlPoint:middlePoint];
    
    //    NSString* radianLog = [NSString stringWithFormat:@"radian = %f, x = %f, y = %f", radian, x2, y2];
    //    [textView setText:radianLog];
    
    // 左側スタート地点
    [linePath moveToPoint: CGPointMake(_ptStartPoint.x + x1_left, _ptStartPoint.y + y1_left)];
    
    // 左側の線
    [linePath addQuadCurveToPoint:CGPointMake(_ptEndPoint.x + x2_left, _ptEndPoint.y + y2_left) controlPoint:middlePoint];
    
    _sublayer3.path=linePath.CGPath;
}

- (void)doBeatAnimation
{
    //座標でなく、形をアニメーションすることを示す　transformのかわりにpositionで移動系のアニメーション
    CABasicAnimation* prompt = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    //アニメーションにかかる時間(秒)
    prompt.duration = 0.1;
    //膨張させる割合　前からx,y,z軸　普通に使う場合はzは1.0としておき、 1.1,1.1,1.0のように使う
    prompt.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)];
    
//    prompt.duration = 0.1;
//    prompt.fromValue = [NSValue valueWithCATransform3D:
//                        CATransform3DMakeRotation(-0.05, 0.0, 0.0, 1.0)];
//    prompt.toValue = [NSValue valueWithCATransform3D:
//                      CATransform3DMakeRotation(0.05, 0.0, 0.0, 1.0)];
    
    //繰り返し回数　HUGE_VALFで永久に繰り返すこともできる
    prompt.repeatCount = 1;
    //アニメーションの設定　YESだと鼓動　NOだと1.0から1.1になるところのみ描画(1.1から1.0に縮むところは描画しない)
    prompt.autoreverses = YES;
    //アニメーションさせる　キーはよくわからないです
    [_sublayer1 addAnimation:prompt forKey:@"blink"];
}

@end
