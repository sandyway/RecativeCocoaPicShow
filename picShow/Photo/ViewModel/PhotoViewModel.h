//
//  PhotoViewModel.h
//  picShow
//
//  Created by songway on 15/9/20.
//  Copyright © 2015年 wings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveViewModel/ReactiveViewModel.h>

@class PhotoModel;

@interface PhotoViewModel : RVMViewModel

@property (nonatomic, strong) PhotoModel *model;

@property (nonatomic, readonly) UIImage *photoImage;
@property (nonatomic, readonly, getter= isLoading) BOOL loading;

- (NSString *)photoName;
- (instancetype)initWithModel:(PhotoModel *)photoModel;

@end
