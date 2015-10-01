//
//  PhotoDetailViewModel.h
//  picShow
//
//  Created by songway on 15/9/22.
//  Copyright © 2015年 wings. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@class PhotoModel;

@interface PhotoDetailViewModel : RVMViewModel

@property (nonatomic, readonly) PhotoModel *model;

@property (nonatomic, readonly) NSString *photoName;
@property (nonatomic, readonly) NSString *photoRating;
@property (nonatomic, readonly) NSString *photographerName;
@property (nonatomic, readonly) NSString *votePromptText;

@property (nonatomic, readonly) RACCommand *voteCommand;

@property (nonatomic, readonly) BOOL loggedIn;

- (instancetype)initWithModel:(PhotoModel*)model;

@end
