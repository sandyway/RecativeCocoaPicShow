//
//  GalleryViewcontroller.m
//  picShow
//
//  Created by songway on 15/9/19.
//  Copyright © 2015年 wings. All rights reserved.
//

#import "GalleryViewcontroller.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "FullSizePhotoViewController.h"
#import "LoginViewController.h"
//
// View models
#import "GalleryViewModel.h"
#import "FullSizePhotoViewModel.h"
//
//// Views
#import "Cell.h"
//
// Utilities
#import "GalleryFlowLayout.h"

@interface GalleryViewController ()
@property (nonatomic, strong) GalleryViewModel *viewModel;
@end

@implementation GalleryViewController

static NSString * const reuseIdentifier = @"Cell";

- (id)init {
    GalleryFlowLayout *flowLayout = [GalleryFlowLayout new];
    
    self = [self initWithCollectionViewLayout:flowLayout];
    if (!self) {
        return nil;
    }
    
    self.viewModel = [GalleryViewModel new];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    self.title = @"Popular on 500px";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log In" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Register cell classes
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    @weakify(self);
    [RACObserve(self.viewModel, model) subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    
    [[self rac_signalForSelector:@selector(userDidScroll:toPhotoAtIndex:) fromProtocol:@protocol(FullSizePhotoViewControllerDelegate)]
     subscribeNext:^(RACTuple *value) {
         @strongify(self);
         [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[value.second integerValue] inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
     }];
    
    [[self rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:)
                    fromProtocol:@protocol(UICollectionViewDelegate)]
     subscribeNext:^(RACTuple *arguments) {
         @strongify(self);
         NSIndexPath *indexPath = arguments.second;
         FullSizePhotoViewModel *viewModel = [[FullSizePhotoViewModel alloc] initWithPhotoArray:self.viewModel.model initialPhotoIndex:indexPath.item];
         
         FullSizePhotoViewController *viewController = [FullSizePhotoViewController new];
         viewController.viewModel = viewModel;
         viewController.delegate = nil;
         viewController.delegate = (id<FullSizePhotoViewControllerDelegate>)self;
         [self.navigationController pushViewController:viewController animated:YES];
    }];
    self.collectionView.delegate = nil;
    self.collectionView.delegate = self;
    
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            LoginViewController *viewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
            [self presentViewController:navigationController animated:YES completion:^{
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
    
    
}



//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//}


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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.model.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    [cell setPhotoModel:self.viewModel.model[indexPath.row]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
