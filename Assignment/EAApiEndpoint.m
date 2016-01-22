//
//  EAApiEndpoint.m
//  Assignment
//
//  Created by mcomisso on 14/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import "EAApiEndpoint.h"

@implementation EAApiEndpoint

- (NSString *)baseUrl {
    NSLog(@"Method must be ovverridden in a subclass");
    assert(false);
}

- (EARequestParams *)requestParamsForMethod:(NSString *)method {
    NSLog(@"Method must be ovverridden in a subclass");
    assert(false);    
}

- (NSArray<EAApiEndpoint *> *)constructObjectsFromResponse:(id)responseObject {
    NSLog(@"Method must be ovverridden in a subclass");
    assert(false);
}

@end
