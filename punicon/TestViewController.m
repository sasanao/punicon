//
//  ViewController.m
//  animation_test
//
//  Created by dpcc on 2015/04/21.
//  Copyright (c) 2015年 kdl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//角度→ラジアン変換
#if !defined(RADIANS)
#define RADIANS(D) (D * M_PI / 180)
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //    sublayer = [CAShapeLayer layer];
    //    sublayer.backgroundColor = [UIColor blueColor].CGColor;
    //    sublayer.anchorPoint = CGPointMake(0.5, 0.5);//アニメーションの中心点の設定
    //    sublayer.bounds = CGRectMake(0, 0, 100, 100);
    //    sublayer.position = CGPointMake(100, 100);
    //
    //    [self.view.layer addSublayer:sublayer];
    //
    //    sublayer.contents = (id)[UIImage imageNamed:@"analogue_handle"].CGImage;
    
    //[self makeLineLayer:self.view.layer lineFromPointA:leftcenter toPointB:rightcenter];
    
    sublayer1 = [CAShapeLayer layer];
    sublayer1.fillColor = nil;
    sublayer1.opacity = 1.0;
    sublayer1.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:sublayer1];
    
    sublayer2 = [CAShapeLayer layer];
    sublayer2.fillColor = nil;
    sublayer2.opacity = 1.0;
    sublayer2.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:sublayer2];
    
    sublayer3 = [CAShapeLayer layer];
    sublayer3.fillColor = nil;
    sublayer3.opacity = 1.0;
    sublayer3.strokeColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:sublayer3];
    
    //    [self drawLine];
    
    [self drawCircle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //タッチされた位置を取得
    CGPoint touchpoint = [touch locationInView:self.view];
    //得られた位置にあるlayerを取得
    //    CALayer *layer = [self.view.layer hitTest:touchpoint];
    
    //    [self addCurve:touchpoint];
    [self drawMoveCircle:touchpoint];
    [self drawLine:touchpoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //タッチされた位置を取得
    CGPoint touchpoint = [touch locationInView:self.view];
    //得られた位置にあるlayerを取得
    //    CALayer *layer = [self.view.layer hitTest:touchpoint];
    
    //    [self addCurve:touchpoint];
    [self drawMoveCircle:touchpoint];
    [self drawLine:touchpoint];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [self drawLine];
    [self drawCircle];
    
    sublayer2.path=nil;
    sublayer3.path=nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [self drawLine];
    [self drawCircle];
    
    sublayer2.path=nil;
    sublayer3.path=nil;
}

- (void)start:(id)sender
{
    CGPoint leftcenter = CGPointMake(0, self.view.frame.size.height / 2);
    CGPoint rightcenter = CGPointMake(self.view.frame.size.width, self.view.frame.size.height / 2);
    
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint: leftcenter];
    //    [linePath addLineToPoint:rightcenter];
    
    // 中点の座標を取得します。
    CGPoint middlePoint = CGPointMake((leftcenter.x + rightcenter.x) / 2,
                                      (leftcenter.y + rightcenter.y) / 2);
    
    [linePath addQuadCurveToPoint:middlePoint controlPoint:CGPointMake(100, 100)];
    
    [linePath addLineToPoint:rightcenter];
    
    sublayer1.path=linePath.CGPath;
    
    //    [sublayer setNeedsDisplay];
    
    
    
    //    sublayer.position = CGPointMake(160, 320);
    
    //    [self doBeatAnimation];
    //
    //    UIBezierPath *path = [UIBezierPath bezierPath];
    //    [path moveToPoint:CGPointMake(30, 0)];
    //    [path addLineToPoint:CGPointMake(0, 25)];
    //    [path addLineToPoint:CGPointMake(15, 25)];
    //    [path addLineToPoint:CGPointMake(15, 60)];
    //    [path addLineToPoint:CGPointMake(45, 60)];
    //    [path addLineToPoint:CGPointMake(45, 25)];
    //    [path addLineToPoint:CGPointMake(60, 25)];
    //    [path closePath];
    //
    //    sublayer.fillColor = [UIColor blackColor].CGColor;
    //    sublayer.path = path.CGPath;
    //    sublayer.transform = CATransform3DMakeScale(2, 2, 1);
}

