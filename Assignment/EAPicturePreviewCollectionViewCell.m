//
//  EAPicturePreview.m
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import "EAPicturePreviewCollectionViewCell.h"
#import "UIView+MCUtils.h"
#import <Masonry/Masonry.h>

@implementation EAPicturePreviewCollectionViewCell

/*
 @property (nonatomic, strong) UILabel *labelTitle;
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // Base init
        self.imagePreview = [UIImageView new];
        self.labelTitle = [UILabel new];
        
        // Set imagePicture
        [self.imagePreview setContentMode:UIViewContentModeScaleAspectFill];
        [self.imagePreview setClipsToBounds:YES];
        
        // Set labels
        [self.labelTitle setNumberOfLines:1];
        [self.labelTitle setMinimumScaleFactor:0.5];
        [self.labelTitle setTextColor:[UIColor whiteColor]];
        [self.labelTitle setFont:[UIFont boldSystemFontOfSize:10]];
        [self.labelTitle setTextAlignment:NSTextAlignmentRight];
        [self.labelTitle setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.4]];

        // Set content
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.imagePreview];
        [self.contentView addSubview:self.labelTitle];
        
        // Layout
        [self.imagePreview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.contentView);
        }];
        
        [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
    }
    
    return self;
}


- (void)prepareForReuse {
    self.imagePreview.image = nil;
    self.labelTitle.text = @"";

    [super prepareForReuse];
}

@end
