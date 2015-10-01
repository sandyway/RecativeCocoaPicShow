//
//  GalleryFlowLayout.m
//  picShow
//
//  Created by songway on 15/9/19.
//  Copyright © 2015年 wings. All rights reserved.
//

#import "GalleryFlowLayout.h"

@implementation GalleryFlowLayout

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.itemSize = CGSizeMake(145, 145);
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    return self;
}


@end
