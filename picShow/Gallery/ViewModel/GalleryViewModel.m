//
//  GalleryViewModel.m
//  picShow
//
//  Created by songway on 15/9/19.
//  Copyright © 2015年 wings. All rights reserved.
//

#import "GalleryViewModel.h"

#import "PhotoImporter.h"

@implementation GalleryViewModel

-(instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    RAC(self, model) = [self importPhotosSignal];
    
    return self;
}

-(RACSignal *)importPhotosSignal {
    return [[[PhotoImporter importPhotos] logError] catchTo:[RACSignal empty]];
}

@end
