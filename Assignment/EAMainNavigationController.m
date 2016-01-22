//
//  MainNavigationController.m
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import "EAMainNavigationController.h"

@implementation EAMainNavigationController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (void)sharedInit {
    self.navigationBar.tintColor = [UIColor blackColor];
    self.navigationBar.barTintColor = [UIColor yellowColor];
}

@end
