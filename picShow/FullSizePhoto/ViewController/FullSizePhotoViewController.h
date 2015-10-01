//
//  FullSizePhotoViewController.h
//  picShow
//
//  Created by songway on 15/9/20.
//  Copyright © 2015年 wings. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FullSizePhotoViewController;

@protocol FullSizePhotoViewControllerDelegate <NSObject>

- (void)userDidScroll:(FullSizePhotoViewController *)viewController toPhotoAtIndex:(NSInteger)index;

@end

@class FullSizePhotoViewModel;

@interface FullSizePhotoViewController : UIViewController

@property (nonatomic, strong) FullSizePhotoViewModel *viewModel;

@property (nonatomic, weak) id<FullSizePhotoViewControllerDelegate> delegate;

@end
