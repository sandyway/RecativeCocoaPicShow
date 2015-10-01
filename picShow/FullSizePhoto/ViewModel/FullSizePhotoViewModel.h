//
//  FullSizePhotoViewModel.h
//  picShow
//
//  Created by songway on 15/9/22.
//  Copyright © 2015年 wings. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@class PhotoModel;

@interface FullSizePhotoViewModel : RVMViewModel

-(instancetype)initWithPhotoArray:(NSArray *)photoArray initialPhotoIndex:(NSInteger)initialPhotoIndex;
-(PhotoModel *)photoModelAtIndex:(NSInteger)index;

@property (nonatomic, readonly, strong) NSArray *model;
@property (nonatomic, readonly) NSInteger initialPhotoIndex;

@property (nonatomic, readonly) NSString *initialPhotoName;

@end
