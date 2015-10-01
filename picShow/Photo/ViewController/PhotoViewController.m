//
//  PhotoViewController.m
//  picShow
//
//  Created by songway on 15/9/20.
//  Copyright © 2015年 wings. All rights reserved.
//

#import "PhotoViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PhotoViewModel.h"

#import <SVProgressHUD.h>

@interface PhotoViewController ()
@property (nonatomic, assign)NSInteger photoIndex;
@property (nonatomic, strong)PhotoViewModel *viewModel;

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation PhotoViewController

- (instancetype)initWithViewModel:(PhotoViewModel *)viewModel index:(NSInteger)photoIndex {
    self = [self init];
    if (!self) {
        return nil;
    }
    
    self.viewModel = viewModel;
    self.photoIndex = photoIndex;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    RAC(imageView, image) = RACObserve(self.viewModel, photoImage);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    [RACObserve(self.viewModel, loading) subscribeNext:^(NSNumber *loading) {
        if (loading.boolValue) {
            [SVProgressHUD show];
        } else {
            [SVProgressHUD dismiss];
        }
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.viewModel.active = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.viewModel.active = NO;
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
