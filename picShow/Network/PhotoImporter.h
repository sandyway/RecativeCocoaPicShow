//
//  PhotoImporter.h
//  picShow
//
//  Created by songway on 15/9/19.
//  Copyright © 2015年 wings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@class PhotoModel;

@interface PhotoImporter : NSObject

+ (RACSignal *)importPhotos;

+ (RACSignal *)fetchPhotoDetails:(PhotoModel *)photoModel;

+ (RACSignal *)logInWithUsername:(NSString *)username password:(NSString *)password;

+ (RACSignal *)voteForPhoto:(PhotoModel *)photoModel;


@end
