//
//  LoginViewController.m
//  picShow
//
//  Created by songway on 15/9/22.
//  Copyright © 2015年 wings. All rights reserved.
//

#import "LoginViewController.h"

// Utilities
#import <SVProgressHUD/SVProgressHUD.h>

// View Model
#import "LoginViewModel.h"



@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) LoginViewModel *viewModel;

@end

@implementation LoginViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) return nil;
    
    self.viewModel = [LoginViewModel new];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Configure navigation item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log In" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:nil action:nil];
    
    // Reactive Stuff
    @weakify(self);
    RAC(self.viewModel, username) = self.usernameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    self.navigationItem.rightBarButtonItem.rac_command = self.viewModel.loginCommand;
    
    [[self.viewModel.loginCommand.executionSignals flattenMap:^(RACSignal *execution) {
        // Sends RACUnit after the execution completes.
        return [[execution ignoreValues] concat:[RACSignal return:RACUnit.defaultUnit]];
    }] subscribeNext:^(id _) {
        @strongify(self);
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.viewModel.loginCommand.errors subscribeNext:^(id x) {
        NSLog(@"Login error: %@", x);
    }];
    
    self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
                [subscriber sendCompleted];
            }];
            
            return nil;
        }];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
