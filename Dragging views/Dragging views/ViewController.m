//
//  ViewController.m
//  Dragging views
//
//  Created by Alesia Adereyko on 01/06/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "ViewController.h"
#import "SelectionViewController.h"

@interface DraggingView : UIView

@property (nonatomic, strong) DraggingModel * model;

@end


@implementation DraggingView

- (void)drawRect:(CGRect)rect
{
    UIImage *natureImage = [UIImage imageNamed:self.model.imageName];
    CGRect natureImageRect = self.bounds;
    [natureImage drawInRect:natureImageRect];
}

@end

@implementation DraggingModel

@end

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray * draggingViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DraggingModel* model = [DraggingModel new];
    model.imageName = @"dog1";
    model.title = @"dog1";
    
    DraggingView *draggingView = [[DraggingView alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
    draggingView.model = model;
    [self.view addSubview:draggingView];
    
    [self.draggingViews addObject:model];
    
    DraggingModel* model2 = [DraggingModel new];
    model2.imageName = @"dog2";
    model2.title = @"dog2";
    
    DraggingView *draggingView2 = [[DraggingView alloc] initWithFrame:CGRectMake(100, 100, 88, 88)];
    draggingView2.model = model2;
    [self.view addSubview:draggingView2];
    
    [self.draggingViews addObject:model2];
    
    DraggingModel* model3 = [DraggingModel new];
    model3.imageName = @"dog1";
    model3.title = @"dog1";
    
    DraggingView *draggingView3 = [[DraggingView alloc] initWithFrame:CGRectMake(110, 200, 88, 88)];
    draggingView3.model = model3;
    [self.view addSubview:draggingView3];
    
    [self.draggingViews addObject:model3];
    
    UIPanGestureRecognizer *pan =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handlePan:)];
    [draggingView addGestureRecognizer:pan];
    
    UIPanGestureRecognizer *pan2 =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handlePan:)];
    [draggingView2 addGestureRecognizer:pan2];
    
    UIPanGestureRecognizer *pan3 =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handlePan:)];
    [draggingView3 addGestureRecognizer:pan3];
    
    self.draggingViews = [NSMutableArray new];
    self.title = @"Dragging views";
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    [draggingView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    [draggingView2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    [draggingView3 addGestureRecognizer:tap3];
    
    UITapGestureRecognizer *tapSelfView =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTapSelfView:)];
    [self.view addGestureRecognizer:tapSelfView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(nextView)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    DraggingView *draggingView = (DraggingView *)recognizer.view;
    self.title = draggingView.model.title;
    [self.view bringSubviewToFront:draggingView];
    CGPoint translatedPoint = [recognizer translationInView:draggingView.superview];
    CGPoint location = [recognizer locationInView:draggingView.superview];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        draggingView.center = location;
    }
    draggingView.center = CGPointMake(draggingView.center.x + translatedPoint.x, draggingView.center.y +translatedPoint.y);
    [recognizer setTranslation:CGPointZero inView:draggingView.superview];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    DraggingView *draggingView = (DraggingView *)recognizer.view;
    self.title = draggingView.model.title;
}

- (void)handleTapSelfView:(UITapGestureRecognizer *)recognizer {
    self.title = @"Dragging views";
}

-(void)nextView {
    SelectionViewController *vc = [[SelectionViewController alloc] initWithNibName:@"SelectionViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
