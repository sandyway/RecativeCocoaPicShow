//
//  LoginViewModel.h
//  picShow
//
//  Created by songway on 15/9/22.
//  Copyright © 2015年 wings. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LoginViewModel : RVMViewModel

@property (nonatomic, readonly) RACCommand *loginCommand;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@end
