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

-(id)initWithImageName:(NSString *)imageName andTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.imageName = imageName;
        self.title = title;
    }
    return self;
}

@end

@interface ViewController () <SelectionViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray * draggingViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Dragging views";
    
    UITapGestureRecognizer *tapSelfView =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTapSelfView:)];
    [self.view addGestureRecognizer:tapSelfView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(nextView)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
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
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addModel:(DraggingModel *)model {
    DraggingView *draggingView = [[DraggingView alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
    draggingView.model = model;
    CGPoint newCenter = draggingView.center;
    newCenter.x = self.view.center.x;
    newCenter.y = self.view.center.y;
    draggingView.center = newCenter;
    [self.draggingViews addObject:draggingView];
    [self.view addSubview:draggingView];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    [draggingView addGestureRecognizer:tap];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self.view];
    if (touch.view == self.view) {
        self.title = @"Dragging views";
        return;
    }
    DraggingView *draggingView = (DraggingView *)touch.view;
    self.title = draggingView.model.title;
    [self.view bringSubviewToFront:draggingView];
    draggingView.center = touchLocation;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self.view];
    if (touch.view == self.view) {
        return;
    }
    touch.view.center = touchLocation;
}

@end
