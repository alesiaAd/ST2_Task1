//
//  SelectionViewController.m
//  Dragging views
//
//  Created by Alesia Adereyko on 01/06/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "SelectionViewController.h"
#import "ViewController.h"

@interface ListView : UIView

@property (nonatomic, strong) DraggingModel *model;
@property (nonatomic, strong) UIView *imgView;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation ListView

- (void)drawRect:(CGRect)rect
{
    UIImage *natureImage = [UIImage imageNamed:self.model.imageName];
    CGRect natureImageRect = self.imgView.bounds;
    [natureImage drawInRect:natureImageRect];
}

@end

@interface SelectionViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select item";
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
        ]
     ];
    
    DraggingModel* model = [DraggingModel new];
    model.imageName = @"dog1";
    model.title = @"dog";
    
    ListView *listView = [ListView new];
    listView.model = model;
    [self.scrollView addSubview:listView];
    
    listView.translatesAutoresizingMaskIntoConstraints = NO;
    
    listView.imgView = [UIView new];
    [listView addSubview:listView.imgView];
    
    listView.imgView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLog(@"%f", [UIImage imageNamed:listView.model.imageName].size.height);
    [NSLayoutConstraint activateConstraints:@[
                                              [listView.imgView.leadingAnchor constraintEqualToAnchor:listView.leadingAnchor],
                                              [listView.imgView.topAnchor constraintEqualToAnchor:listView.topAnchor],
                                              [listView.imgView.widthAnchor constraintEqualToConstant:[UIImage imageNamed:listView.model.imageName].size.width],
                                              [listView.imgView.heightAnchor constraintEqualToConstant:[UIImage imageNamed:listView.model.imageName].size.height]
                                              ]
     ];
    
    listView.descriptionLabel = [UILabel new];
    listView.descriptionLabel.text = listView.model.title;
    listView.backgroundColor = [UIColor whiteColor];
    [listView addSubview:listView.descriptionLabel];
    listView.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [listView.descriptionLabel.leadingAnchor constraintEqualToAnchor:listView.leadingAnchor],
                                              [listView.descriptionLabel.topAnchor constraintEqualToAnchor:listView.imgView.bottomAnchor constant:20],
                                              [listView.descriptionLabel.widthAnchor constraintEqualToAnchor:listView.imgView.widthAnchor multiplier:1],
                                              [listView.descriptionLabel.heightAnchor constraintEqualToConstant:44]
                                              ]
     ];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [listView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
                                              [listView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
                                              [listView.widthAnchor constraintEqualToAnchor:listView.imgView.widthAnchor multiplier:1],
                                              [listView.heightAnchor constraintEqualToConstant:[UIImage imageNamed:listView.model.imageName].size.height + 20 + 44]
                                              ]
     ];
}

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
