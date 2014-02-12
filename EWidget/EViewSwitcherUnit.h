//
//  EViewSwitcherUnit.h
//  EWidgetDemo
//
//  Created by Efergy China on 10/2/14.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EViewSwitcherUnit : UIView

@property (strong, nonatomic) UIView *contentView;

@property (nonatomic) NSInteger actualIndex;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic) CGFloat radius;
/** This center point actually means center of superview, not center of the circle*/
@property (nonatomic) CGPoint centerOfSwitcher;
@property (nonatomic) CGFloat angle;
@property (nonatomic) BOOL isInFront;
@property (nonatomic) CGFloat maxYOffset;


- (id)initWithContentView:(UIView *)contentView;

- (void)animateToFront;

@end
