//
//  FullSizePhotoViewModel.m
//  picShow
//
//  Created by songway on 15/9/22.
//  Copyright © 2015年 wings. All rights reserved.
//

#import "FullSizePhotoViewModel.h"

// Model
#import "PhotoModel.h"

@interface FullSizePhotoViewModel ()

// Private access
@property (nonatomic, assign) NSInteger initialPhotoIndex;

@end

@implementation FullSizePhotoViewModel

-(instancetype)initWithPhotoArray:(NSArray *)photoArray initialPhotoIndex:(NSInteger)initialPhotoIndex {
    self = [self init];
    if (!self) return nil;
    
    _model = photoArray;
    
    self.initialPhotoIndex = initialPhotoIndex;
    
    return self;
}

-(NSString *)initialPhotoName {
    PhotoModel *photoModel = [self initialPhotoModel];
    return [photoModel photoName];
}

//-(NSString *)initialPhotoName {
//    return [self.model[self.initialPhotoIndex] photoName];
//}

-(PhotoModel *)photoModelAtIndex:(NSInteger)index {
    if (index < 0 || index > self.model.count - 1) {
        // Index was out of bounds, return nil
        return nil;
    } else {
        return self.model[index];
    }
}

#pragma mark - Private Methods

-(PhotoModel *)initialPhotoModel {
    return [self photoModelAtIndex:self.initialPhotoIndex];
}

@end
