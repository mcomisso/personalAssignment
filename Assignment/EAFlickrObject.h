//
//  EAFlickrObject.h
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//
//  Discussion:
//  This is the base class for Flickr objects.
//  Not core-related functionalities must be included in +Utils ObjC Category.
//

#import "EAModelObject.h"

@interface EAFlickrObject : EAModelObject

@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSString *farm;
@property (nonatomic, strong, readonly) NSString *owner;
@property (nonatomic, strong, readonly) NSString *secret;
@property (nonatomic, strong, readonly) NSString *server;

@property (nonatomic, strong, readonly) NSString *urlOriginal;
@property (nonatomic, strong, readonly) NSString *url2048Image;

@property BOOL isFamily;
@property BOOL isFriend;
@property BOOL isPublic;


@end
