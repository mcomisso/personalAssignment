//
//  EAPictureCollectionView.h
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//
//  Discussion
//  This is the first visible view controller of the application.
//  Will show the preview for all the pictures, by fetching them calling the ApiManager and passing a block to configure each cell.
//  This will keep an abstract implementation right in this controller, allowing the ApiManager to choose the correct endpoint.
//

#import "EAViewController.h"

@interface EAPictureCollectionView : EAViewController <UICollectionViewDelegate>

@end
