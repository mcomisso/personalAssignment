//
//  EARequestParams.m
//  Assignment
//
//  Created by mcomisso on 14/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//
//  This class contains the shared structure for a request made by ApiManager.
//
//

#import "EARequestParams.h"

@interface EARequestParams()

@property (nonatomic, readwrite) NSDictionary *params;
@property (nonatomic, readwrite) NSString *baseUrl;

@end

@implementation EARequestParams


-(instancetype)initWithParams:(NSDictionary *)params andBaseUrl:(NSString *)baseUrl {
    self = [super init];
    if (self) {
        self.params = params;
        self.baseUrl = baseUrl;
    }
    return self;
}

@end
