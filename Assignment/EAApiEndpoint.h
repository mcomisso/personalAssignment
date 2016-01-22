//
//  EAApiEndpoint.h
//  Assignment
//
//  Created by mcomisso on 14/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EARequestParams.h"

NS_ASSUME_NONNULL_BEGIN

@interface EAApiEndpoint : NSObject

/**
 *  API Methods for network calls
 */
@property (nonatomic, strong) NSDictionary *methods;

/**
 *  Request the base url of the endpoint
 *
 *  @return A string containing the base url for network requests
 */
- (NSString *)baseUrl;

/**
 *  Returns a Request Params object configured with the selected method
 *
 *  @param method The desired method (Listed in Constant.h)
 *
 *  @return Returns a EARequestParams object with Baseurl and Params,
 */
- (EARequestParams *)requestParamsForMethod:(NSString *)method;

/**
 *  Reads the response object and construct an array containing the model object elements.
 *
 *  @param responseObject The response object from a network request
 *
 *  @return A NSArray with a list of model objects
 */
- (NSArray<EAApiEndpoint *> *)constructObjectsFromResponse:(id)responseObject;

@end

NS_ASSUME_NONNULL_END