//
//  ViewController.m
//  Dragging views
//
//  Created by Alesia Adereyko on 01/06/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *draggingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
    draggingView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:draggingView];
    
    UIPanGestureRecognizer *pan =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handlePan:)];
    [draggingView addGestureRecognizer:pan];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    UIView *draggingView = recognizer.view;
    if (!draggingView) {
        return;
    }
    [self.view bringSubviewToFront:draggingView];
    CGPoint translatedPoint = [recognizer translationInView:draggingView.superview];
    CGPoint location = [recognizer locationInView:draggingView.superview];
    NSLog(@"%@", NSStringFromCGPoint(translatedPoint));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        draggingView.center = location;
    }
    draggingView.center = CGPointMake(draggingView.center.x + translatedPoint.x, draggingView.center.y +translatedPoint.y);
    [recognizer setTranslation:CGPointZero inView:draggingView.superview];
}


@end
