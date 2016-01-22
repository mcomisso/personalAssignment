//
//  EAFlickrObject.m
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import "EAFlickrObject.h"


@interface EAFlickrObject()

@property (nonatomic, strong, readwrite) NSString *identifier;
@property (nonatomic, strong, readwrite) NSString *farm;
@property (nonatomic, strong, readwrite) NSString *owner;
@property (nonatomic, strong, readwrite) NSString *secret;
@property (nonatomic, strong, readwrite) NSString *server;

@property (nonatomic, strong, readwrite) NSString *urlOriginal;
@property (nonatomic, strong, readwrite) NSString *url2048Image;

@end


@implementation EAFlickrObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.identifier = [dictionary objectForKey:@"id"]   ?: @"";
        
        self.farm   = [dictionary objectForKey:@"farm"]     ?: @"";
        self.secret = [dictionary objectForKey:@"secret"]   ?: @"";
        self.server = [dictionary objectForKey:@"server"]   ?: @"";
        self.title  = [dictionary objectForKey:@"title"]    ?: @"";
        self.owner  = [dictionary objectForKey:@"owner"]    ?: @"";
        self.urlOriginal = [dictionary objectForKey:@"url_o"] ?: @"";
        self.url2048Image = [dictionary objectForKey:@"url_k"] ?: @"";
        
        self.isFamily = [[dictionary objectForKey:@"isfamily"] boolValue];
        self.isPublic = [[dictionary objectForKey:@"ispublic"] boolValue];
        self.isFriend = [[dictionary objectForKey:@"isfriend"] boolValue];
        
    }
    return self;
}

- (NSDictionary *)toDictionary {
    return @{@"id": self.identifier,
             @"farm": self.farm,
             @"secret": self.secret,
             @"server": self.server,
             @"title": self.title,
             @"owner": self.owner,
             @"isPublic": [NSNumber numberWithBool:self.isPublic],
             @"isFamily": [NSNumber numberWithBool:self.isFamily],
             @"isFriend": [NSNumber numberWithBool:self.isFriend]};
}

@end
