//
//  EAPicturePreview.h
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAPicturePreviewCollectionViewCell : UICollectionViewCell

/**
 *  Thumbnail for image
 */
@property (nonatomic, strong) UIImageView *imagePreview;

/**
 *  Title for current cell object
 */
@property (nonatomic, strong) UILabel *labelTitle;

@end
