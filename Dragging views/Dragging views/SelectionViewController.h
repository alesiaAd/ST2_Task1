//
//  SelectionViewController.h
//  Dragging views
//
//  Created by Alesia Adereyko on 01/06/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@class SelectionViewController;
@protocol SelectionViewControllerDelegate <NSObject>

- (void) selectionViewControllerDelegateMethod: (DraggingModel *) model;

@end

@interface SelectionViewController : UIViewController

@property (nonatomic, weak) id <SelectionViewControllerDelegate> delegate;

@end


