//
//  UIPuniconView.m
//  punicon
//
//  Created by dpcc on 2015/04/15.
//  Copyright (c) 2015年 kdl. All rights reserved.
//

#import "UIPuniconView.h"

#define kTotalViewHeight    400
#define kOpenedViewHeight   44
#define kMinTopPadding      9
#define kMaxTopPadding      5
#define kMinTopRadius       12.5
#define kMaxTopRadius       16
#define kMinBottomRadius    3
#define kMaxBottomRadius    16
#define kMinBottomPadding   4
#define kMaxBottomPadding   6
#define kMinArrowSize       2
#define kMaxArrowSize       3
#define kMinArrowRadius     5
#define kMaxArrowRadius     7
#define kMaxDistance        53

@implementation UIPuniconView

static inline CGFloat lerp(CGFloat a, CGFloat b, CGFloat p)
{
    return a + (b - a) * p;
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
//    _tintColor = [UIColor colorWithRed:155.0 / 255.0 green:162.0 / 255.0 blue:172.0 / 255.0 alpha:1.0];
//    
//    _shapeLayer = [CAShapeLayer layer];
//    _shapeLayer.fillColor = [_tintColor CGColor];
//    _shapeLayer.strokeColor = [[[UIColor darkGrayColor] colorWithAlphaComponent:0.5] CGColor];
//    _shapeLayer.lineWidth = 0.5;
//    _shapeLayer.shadowColor = [[UIColor blackColor] CGColor];
//    _shapeLayer.shadowOffset = CGSizeMake(0, 1);
//    _shapeLayer.shadowOpacity = 0.4;
//    _shapeLayer.shadowRadius = 0.5;
//    [self.layer addSublayer:_shapeLayer];
//    
//    _arrowLayer = [CAShapeLayer layer];
//    _arrowLayer.strokeColor = [[[UIColor darkGrayColor] colorWithAlphaComponent:0.5] CGColor];
//    _arrowLayer.lineWidth = 0.5;
//    _arrowLayer.fillColor = [[UIColor whiteColor] CGColor];
//    [_shapeLayer addSublayer:_arrowLayer];
//    
//    _highlightLayer = [CAShapeLayer layer];
//    _highlightLayer.fillColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.2] CGColor];
//    [_shapeLayer addSublayer:_highlightLayer];
//    
//    self.points = [[NSMutableArray alloc]init];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.bNeetDraw) {
//        [self draw];
//        [self test];
        [self drawBGImage];
        [self drawHandleImage];
        [self drawLine];
    }
    else {
        _shapeLayer.path = nil;
    }
}

