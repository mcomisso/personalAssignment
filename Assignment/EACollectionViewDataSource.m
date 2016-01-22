//
//  EACollectionViewDataSource.m
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import "EACollectionViewDataSource.h"

@implementation EACollectionViewDataSource

-(instancetype)initWithCellIdentifier:(NSString *)cellIdentifier withConfigurationBlock:(void (^)(id cell, id item))configurationBlock {
    if (self = [super init]) {
        self.configureCellWithBlock = configurationBlock;
        self.cellIdentifier = cellIdentifier;
    }
    return self;
}

-(instancetype)initWithItems:(NSArray *)items forCellIdentifier:(NSString *)cellIdentifier withConfigurationBlock:(void (^)(id cell, id item))configurationBlock{
    self = [super init];
    if (self) {
        self.configureCellWithBlock = configurationBlock;
        self.cellIdentifier = cellIdentifier;
        self.items = items;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self.items objectAtIndex:indexPath.row];
    
    self.configureCellWithBlock(cell, item);
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

@end
