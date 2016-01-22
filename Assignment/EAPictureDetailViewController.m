//
//  EAPictureDetailViewController.m
//  Assignment
//
//  Created by Matteo Comisso on 13/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import "EAPictureDetailViewController.h"
#import "Utils.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface EAPictureDetailViewController() <UIScrollViewDelegate>

@property (nonatomic, strong) EAModelObject *displayedObject;
@property (nonatomic, strong) UIImageView *imagePicture;
@property (nonatomic, strong) UIImage *thumbPreview;
@property (nonatomic, strong) UIScrollView  *scrollviewContainer;

@property (nonatomic, strong) UIImage *preview;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation EAPictureDetailViewController

- (instancetype)initWithEAModelObject:(EAModelObject *)displayedObject andPreviewPicture:(UIImage *)picture {
    self = [super init];
    if (self) {
        self.displayedObject = displayedObject;
        self.scrollviewContainer = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.imagePicture = [[UIImageView alloc] init];
        self.titleLabel = [UILabel new];
        self.containerView = [UIView new];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set view
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.scrollviewContainer setDelegate:self];
    [self.scrollviewContainer setMinimumZoomScale:1];
    [self.scrollviewContainer setMaximumZoomScale:6.0];
    [self.scrollviewContainer setZoomScale:self.scrollviewContainer.minimumZoomScale];
    
    [self.imagePicture setContentMode:UIViewContentModeScaleAspectFill];
    
    // Container for title and details
    [self.titleLabel setText:self.displayedObject.title];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.7]];
    
    // Add subviews
    [self.scrollviewContainer addSubview:self.imagePicture];
    [self.view addSubview:self.scrollviewContainer];
    [self.view addSubview:self.containerView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestImageAtMaxQualityForDisplay];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)requestImageAtMaxQualityForDisplay {
    
    //    Improvement: determine screen size and fetch the Image with closest width/height to view bounds (Decrease memory usage, improves timing on fetching)
    //    CGSize size = [UIScreen mainScreen].bounds.size;
    //    CGFloat maxSide = (size.width > size.height) ? size.width : size.height;
    //    NSArray *availableDimensions = @[];
    //
    
    if ([self.displayedObject isKindOfClass:[EAFlickrObject class]]) {
        [SVProgressHUD show];
        [self.imagePicture sd_setImageWithURL:[EAFlickrObject urlForFlickrObject:(EAFlickrObject *)self.displayedObject
                                                                 withPictureMode:EAFlickrPictureMode2048Image]
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                        [SVProgressHUD dismiss];
                                        if (!error) {
                                            self.scrollviewContainer.contentSize = self.imagePicture.bounds.size;
                                            self.imagePicture.image = image;
                                        } else {
                                            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                                            DLog(@"%@ - %@", [error localizedDescription], [error localizedFailureReason]);
                                        }
                                        
                                    }];
    }
}

-(void)updateViewConstraints {
    
    [self.imagePicture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollviewContainer);
        make.right.equalTo(self.scrollviewContainer);
        make.bottom.equalTo(self.scrollviewContainer);
        make.top.equalTo(self.scrollviewContainer);
    }];
    
    [self.scrollviewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        CGFloat height = self.view.bounds.size.height / 6;
        make.height.equalTo([NSNumber numberWithFloat:height]);
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
    // Title label
    [self.titleLabel sizeToFit];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView);
        make.width.equalTo(self.containerView);
        make.left.equalTo(self.containerView);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Scrollview Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imagePicture;
}
@end
