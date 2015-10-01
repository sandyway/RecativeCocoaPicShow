//
//  PhotoViewModel.m
//  picShow
//
//  Created by songway on 15/9/20.
//  Copyright © 2015年 wings. All rights reserved.
//

#import "PhotoViewModel.h"

#import "PhotoImporter.h"
#import "PhotoModel.h"

@interface PhotoViewModel ()

@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, assign, getter = isLoading) BOOL loading;

@end

@implementation PhotoViewModel

- (instancetype)initWithModel:(PhotoModel *)photoModel {
    self = [super init];
    self.model = photoModel;
    if (!self) {
        return nil;
    }
    
    @weakify(self);
    [self.didBecomeActiveSignal subscribeNext:^(id x) {
        @strongify(self);
        [self downloadPhotoModelDetails];
    }];
    
    RAC(self, photoImage) = [RACObserve(self.model, fullsizedData) map:^id(id value) {
        return [UIImage imageWithData:value];
    }];
    
    return self;
}

#pragma mark - Public Methods

-(NSString *)photoName {
    return self.model.photoName;
}

#pragma mark - Private Methods

- (void)downloadPhotoModelDetails {
    self.loading = YES;
    
    @weakify(self);
    [[PhotoImporter fetchPhotoDetails:self.model] subscribeError:^(NSError *error) {
        NSLog(@"Could not fetch photo details:%@", error);
    } completed:^{
        @strongify(self);
        self.loading = NO;
        NSLog(@"Fetched photo details.");
    }];
}

@end
