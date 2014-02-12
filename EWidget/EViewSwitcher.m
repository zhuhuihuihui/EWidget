//
//  EViewSwitcher.m
//  EChartDemo
//
//  Created by Scott Zhu on 14-1-30.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import "EViewSwitcher.h"
@interface EViewSwitcher()

@property (nonatomic) CGFloat viewPathRadius;

@end

@implementation EViewSwitcher
@synthesize arrayOfViews = _arrayOfViews;
@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;
@synthesize topView = _topView;
@synthesize viewPathRadius = _viewPathRadius;
@synthesize maxYOffset = _maxYOffset;
@synthesize positionOfTheFrontMostView = _positionOfTheFrontMostView;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
        _viewPathRadius = CGRectGetWidth(self.bounds) / 4;
        _maxYOffset = 20;
        _positionOfTheFrontMostView = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    }
    return self;
}

-(void)layoutSubviews
{
    
}

- (void) initViews
{
    CGFloat angle = M_PI * 2 / [_dataSource numberOfViewsInEViewSwitcher:self];
    
    for (int i = 0; i < [_dataSource numberOfViewsInEViewSwitcher:self]; i++)
    {
        EViewSwitcherUnit *view = [[EViewSwitcherUnit alloc] initWithContentView:[_dataSource eSwitcher:self viewAtIndex:i]];
        view.centerOfSwitcher = _positionOfTheFrontMostView;
        view.actualIndex = i;
        view.currentIndex = i;
        view.radius = _viewPathRadius;
        view.maxYOffset = _maxYOffset;
        [view setAngle:angle * i];
        [self addSubview:view];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eViewSwitcherUnitTaped:)];
        [view addGestureRecognizer:tapGestureRecognizer];
        
//        NSLog(@"%@", NSStringFromCGRect(view.frame));
//        UIView *view = [_dataSource eSwitcher:self viewAtIndex:i];
//        CGFloat viewCenterX = CGRectGetMidX(self.bounds) - (_viewPathRadius * sin(angle * i));
//        CGFloat viewCenterZ = _viewPathRadius * cos(angle * i);
//        /** temporarily use middle y, will need to change it later*/
//        CGFloat viewCenterY = CGRectGetMidY(self.bounds) + (_maxYOffset * (_viewPathRadius - viewCenterZ) / (2 * _viewPathRadius));
//        [view setCenter:CGPointMake(viewCenterX, viewCenterY)];
//        view.layer.zPosition = viewCenterZ;
//        view.tag = i;
//        NSLog(@"%@", NSStringFromCGPoint(view.center));
        
//        NSLog(@"%f", view.layer.zPosition);
        
    }
}


#pragma -mark- Setter and Getter
-(void)setDataSource:(id<EViewSwitcherDataSource>)dataSource
{
    if (dataSource && dataSource != _dataSource)
    {
        _dataSource = dataSource;
        [self initViews];
    }
}

- (void)setDelegate:(id<EViewSwitcherDelegate>)delegate
{
    if (delegate && delegate != _delegate)
    {
        _delegate = delegate;
    }
}

#pragma -mark- Gesture

- (void) eViewSwitcherUnitTaped:(UITapGestureRecognizer *)sender
{
    EViewSwitcherUnit *eViewSwitcherUnit = (EViewSwitcherUnit *)sender.view;
    NSLog(@"Index %d taped", eViewSwitcherUnit.actualIndex);
    [eViewSwitcherUnit animateToFront];
}

@end
