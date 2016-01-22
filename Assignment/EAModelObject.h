//
//  EAModelObject.h
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//
//  Discussion:
//  This is the base Class for the object model. If other services are implemented, subclass EAModelObject and implement these methods.
//  
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EAModelObject : NSObject

@property (nonatomic, nullable) NSString *title;
@property (nonatomic, nullable) NSString *desc;

/**
 *  Initialize a new object from the key values of a dictionary.
 *
 *  @param dictionary The dictionary containing parameters
 *
 *  @return An instance of EAModelObject
 */
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

/**
 *  Returns a new dictionary from all the class parameters
 *
 *  @return A NSDictionary containing the value of all
 */
- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END