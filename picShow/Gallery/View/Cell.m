//
//  Cell.m
//  picShow
//
//  Created by songway on 15/9/19.
//  Copyright © 2015年 wings. All rights reserved.
//

#import "Cell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PhotoModel.h"
#import "NSData+AFDecompression.h"

@interface Cell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation Cell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor darkGrayColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
    RAC(self.imageView, image) = [[[RACObserve(self, photoModel.thumbnailData) ignore:nil] map:^id(id value) {
        return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [value af_decompressedImageFromJPEGDataWithCallback:
             ^(UIImage *decompressedImage) {
                 [subscriber sendNext:decompressedImage];
                 [subscriber sendCompleted];
             }];
            return nil;
        }] subscribeOn:[RACScheduler scheduler]];
    }] switchToLatest];
    
    return self;
}

@end
