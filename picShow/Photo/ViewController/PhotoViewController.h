//
//  PhotoViewController.h
//  picShow
//
//  Created by songway on 15/9/20.
//  Copyright © 2015年 wings. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoViewModel;

@interface PhotoViewController : UIViewController

- (instancetype)initWithViewModel:(PhotoViewModel *)viewModel index:(NSInteger)photoIndex;

@property (nonatomic, readonly) NSInteger photoIndex;

@property (nonatomic, readonly) PhotoViewModel *viewModel;

@end