- (void)doBeatAnimation
{
    //座標でなく、形をアニメーションすることを示す　transformのかわりにpositionで移動系のアニメーション
    CABasicAnimation* prompt = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    //    //アニメーションにかかる時間(秒)
    //    prompt.duration = 0.3;
    //    //膨張させる割合　前からx,y,z軸　普通に使う場合はzは1.0としておき、 1.1,1.1,1.0のように使う
    //    prompt.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)];
    
    prompt.duration = 0.1;
    prompt.fromValue = [NSValue valueWithCATransform3D:
                        CATransform3DMakeRotation(-0.05, 0.0, 0.0, 1.0)];
    prompt.toValue = [NSValue valueWithCATransform3D:
                      CATransform3DMakeRotation(0.05, 0.0, 0.0, 1.0)];
    
    //繰り返し回数　HUGE_VALFで永久に繰り返すこともできる
    prompt.repeatCount = 1;
    //アニメーションの設定　YESだと鼓動　NOだと1.0から1.1になるところのみ描画(1.1から1.0に縮むところは描画しない)
    prompt.autoreverses = YES;
    //アニメーションさせる　キーはよくわからないです
    [sublayer1 addAnimation:prompt forKey:@"blink"];
}

- (void)drawCircle
{
    CGPoint center = self.view.center;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:center radius:50 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    sublayer1.path=bezierPath.CGPath;
}

- (void)drawMoveCircle:(CGPoint)movePoint
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:movePoint radius:20 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    sublayer2.path=bezierPath.CGPath;
}

- (void)addCurveCircle
{
    CGPoint center = self.view.center;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:center radius:50 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    sublayer2.path=bezierPath.CGPath;
}

- (void)drawLine:(CGPoint)movePoint
{
    CGPoint center = self.view.center;
    
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint: movePoint];
    
    // 2点の角度
    float x = movePoint.x - center.x;
    float y = movePoint.y - center.y;
    float radian = atan2f(y, x);
    
    // 90度曲げた角度
    float radian2 = radian - RADIANS(90);
    float x2 = cosf(radian2) * 50;
    float y2 = sinf(radian2) * 50;
    //    [linePath addLineToPoint:CGPointMake(center.x + x2, center.y + y2)];
    
    CGPoint middlePoint = CGPointMake((center.x + movePoint.x) / 2,
                                      (center.y + movePoint.y) / 2);
    
    [linePath addQuadCurveToPoint:CGPointMake(center.x + x2, center.y + y2) controlPoint:middlePoint];
    
    //    NSString* radianLog = [NSString stringWithFormat:@"radian = %f, x = %f, y = %f", radian, x2, y2];
    //    [textView setText:radianLog];
    
    [linePath moveToPoint: movePoint];
    
    // 90度曲げた角度
    float radian3 = radian - RADIANS(-90);
    float x3 = cosf(radian3) * 50;
    float y3 = sinf(radian3) * 50;
    [linePath addQuadCurveToPoint:CGPointMake(center.x + x3, center.y + y3) controlPoint:middlePoint];
    
    sublayer3.path=linePath.CGPath;
    
}

- (void)addCurve:(CGPoint)point
{
    CGPoint leftcenter = CGPointMake(0, self.view.frame.size.height / 2);
    CGPoint rightcenter = CGPointMake(self.view.frame.size.width, self.view.frame.size.height / 2);
    
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint: leftcenter];
    //    [linePath addLineToPoint:rightcenter];
    
    //    // 中点の座標を取得します。
    //    CGPoint middlePoint = CGPointMake((leftcenter.x + rightcenter.x) / 2,
    //                                      (leftcenter.y + rightcenter.y) / 2);
    
    [linePath addQuadCurveToPoint:rightcenter controlPoint:point];
    
    //    [linePath addLineToPoint:rightcenter];
    
    sublayer2.path=linePath.CGPath;
}

@end
