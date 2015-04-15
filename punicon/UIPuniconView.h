//
//  UIPuniconView.h
//  punicon
//
//  Created by dpcc on 2015/04/15.
//  Copyright (c) 2015年 kdl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPuniconView : UIView {
    CAShapeLayer *_shapeLayer;
    CAShapeLayer *_arrowLayer;
    CAShapeLayer *_highlightLayer;
}

@property BOOL bNeetDraw;
@property CGPoint ptStartPoint;
@property CGPoint ptEndPoint;
@property BOOL bFirstDraw;

@property (nonatomic, strong) UIColor *tintColor;

@end
