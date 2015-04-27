//
//  UIPuniconView.h
//  punicon
//
//  Created by dpcc on 2015/04/15.
//  Copyright (c) 2015年 kdl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPuniconView : UIView {
    CAShapeLayer* _sublayer1;
    CAShapeLayer* _sublayer2;
    CAShapeLayer* _sublayer3;
}

@property CGPoint ptStartPoint;
@property CGPoint ptEndPoint;

@end
