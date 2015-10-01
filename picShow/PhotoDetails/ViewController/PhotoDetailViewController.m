//
//  PhotoDetailViewController.m
//  picShow
//
//  Created by songway on 15/9/22.
//  Copyright © 2015年 wings. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <500px-iOS-api/PXAPI.h>

#import "PhotoDetailViewModel.h"

#import <SVProgressHUD/SVProgressHUD.h>

#import "LoginViewController.h"


@interface PhotoDetailViewController ()

@property (nonatomic, strong) PhotoDetailViewModel *viewModel;

@end

@implementation PhotoDetailViewController

- (instancetype)initWithViewModel:(PhotoDetailViewModel *)viewModel {
    self = [self init];
    if (!self) {
        return nil;
    }
    
    self.viewModel = viewModel;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    self.title = self.viewModel.photoName;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UILabel *ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 100)];
    RAC(ratingLabel, text) = RACObserve(self.viewModel, photoRating);
    ratingLabel.font = [UIFont boldSystemFontOfSize:80];
    ratingLabel.textColor = [UIColor whiteColor];
    ratingLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:ratingLabel];
    
    UILabel *photoNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(ratingLabel.frame), CGRectGetWidth(self.view.bounds), 20)];
    RAC(photoNameLabel, text) = RACObserve(self.viewModel, photoName);
    photoNameLabel.font = [UIFont systemFontOfSize:16];
    photoNameLabel.textColor = [UIColor whiteColor];
    photoNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:photoNameLabel];
    
    UILabel *photographerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(photoNameLabel.frame), CGRectGetWidth(self.view.bounds), 20)];
    RAC(photographerNameLabel, text) = RACObserve(self.viewModel, photographerName);
    photographerNameLabel.font = [UIFont systemFontOfSize:16];
    photographerNameLabel.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    photographerNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:photographerNameLabel];
    
    UIButton *voteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    voteButton.frame = CGRectMake(20, CGRectGetHeight(self.view.bounds) - 44 - 20, CGRectGetWidth(self.view.bounds) - 40, 44);
    voteButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    [RACObserve(self.viewModel, votePromptText) subscribeNext:^(id value) {
        [voteButton setTitle:value forState:UIControlStateNormal];
    }];
    
    voteButton.rac_command = [[RACCommand alloc] initWithEnabled:self.viewModel.voteCommand.enabled signalBlock:^RACSignal *(id input) {
        RACSignal *authSignal = [RACSignal empty];
        if ([[PXRequest apiHelper] authMode] == PXAPIHelperModeNoAuth) {
            authSignal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                
                LoginViewController *viewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
                
                [self presentViewController:navigationController animated:YES completion:^{
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }] then:^RACSignal *{
                @strongify(self);
                // take:1 so that this signal completes once we've re-appeared.
                return [[self rac_signalForSelector:@selector(viewDidAppear:)] take:1];
            }];
        }
        
        return [authSignal then:^RACSignal *{
            @strongify(self);
            return [[self.viewModel.voteCommand execute:nil] ignoreValues];
        }];
    }];
    [voteButton.rac_command.errors subscribeNext:^(id x) {
        [x subscribeNext:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }];
    }];
    [self.view addSubview:voteButton];
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
