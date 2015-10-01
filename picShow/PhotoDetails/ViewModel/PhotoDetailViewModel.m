//
//  PhotoDetailViewModel.m
//  picShow
//
//  Created by songway on 15/9/22.
//  Copyright © 2015年 wings. All rights reserved.
//

#import "PhotoDetailViewModel.h"
#import <500px-iOS-api/PXAPI.h>


#import "PhotoModel.h"


#import "PhotoImporter.h"

@interface PhotoDetailViewModel ()

@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSString *photoRating;
@property (nonatomic, strong) NSString *photographerName;
@property (nonatomic, strong) NSString *votePromptText;

@property (nonatomic, strong) RACCommand *voteCommand;
@property (nonatomic, strong) PhotoModel *model;


@end

@implementation PhotoDetailViewModel

- (instancetype)initWithModel:(PhotoModel*)photoModel {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.model = photoModel;
    RAC(self, photoName) = RACObserve(self.model, photoName);
    RAC(self, photoRating) = [RACObserve(self.model, rating) map:^id(id value) {
        return [NSString stringWithFormat:@"%0.2f", [value floatValue]];
    }];
    RAC(self,photographerName) = RACObserve(self.model, photographerName);
    RAC(self, votePromptText) = [RACObserve(self.model, votedFor) map:^id(id value) {
        if ([value boolValue]) {
            return @"Voted For!";
        } else {
            return @"Vote";
        }
    }];
    
    @weakify(self);
    self.voteCommand = [[RACCommand alloc] initWithEnabled:[RACObserve(self.model, votedFor) not] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [PhotoImporter voteForPhoto:self.model];
    }];
    
    return self;
}

- (BOOL)loggedIn {
    return [[PXRequest apiHelper] authMode] == PXAPIHelperModeOAuth;
}

@end
