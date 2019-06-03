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
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation ListView

- (void)drawRect:(CGRect)rect
{
    UIImage *natureImage = [UIImage imageNamed:self.model.imageName];
    CGRect natureImageRect = CGRectMake(0, 0, natureImage.size.width, natureImage.size.height);
    [natureImage drawInRect:natureImageRect];
}

@end

@interface SelectionViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray * models;

@end

@implementation SelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.models = [[self makeDataArray] mutableCopy];
    
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
    
    CGFloat topAnchor = 0;
    CGFloat width = 0;
    for (DraggingModel *model in self.models) {
        CGSize viewSize = [self addNextView:model topAnchor:topAnchor width: width];
        topAnchor += viewSize.height;
        width = viewSize.width;
    }
    self.scrollView.contentSize = CGSizeMake(width, topAnchor);
}

- (CGSize)addNextView:(DraggingModel *)model topAnchor:(float)top width:(CGFloat)width{
    ListView *listView = [ListView new];
    listView.model = model;
    listView.layer.borderColor = [UIColor blackColor].CGColor;
    listView.layer.borderWidth = 1.f;
    [self.scrollView addSubview:listView];
    
    listView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat imgHeight = [UIImage imageNamed:listView.model.imageName].size.height;
    CGFloat imgWidth = [UIImage imageNamed:listView.model.imageName].size.width;
    CGFloat margin = 10;
    
    listView.descriptionLabel = [UILabel new];
    listView.descriptionLabel.text = listView.model.title;
    listView.backgroundColor = [UIColor whiteColor];
    [listView addSubview:listView.descriptionLabel];
    listView.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [listView.descriptionLabel.leadingAnchor constraintEqualToAnchor:listView.leadingAnchor],
                                              [listView.descriptionLabel.topAnchor constraintEqualToAnchor:listView.topAnchor constant:imgHeight + margin],
                                              [listView.descriptionLabel.trailingAnchor constraintEqualToAnchor:listView.trailingAnchor],
                                              [listView.descriptionLabel.heightAnchor constraintEqualToConstant:44]
                                              ]
     ];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [listView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:margin],
                                              [listView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:top + margin],
                                              [listView.widthAnchor constraintEqualToConstant:imgWidth],
                                              [listView.heightAnchor constraintEqualToConstant:imgHeight + margin + 44]
                                              ]
     ];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    [listView addGestureRecognizer:tap];
    
    if(imgWidth > width) {
        return CGSizeMake(imgWidth, imgHeight + 2 * margin + 44);
    }
    else {
        return CGSizeMake(width, imgHeight + 2 * margin + 44);
    }
}

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    ListView *listView = (ListView *) recognizer.view;
    [self.delegate addDraggingViewWithModel: listView.model];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)makeDataArray {
    NSMutableArray *dataArray = [[NSMutableArray new] mutableCopy];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog1" andTitle:@"https://loremflickr.com/cache/resized/65535_32744905647_da43bb2fce_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog2" andTitle:@"https://loremflickr.com/cache/resized/4911_46959780851_58738a2083_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog3" andTitle:@"https://loremflickr.com/cache/resized/7836_46284519764_ddcaa28a56_320_240_nofilter.jpg"]];
     [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog4" andTitle:@"https://loremflickr.com/cache/resized/7813_46287423134_5afa7bcd57_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog5" andTitle:@"https://loremflickr.com/cache/resized/65535_47040794644_ec04c6cd99_n_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog6" andTitle:@"https://loremflickr.com/cache/resized/7837_40532717253_736eff13cc_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog7" andTitle:@"https://loremflickr.com/cache/resized/65535_47770358311_ed044d81fa_n_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog8" andTitle:@"https://loremflickr.com/cache/resized/65535_32679655547_a37566176b_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog9" andTitle:@"https://loremflickr.com/cache/resized/7826_33679237908_8f694a661d_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog10" andTitle:@"https://loremflickr.com/cache/resized/65535_47939825882_54e5a1145d_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog11" andTitle:@"https://loremflickr.com/cache/resized/7844_47084062491_6dafeca912_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog12" andTitle:@"https://loremflickr.com/cache/resized/7853_46542637344_db7f1feeda_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog13" andTitle:@"https://loremflickr.com/cache/resized/7908_46458348365_85702d5c91_n_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog14" andTitle:@"https://loremflickr.com/cache/resized/65535_33788346308_2d66e52e15_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog15" andTitle:@"https://loremflickr.com/cache/resized/7821_46620537064_e3418ed662_n_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog16" andTitle:@"https://loremflickr.com/cache/resized/7820_33175245668_725e361c68_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog17" andTitle:@"https://loremflickr.com/cache/resized/65535_47932256183_38a8a7cb7f_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog18" andTitle:@"https://loremflickr.com/cache/resized/65535_47950556471_85bf283010_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog19" andTitle:@"https://loremflickr.com/cache/resized/65535_40749790083_9d63bba0de_n_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog20" andTitle:@"https://loremflickr.com/cache/resized/7852_33232501078_ceb933d356_n_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog21" andTitle:@"https://loremflickr.com/cache/resized/7877_32558797847_4f0d557d00_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog22" andTitle:@"https://loremflickr.com/cache/resized/7871_46491920275_fcc6b968dd_n_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog23" andTitle:@"https://loremflickr.com/cache/resized/7837_33290814938_28e0017075_n_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog24" andTitle:@"https://loremflickr.com/cache/resized/7908_46205258275_3f8ebaacd8_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog25" andTitle:@"https://loremflickr.com/cache/resized/65535_47925027771_eac364cd66_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog26" andTitle:@"https://loremflickr.com/cache/resized/7925_46544599225_d34f37186d_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog27" andTitle:@"https://loremflickr.com/cache/resized/65535_33788346308_2d66e52e15_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog28" andTitle:@"https://loremflickr.com/cache/resized/7858_40266472703_604807ec41_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog29" andTitle:@"https://loremflickr.com/cache/resized/65535_47811664471_c782a7682d_320_240_nofilter.jpg"]];
    [dataArray addObject:[[DraggingModel alloc] initWithImageName:@"dog30" andTitle:@"https://loremflickr.com/cache/resized/7827_47330082201_233bab7f38_320_240_nofilter.jpg"]];
    return [dataArray copy];
}

@end
