//
//  EAFlickrObject+Utils.h
//  Assignment
//
//  Created by Matteo Comisso on 12/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//
//  Discussion
//  Complete here EAFlickrObject class by extending the core model with functionalities.
//

#import "EAFlickrObject.h"

// Definition for picture mode (used when calculated dinamically)
typedef enum {
    EAFlickrPictureModeSquareSmall = 0,
    EAFlickrPictureModeSquareLarge,
    EAFlickrPictureModeThumbnail,
    EAFlickrPictureMode240Image,
    EAFlickrPictureMode320Image,
    EAFlickrPictureModeNone,
    EAFlickrPictureMode640Image,
    EAFlickrPictureMode800Image,
    EAFlickrPictureMode1024Image,
    EAFlickrPictureMode1600Image,
    EAFlickrPictureMode2048Image,
    EAFlickrPictureModeOriginal
    
} EAFlickrPictureMode;

NS_ASSUME_NONNULL_BEGIN

@interface EAFlickrObject (Utils)

/**
 *  Builds the NSURL for a certain Flickr Object by selecting the EAFlickrPictureMode(picture quality).
 *
 *  @param flickObject The flickr object
 *  @param pictureMode The selected picture mode.
 *
 *  @return A dynamically built NSURL
 */
+ (NSURL *)urlForFlickrObject:(EAFlickrObject *)flickObject withPictureMode:(EAFlickrPictureMode)pictureMode;

@end

NS_ASSUME_NONNULL_END