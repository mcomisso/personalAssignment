//
//  EACollectionViewDataSource.h
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EACompletionBlocks.h"

/**
 Refresh mode for collection view. Auto is equal to "autorefresh mode".
 */
typedef enum {
    EADataSourceRefreshModeAuto = 0,
    EADataSourceRefreshModeManual
} EADataSourceRefreshMode;

NS_ASSUME_NONNULL_BEGIN

@interface EACollectionViewDataSource : NSObject <UICollectionViewDataSource>

/**
 *  Array of items that will be displayed
 */
@property (nonatomic, strong) NSArray *items;

/**
 *  Cell identifier for collectionView
 */
@property (nonatomic, strong) NSString *cellIdentifier;

/**
 *  Block containing the configuration of the cells for items
 */
@property (nonatomic, copy) configureCell configureCellWithBlock;

/**
 *  Refresh mode desired
 */
@property EADataSourceRefreshMode refreshMode;


-(instancetype)init __attribute__((unavailable("init not available, call initWithItems:forCellIdentifier:withConfigurationBlock")));

/**
 *  Performs configuration of cells with block
 *
 *  @param items              The UITableView datasource items to be displayed
 *  @param cellIdentifier     The unique cell identifier for the UITableView
 *  @param configurationBlock The configuration block called by each cell
 *
 *  @return A new
 */
-(instancetype)initWithItems:(NSArray *)items forCellIdentifier:(NSString *)cellIdentifier withConfigurationBlock:(void (^)(id cell, id item))configurationBlock;

@end

NS_ASSUME_NONNULL_END