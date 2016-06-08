//
//  HomeVideoView.m
//  QSBK
//
//  Created by jiangke on 16/6/4.
//  Copyright © 2016年 TianYu. All rights reserved.
//

#import "HomeVideoImage.h"

@implementation HomeVideoImage

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.fillColor = [[UIColor alloc]initWithWhite:0.2 alpha:0.6].CGColor;
        shapeLayer.lineWidth = 2;
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 60, 60)];
        shapeLayer.path = path.CGPath;
        [self.layer addSublayer:shapeLayer];
        
        CAShapeLayer *arcLayer = [CAShapeLayer layer];
        arcLayer.fillColor = [UIColor whiteColor].CGColor;
        UIBezierPath *arcPath = [[UIBezierPath alloc]init];
        [arcPath moveToPoint:CGPointMake(30 - 9, 30 - 12)];
        [arcPath addLineToPoint:CGPointMake(30 - 9, 30 + 12)];
        [arcPath addLineToPoint:CGPointMake(30 + (19.2 - 9), 30)];
        [arcPath closePath];
        arcLayer.path = arcPath.CGPath;
        [shapeLayer addSublayer:arcLayer];
        
    }
    return self;
}


@end
