//
//  EAPictureDetailViewController.h
//  Assignment
//
//  Created by Matteo Comisso on 13/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EAPictureDetailViewController : UIViewController

/**
 *  Inits the detail view controller by passing a EAModelObject and an initial picture. The picture is used to show a preview in low-quality while fetching an hi-res in background, substituting the image when completed.
 *
 *  @param modelObject The ModelObject representing the image that will be displayed.
 *  @param picture     The UIImage picture to show immediately
 *
 *  @return A new instance of EAPictureDetailViewController
 */
- (instancetype _Nullable)initWithEAModelObject:(EAModelObject *)modelObject andPreviewPicture:(UIImage * _Nullable)picture;

@end

NS_ASSUME_NONNULL_END