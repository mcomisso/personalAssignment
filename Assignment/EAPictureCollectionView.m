//
//  EAPictureCollectionView.m
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import "EAPictureCollectionView.h"
#import "EACollectionViewDataSource.h"
#import "EAPicturePreviewCollectionViewCell.h"
#import "EAPictureDetailViewController.h"
#import "EAModel.h"
#import "Utils.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface EAPictureCollectionView() <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) EACollectionViewDataSource *dataSource;
@property (nonatomic, strong) UIButton *loadingButton;

@property (nonatomic, strong) NSString *searchedItem;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) configureCell configuration;

@property BOOL isUpdating;
@property NSInteger currentPage;

@end

@implementation EAPictureCollectionView

static NSString *reuseIdentifier = @"pictureReuseIdentifier";

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.items = @[].mutableCopy;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.loadingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.loadingButton addTarget:self action:@selector(loadNextSetOfImagesWithSender:) forControlEvents:UIControlEventTouchUpInside];
        [self.loadingButton setFrame:CGRectMake(0, 0, 80, 80)];
        [self.loadingButton setTitle:@"😍" forState:UIControlStateNormal];
        
        self.currentPage = 1;
        self.isUpdating = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchedItem = @"Birthday";
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView registerClass:[EAPicturePreviewCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.loadingButton.layer setCornerRadius:(self.loadingButton.bounds.size.width / 2)];
    [self.loadingButton setClipsToBounds:YES];
    [self.loadingButton setBackgroundColor:[UIColor redColor]];
    
    // Initial loading
    [self fetchDataSourceForPage:self.currentPage];
    
    // Title
    self.title = self.searchedItem;
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.loadingButton];
    
    // Force update of constraints
    [self.view setNeedsUpdateConstraints];
}

- (void)fetchDataSourceForPage:(NSInteger)page {
    
    [SVProgressHUD showWithStatus:@"Updating pictures"];
    NSDictionary *params = @{@"tags":self.searchedItem, @"page":[NSNumber numberWithInteger:page]};
    
    [[ApiManager manager] fetchImagesFromApiService:API_ENPOINT_SELECT_FLICKR withMethod:METHOD_IMAGE_SEARCH withParams:params andCompletionBlock:^(BOOL success, NSError * _Nullable error, NSArray * _Nullable responseArray) {
        self.isUpdating = NO;
        [SVProgressHUD dismiss];
        if (success) {
            [self.items addObjectsFromArray:responseArray];
            
            self.dataSource = [[EACollectionViewDataSource alloc]initWithItems:self.items
                                                             forCellIdentifier:reuseIdentifier
                                                        withConfigurationBlock:^(EAPicturePreviewCollectionViewCell* cell, EAFlickrObject* flickrObject) {
                                                            cell.labelTitle.text = flickrObject.title;
                                                            [cell.imagePreview sd_setImageWithURL:[EAFlickrObject urlForFlickrObject:flickrObject
                                                                                                                     withPictureMode:EAFlickrPictureModeSquareLarge]];
                                                        }];
            
            [self.dataSource setRefreshMode:EADataSourceRefreshModeAuto];
            [self.collectionView setDataSource:self.dataSource];
            [self.collectionView setDelegate:self];
            
            [self.collectionView reloadData];
        } else {
            DLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
        }
        
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - CollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    EAPicturePreviewCollectionViewCell *cell = (EAPicturePreviewCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    EAPictureDetailViewController *pictureDetailViewController = [[EAPictureDetailViewController alloc]initWithEAModelObject:[self.items objectAtIndex:indexPath.row] andPreviewPicture:[cell.imagePreview.image copy]];
    [self.navigationController pushViewController:pictureDetailViewController animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    int autoRefreshOffset = 20;
    
    switch (self.dataSource.refreshMode) {
        case EADataSourceRefreshModeAuto: {
            if ((indexPath.row > (self.items.count - autoRefreshOffset)) && !self.isUpdating) {
                [self loadNextSetOfImagesWithSender:nil];
            }
        }
            break;
        case EADataSourceRefreshModeManual:
        default: {
            // Make a button appear
            if ((indexPath.row > (self.items.count - autoRefreshOffset)) && !self.isUpdating) {
                [self showLoadingButton];
            }
        }
            break;
    }
}

#pragma mark - UICollectionViewLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int divider = 3;
    return CGSizeMake(collectionView.bounds.size.width/divider, collectionView.bounds.size.width/divider);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


- (void)updateViewConstraints {
    
    // Autolayout
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.loadingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        make.rightMargin.equalTo(self.view);
        make.bottomMargin.equalTo(@-20);
    }];
    
    // Called always at the end
    [super updateViewConstraints];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y == scrollView.contentSize.height) {
        [self showLoadingButton];
    }
    DLog(@"%f",scrollView.contentOffset.y);
    
}

#pragma mark - Pagination

- (void)loadNextSetOfImagesWithSender:(id)sender {
    self.isUpdating = YES;
    self.currentPage++;
    [self fetchDataSourceForPage:self.currentPage];
    
    if ([sender isKindOfClass:[UIButton class]]) {
        [self hideLoadingButton];
    }
}

- (void)showLoadingButton {
    [UIView animateWithDuration:0.4 animations:^{
        [self.loadingButton setAlpha:1];
    }];
}

- (void)hideLoadingButton {
    [UIView animateWithDuration:0.4 animations:^{
        [self.loadingButton setAlpha:0];
    }];
}

@end
