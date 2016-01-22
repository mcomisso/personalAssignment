//
//  EAFlickrObject+Utils.m
//  Assignment
//
//  Created by Matteo Comisso on 12/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import "EAFlickrObject+Utils.h"

/*
 // https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
 */

@implementation EAFlickrObject (Utils)

NSString *stringWithEAFlickrPictureMode(EAFlickrPictureMode input) {
    NSArray *arr = @[
                     @"_s", // s	quadratino 75 x 75
                     @"_q", // q	large square 150x150
                     @"_t", // t miniatura, 100 sul lato più lungo
                     @"_m", // m	piccolo, 240 sul lato più lungo
                     @"_n", // n small, 320 on longest side
                     @"", // -	medio, 500 sul lato più lungo
                     @"_z", // z	medio 640, 640 sul lato più lungo
                     @"_c", // c	medio 800, 800 sul lato più lungo†
                     @"_b", // b	grande, 1024 sul lato più lungo*
                     @"_n", // h	grandi 1600, 1600 nel lato più lungo†
                     @"_k", // k	grandi 2048, 2048 nel lato più lungo†
                     @"_o" //  o	immagine originale jpg, gif o png, in base al formato di origine
                     ];
    return (NSString *)[arr objectAtIndex:input];
}

/*
 https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
 */


+ (NSURL *)urlForFlickrObject:(EAFlickrObject *)flickObject withPictureMode:(EAFlickrPictureMode)pictureMode {
    
    if (pictureMode == EAFlickrPictureModeOriginal) {
        NSURL *url = [NSURL URLWithString:flickObject.urlOriginal];
        return url;
    } else if (pictureMode == EAFlickrPictureMode2048Image) {
        NSURL *url = [NSURL URLWithString:flickObject.url2048Image];
        return url;
    } else {
        NSString *photoUrlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@%@.jpg", flickObject.farm, flickObject.server, flickObject.identifier, flickObject.secret, stringWithEAFlickrPictureMode(pictureMode)];
        NSURL *url = [NSURL URLWithString:photoUrlString];
        return url;
    }
}

@end
