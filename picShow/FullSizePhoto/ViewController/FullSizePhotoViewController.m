//
//  FullSizePhotoViewController.m
//  picShow
//
//  Created by songway on 15/9/20.
//  Copyright © 2015年 wings. All rights reserved.
//

#import "FullSizePhotoViewController.h"
#import "PhotoViewController.h"
#import "PhotoDetailViewController.h"

#import "FullSizePhotoViewModel.h"
#import "PhotoViewModel.h"
#import "PhotoDetailViewModel.h"

@interface FullSizePhotoViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation FullSizePhotoViewController

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:@{UIPageViewControllerOptionInterPageSpacingKey:@(30)}];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    [self addChildViewController:self.pageViewController];
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.pageViewController setViewControllers:@[[self photoViewControllerForIndex:self.viewModel.initialPhotoIndex]]
direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.title = self.viewModel.initialPhotoName;
    
    @weakify(self);
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    
    infoButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            PhotoViewController *photoViewController = self.pageViewController.viewControllers.firstObject;
            PhotoModel *photoModel = photoViewController.viewModel.model;
            
            PhotoDetailViewModel *viewModel = [[PhotoDetailViewModel alloc] initWithModel:photoModel];
            
            PhotoDetailViewController *viewController = [[PhotoDetailViewController alloc] initWithViewModel:viewModel];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
            
            [self presentViewController:navigationController animated:YES completion:^{
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.pageViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.pageViewController.view];
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

- (PhotoViewController*)photoViewControllerForIndex:(NSInteger)index {
    PhotoModel *photoModel = [self.viewModel photoModelAtIndex:index];
    if (photoModel) {
        PhotoViewModel *photoViewModel = [[PhotoViewModel alloc] initWithModel:photoModel];
        PhotoViewController *photoViewController = [[PhotoViewController alloc] initWithViewModel:photoViewModel index:index];
        return photoViewController;
    }
    return nil;
}

#pragma mark - UIPageViewControllerDelegate Methods

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    self.title = [((PhotoViewController *)self.pageViewController.viewControllers.firstObject).viewModel photoName];
    [self.delegate userDidScroll:self toPhotoAtIndex:[self.pageViewController.viewControllers.firstObject photoIndex]];
}

#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(PhotoViewController *)viewController {
    return [self photoViewControllerForIndex:viewController.photoIndex - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(PhotoViewController *)viewController {
    return [self photoViewControllerForIndex:viewController.photoIndex + 1];
}


@end
