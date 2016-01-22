//
//  EARequestParams.h
//  Assignment
//
//  Created by mcomisso on 14/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EARequestParams : NSObject

@property (nonatomic, readonly) NSDictionary *params;
@property (nonatomic, readonly) NSString *baseUrl;

-(instancetype)initWithParams:(NSDictionary *)params andBaseUrl:(NSString *)baseUrl;

@end

NS_ASSUME_NONNULL_END