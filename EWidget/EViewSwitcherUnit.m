//
//  EViewSwitcherUnit.m
//  EWidgetDemo
//
//  Created by Efergy China on 10/2/14.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import "EViewSwitcherUnit.h"

@implementation EViewSwitcherUnit
@synthesize contentView = _contentView;
@synthesize actualIndex = _actualIndex;
@synthesize currentIndex = _currentIndex;
@synthesize radius = _radius;
@synthesize centerOfSwitcher = _centerOfSwitcher;
@synthesize angle = _angle;
@synthesize isInFront = _isInFront;
@synthesize maxYOffset = _maxYOffset;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithContentView:(UIView *)contentView
{
    self = [self initWithFrame:contentView.frame];
    if (self)
    {
        _contentView = contentView;
        [self addSubview:_contentView];
    }
    return self;
}

#pragma -mark- Setter and Getter

- (void)setAngle:(CGFloat)angle
{
    _angle = angle;
    CGFloat viewCenterX = _centerOfSwitcher.x - (_radius * sin(angle));
    CGFloat viewCenterZ = _radius * cos(angle);
    CGFloat viewCenterY = _centerOfSwitcher.y + (_maxYOffset * (_radius - viewCenterZ) / (2 * _radius));
    [self setCenter:CGPointMake(viewCenterX, viewCenterY)];
    self.layer.zPosition = viewCenterZ;
}



#pragma -mark- Animation Method
- (void)animateToFront
{
    CGPoint startPoint = self.center;
    CGPoint endPoint = _centerOfSwitcher;
    
    CGMutablePathRef thePath = CGPathCreateMutable();
    CGPathMoveToPoint(thePath, NULL, startPoint.x, startPoint.y);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = thePath;
    animation.duration = 1;
    
    [self.layer addAnimation:animation forKey:@"position"];
    [self setCenter:endPoint];
}

@end
