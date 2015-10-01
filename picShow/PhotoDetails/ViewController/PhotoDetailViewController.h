//
//  PhotoDetailViewController.h
//  picShow
//
//  Created by songway on 15/9/22.
//  Copyright © 2015年 wings. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoDetailViewModel;

@interface PhotoDetailViewController : UIViewController

- (instancetype)initWithViewModel:(PhotoDetailViewModel *)viewModel;

@property (nonatomic, readonly) PhotoDetailViewModel *viewModel;

@end
