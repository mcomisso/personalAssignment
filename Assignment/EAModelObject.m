//
//  EAModelObject.m
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import "EAModelObject.h"

@implementation EAModelObject


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSLog(@"Method must be ovverridden in a subclass");
    assert(false);
}


- (NSDictionary *)toDictionary {
    NSLog(@"Method must be ovverridden in a subclass");
    assert(false);
}

@end
