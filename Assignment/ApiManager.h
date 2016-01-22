//
//  ApiManager.h
//  Assignment
//
//  Created by Matteo Comisso on 08/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>
#import "Endpoints.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApiManager : AFHTTPSessionManager

/**
 * gets singleton object.
 * @return singleton
 */
+ (ApiManager*)manager;

/**
 *  Calls the baseUrl with search tag parameter, returning an async completionBlock
 *
 *  @param tag             The searched parameter
 *  @param completionBlock The async completion block
 */
-(void)fetchImagesFromApiService:(NSString*)service withMethod:(NSString*)method withParams:(NSDictionary * _Nullable)params andCompletionBlock:(void (^)(BOOL, NSError * _Nullable, NSArray * _Nullable))completionBlock;

@end

NS_ASSUME_NONNULL_END