//
//  EAFlickrEndpoint.m
//  Assignment
//
//  Created by mcomisso on 14/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//
//  Discussion
//  This is a util-class that configures the requests for these particular model objects (EAFlickrObject).
//
//  https://api.flickr.com/services
//  Il parametro OBBLIGATORIO method viene usato per specificare il metodo chiamato.
//  Il parametro OBBLIGATORIO api_key viene usato per specificare la tua Chiave API.
//  Il parametro facoltativo format viene usato per specificare un formato di risposta.
//

#import "EARequestParams.h"
#import "EAFlickrEndpoint.h"
#import <UAObfuscatedString/UAObfuscatedString.h>

// Methods list
#define IMAGE_SEARCH @"flickr.photos.search"
// Examples
#define OTHER_METHOD @"other.method"
#define ANOTHER_ONE  @"another.one"

@interface EAFlickrEndpoint()

@property (nonatomic, strong) NSMutableString *apiKey;
@property (nonatomic, strong) NSMutableString *apiSecret;

@end


@implementation EAFlickrEndpoint

static NSString *baseEndpoint = @"https://api.flickr.com/services/rest/?format=json&nojsoncallback=1";

- (instancetype)init {
    self = [super init];
    if (self) {
        
        // Keys obfuscation
        self.apiKey     = Obfuscate._1._1._8.b.a._8.e._5._0._4._1._6.e._8._1._1._4.d._6._1.e._9._8._0._5.e.c._5.d._7._0.e;
        self.apiSecret  = Obfuscate.d._0.c.e._0._1._8._5._9._9._1._1._7._6.d._7;
        
        // @{Constant.h: this file}
        self.methods = @{
                         METHOD_IMAGE_SEARCH: IMAGE_SEARCH,
                         METHOD_OTHER_METHOD: OTHER_METHOD,
                         METHOD_ANOTHER_ONE: ANOTHER_ONE
                         };
    }
    return self;
}

- (NSString *)baseUrl {
    return baseEndpoint;
}


- (EARequestParams *)requestParamsForMethod:(NSString *)method {
    NSDictionary *params = @{@"method": [self.methods objectForKey:method],
                             @"api_key": self.apiKey,
                             @"extras": @"url_k, description",
                             @"content_type": @1,
                             @"privacy_filter": @1};
    
    EARequestParams *requestParams = [[EARequestParams alloc] initWithParams:params andBaseUrl:baseEndpoint];
    return requestParams;
}


- (NSArray<EAApiEndpoint *> *)constructObjectsFromResponse:(id)responseObject {
    DLog(@"%@", [responseObject description]);
    
    NSMutableArray *photos = @[].mutableCopy;
    NSDictionary *photosDictionary = [responseObject objectForKey:@"photos"];
    
    for (NSDictionary *dict in [photosDictionary objectForKey:@"photo"]) {
        if ([[dict allKeys]containsObject:@"url_k"]) {
            EAFlickrObject *flickrObject = [[EAFlickrObject alloc] initWithDictionary:dict];
            [photos addObject:flickrObject];
        }
    }
    
    return photos;
}

@end