- (void)drawHandleImage
{
    // startpoint周りに円を書く
    NSInteger imageSize = 94;
    CGRect rect = CGRectMake(self.ptEndPoint.x - (imageSize / 2), self.ptEndPoint.y - (imageSize / 2), imageSize, imageSize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIImage* image = [UIImage imageNamed:@"analogue_handle"];

//    CGContextTranslateCTM(ctx, 0, image.size.height);
//    CGContextScaleCTM(ctx, 1.0, -1.0);
    
    CGContextSetAlpha(ctx, 0.1);
    CGContextDrawImage(ctx, rect, [image CGImage]);
}

- (void)drawBGImage
{
    // startpoint周りに円を書く
    NSInteger imageSize = 150;
    CGRect rect = CGRectMake(self.ptStartPoint.x - (imageSize / 2), self.ptStartPoint.y - (imageSize / 2), imageSize, imageSize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIImage* image = [UIImage imageNamed:@"analogue_bg"];
    
    CGContextSetAlpha(ctx, 0.1);
    CGContextDrawImage(ctx, rect, [image CGImage]);
}

CGPoint midPoint(CGPoint p1, CGPoint p2)
{
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

- (void)drawLine
{
//    // UIBezierPath のインスタンス生成
//    UIBezierPath *line = [UIBezierPath bezierPath];
//    // 起点
//    [line moveToPoint:self.ptStartPoint];
//    // 帰着点
//    [line addLineToPoint:self.ptEndPoint];
//    // 色の設定
//    [[UIColor redColor] setStroke];
//    // ライン幅
//    line.lineWidth = 2;
//    // 描画
//    [line stroke];
    
    // 開始から終了までを４分割
    CGPoint pt2 = midPoint(self.ptStartPoint, self.ptEndPoint);
    CGPoint pt1 = midPoint(self.ptStartPoint, pt2);
    CGPoint pt3 = midPoint(pt2, self.ptEndPoint);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 最初は太め
    CGContextMoveToPoint(ctx, self.ptStartPoint.x, self.ptStartPoint.y);
    CGContextAddLineToPoint(ctx, pt1.x, pt1.y);
    CGContextSetLineWidth(ctx, 50.0);
    
//    CGContextAddQuadCurveToPoint(ctx, self.ptStartPoint.x, self.ptStartPoint.y, pt1.x, pt1.y);
    // 真ん中二つは普通
//    CGContextSetLineWidth(ctx, 30.0);
//    CGContextAddQuadCurveToPoint(ctx, pt1.x, pt1.y, pt2.x, pt2.y);
//    CGContextAddQuadCurveToPoint(ctx, pt2.x, pt2.y, pt3.x, pt3.y);
    // 最後は細め
//    CGContextSetLineWidth(ctx, 10.0);
//    CGContextAddQuadCurveToPoint(ctx, pt3.x, pt3.y, self.ptEndPoint.x, self.ptEndPoint.y);
    
    CGContextSetLineWidth(ctx, 20.0);
    CGContextAddLineToPoint(ctx, self.ptEndPoint.x, self.ptEndPoint.y);
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetRGBStrokeColor(ctx, 0.3, 0.3, 0.3, 0.3);
    CGContextStrokePath(ctx);
    
    UIGraphicsEndImageContext();
}

- (void)draw
{
//    [self drawStartCircle];
//    [self drawEndCircle];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    // 開始点に大きめの円を描く
    CGPathAddArc(path, NULL, self.ptStartPoint.x, self.ptStartPoint.y, 30, 0, M_PI*2, NO);
//    CGPathMoveToPoint(path, NULL, self.ptStartPoint.x, self.ptStartPoint.y);

    
    // 終了点へ線を引く
//    CGPathAddLineToPoint (path, NULL, self.ptStartPoint.x, self.ptStartPoint.y);
//    CGPathAddLineToPoint (path, NULL, self.ptEndPoint.x, self.ptEndPoint.y);
//    CGPathCloseSubpath(path);
    
    
//    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    _shapeLayer.lineWidth = 3;
//    _shapeLayer.shadowPath = path;
    
    // 終了点に小さめの円を描く
    CGPathAddArc(path, NULL, self.ptEndPoint.x, self.ptEndPoint.y, 20, 0, M_PI*2, NO);
    
//    CGPathMoveToPoint(path, NULL, self.ptEndPoint.x, self.ptEndPoint.y);

    _shapeLayer.path = path;

    CGPathRelease(path);
}

- (void)drawStartCircle
{
    // startpoint周りに円を書く
    CGRect rect = CGRectMake(self.ptStartPoint.x - 10, self.ptStartPoint.y - 10, 20, 20);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2] CGColor]));
    CGContextFillPath(ctx);
}

- (void)drawEndCircle
{
    // endpoint周りに円を書く
    CGRect rect = CGRectMake(self.ptEndPoint.x - 5, self.ptEndPoint.y - 5, 10, 10);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2] CGColor]));
    CGContextFillPath(ctx);
}

