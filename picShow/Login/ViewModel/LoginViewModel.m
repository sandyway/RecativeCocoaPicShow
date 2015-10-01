//
//  LoginViewModel.m
//  picShow
//
//  Created by songway on 15/9/22.
//  Copyright © 2015年 wings. All rights reserved.
//

#import "LoginViewModel.h"
#import "PhotoImporter.h"

@interface LoginViewModel ()

@property (nonatomic, strong) RACCommand *loginCommand;

@end


@implementation LoginViewModel


-(instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    @weakify(self);
    self.loginCommand = [[RACCommand alloc] initWithEnabled:[self validateLoginInputs]
                                                signalBlock:^RACSignal *(id input) {
                                                    @strongify(self);
                                                    return [PhotoImporter logInWithUsername:self.username password:self.password];
                                                }];
    
    return self;
}

- (RACSignal *)validateLoginInputs
{
    return [RACSignal combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^id(NSString *username, NSString *password){
        return @(username.length > 0 && password.length > 0);
    }];
}


@end
