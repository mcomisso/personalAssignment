//
//  ApiManager.m
//  Assignment
//
//  Created by Matteo Comisso on 08/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import "ApiManager.h"
#import "EAModel.h"
#import "Utils.h"

#import <AFNetworking/AFNetworking.h>

@interface ApiManager()

@property (nonatomic, strong) NSMutableDictionary<NSString*, EAApiEndpoint*> *endpoints;

@end

@implementation ApiManager

static ApiManager *SINGLETON = nil;
static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
        SINGLETON.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self manager];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self manager];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self manager];
}

- (id)copy
{
    return [[ApiManager alloc] init];
}

- (id)mutableCopy
{
    return [[ApiManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (id) initWithBaseURL:(NSURL *)url
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super initWithBaseURL:url];
    if (self) {
        // We use Obfuscate macro to hide critical strings in compiled binary
        [self sharedInit];
    }
    return self;
}

- (void)sharedInit {
    self.endpoints = @{}.mutableCopy;
    [self.endpoints setObject:[[EAFlickrEndpoint alloc]init] forKey:API_ENPOINT_SELECT_FLICKR];
}


#pragma mark - Api Calls

//TODO: AUTH method (if requirement of other api)

/**
 *  Request images from service
 *
 *  @param service         The service
 *  @param method          The interrogated method
 *  @param params          Additional parameters for request
 *  @param completionBlock The completionBlock
 */
-(void)fetchImagesFromApiService:(NSString*)service withMethod:(NSString*)method withParams:(NSDictionary * _Nullable)params andCompletionBlock:(void (^)(BOOL, NSError * _Nullable, NSArray * _Nullable))completionBlock {
    
    EAApiEndpoint *apiEndpoint = [self.endpoints objectForKey:service] ?: nil;
    
    if ([apiEndpoint respondsToSelector:@selector(requestParamsForMethod:)]) {
        EARequestParams *requestParams = [apiEndpoint performSelector:@selector(requestParamsForMethod:) withObject:method];
        
        NSMutableDictionary *fullParams = @{}.mutableCopy;
        [fullParams setValuesForKeysWithDictionary:requestParams.params];
        [fullParams setValuesForKeysWithDictionary:params];
        
        [self GET:requestParams.baseUrl parameters:fullParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([apiEndpoint respondsToSelector:@selector(constructObjectsFromResponse:)]) {
                NSArray *listResponse = [apiEndpoint performSelector:@selector(constructObjectsFromResponse:) withObject:responseObject];
                completionBlock(YES, nil, listResponse);
            } else {
                // Not implemented
                NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:9000 userInfo:@{@"message":@"Not implemented"}];
                completionBlock(NO, error, nil);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            DLog(@"Error: %@ - %@", [error localizedDescription], [error localizedFailureReason]);
            completionBlock(NO, error, nil);
        }];
    }
}


@end