- (void)test
{
    CGFloat offset = 0.0f;

    CGMutablePathRef path = CGPathCreateMutable();
    
    //Calculate some useful points and values
    CGFloat verticalShift = MAX(0, -((kMaxTopRadius + kMaxBottomRadius + kMaxTopPadding + kMaxBottomPadding) + offset));
    CGFloat distance = MIN(kMaxDistance, fabs(verticalShift));
    CGFloat percentage = 1 - (distance / kMaxDistance);
    
    CGFloat currentTopPadding = lerp(kMinTopPadding, kMaxTopPadding, percentage);
    CGFloat currentTopRadius = lerp(kMinTopRadius, kMaxTopRadius, percentage);
    CGFloat currentBottomRadius = lerp(kMinBottomRadius, kMaxBottomRadius, percentage);
    CGFloat currentBottomPadding =  lerp(kMinBottomPadding, kMaxBottomPadding, percentage);
    
    CGPoint bottomOrigin = CGPointMake(floor(self.bounds.size.width / 2), self.bounds.size.height - currentBottomPadding -currentBottomRadius);
    CGPoint topOrigin = CGPointZero;
    if (distance == 0) {
        topOrigin = CGPointMake(floor(self.bounds.size.width / 2), bottomOrigin.y);
    } else {
        topOrigin = CGPointMake(floor(self.bounds.size.width / 2), self.bounds.size.height + offset + currentTopPadding + currentTopRadius);
        if (percentage == 0) {
            bottomOrigin.y -= (fabs(verticalShift) - kMaxDistance);
//            triggered = YES;
        }
    }
    
    topOrigin = self.ptStartPoint;
    bottomOrigin = self.ptEndPoint;
    currentBottomRadius = currentBottomRadius / 2;
    
    //Top semicircle
//    CGPathAddArc(path, NULL, topOrigin.x, topOrigin.y, currentTopRadius, 0, M_PI, YES);
    
    CGPathMoveToPoint(path, NULL, topOrigin.x, topOrigin.y);

    //Left curve
    CGPoint leftCp1 = CGPointMake(lerp((topOrigin.x - currentTopRadius), (bottomOrigin.x - currentBottomRadius), 0.1), lerp(topOrigin.y, bottomOrigin.y, 0.2));
    CGPoint leftCp2 = CGPointMake(lerp((topOrigin.x - currentTopRadius), (bottomOrigin.x - currentBottomRadius), 0.9), lerp(topOrigin.y, bottomOrigin.y, 0.2));
    CGPoint leftDestination = CGPointMake(bottomOrigin.x - currentBottomRadius, bottomOrigin.y);
    
    CGPathAddCurveToPoint(path, NULL, leftCp1.x, leftCp1.y, leftCp2.x, leftCp2.y, leftDestination.x, leftDestination.y);
    
    //Bottom semicircle
//    CGPathAddArc(path, NULL, bottomOrigin.x, bottomOrigin.y, currentBottomRadius, M_PI, 0, YES);
    
    //Right curve
    CGPoint rightCp2 = CGPointMake(lerp((topOrigin.x + currentTopRadius), (bottomOrigin.x + currentBottomRadius), 0.1), lerp(topOrigin.y, bottomOrigin.y, 0.2));
    CGPoint rightCp1 = CGPointMake(lerp((topOrigin.x + currentTopRadius), (bottomOrigin.x + currentBottomRadius), 0.9), lerp(topOrigin.y, bottomOrigin.y, 0.2));
    CGPoint rightDestination = CGPointMake(topOrigin.x + currentTopRadius, topOrigin.y);
    
    CGPathAddCurveToPoint(path, NULL, rightCp1.x, rightCp1.y, rightCp2.x, rightCp2.y, rightDestination.x, rightDestination.y);
    CGPathCloseSubpath(path);
    
    // Set paths
    
    _shapeLayer.path = path;
//    _shapeLayer.shadowPath = path;
    
    // Add the arrow shape
    
//    CGFloat currentArrowSize = lerp(kMinArrowSize, kMaxArrowSize, percentage);
//    CGFloat currentArrowRadius = lerp(kMinArrowRadius, kMaxArrowRadius, percentage);
//    CGFloat arrowBigRadius = currentArrowRadius + (currentArrowSize / 2);
//    CGFloat arrowSmallRadius = currentArrowRadius - (currentArrowSize / 2);
//    CGMutablePathRef arrowPath = CGPathCreateMutable();
//    CGPathAddArc(arrowPath, NULL, topOrigin.x, topOrigin.y, arrowBigRadius, 0, 3 * M_PI_2, NO);
//    CGPathAddLineToPoint(arrowPath, NULL, topOrigin.x, topOrigin.y - arrowBigRadius - currentArrowSize);
//    CGPathAddLineToPoint(arrowPath, NULL, topOrigin.x + (2 * currentArrowSize), topOrigin.y - arrowBigRadius + (currentArrowSize / 2));
//    CGPathAddLineToPoint(arrowPath, NULL, topOrigin.x, topOrigin.y - arrowBigRadius + (2 * currentArrowSize));
//    CGPathAddLineToPoint(arrowPath, NULL, topOrigin.x, topOrigin.y - arrowBigRadius + currentArrowSize);
//    CGPathAddArc(arrowPath, NULL, topOrigin.x, topOrigin.y, arrowSmallRadius, 3 * M_PI_2, 0, YES);
//    CGPathCloseSubpath(arrowPath);
//    _arrowLayer.path = arrowPath;
//    [_arrowLayer setFillRule:kCAFillRuleEvenOdd];
//    CGPathRelease(arrowPath);
    
    // Add the highlight shape
    
//    CGMutablePathRef highlightPath = CGPathCreateMutable();
//    CGPathAddArc(highlightPath, NULL, topOrigin.x, topOrigin.y, currentTopRadius, 0, M_PI, YES);
//    CGPathAddArc(highlightPath, NULL, topOrigin.x, topOrigin.y + 1.25, currentTopRadius, M_PI, 0, NO);
//    
//    _highlightLayer.path = highlightPath;
//    [_highlightLayer setFillRule:kCAFillRuleNonZero];
//    CGPathRelease(highlightPath);
    
    CGPathRelease(path);
}

@end
