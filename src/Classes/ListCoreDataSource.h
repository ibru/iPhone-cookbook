//
//  ListCoreDataSource.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"
#import "CoreDataListModel.h"

@interface ListCoreDataSource : TTListDataSource {
	CoreDataListModel *_dataModel;
	TTModelViewController *_viewController;
}

@property (nonatomic, retain) CoreDataListModel *coreDataModel;
@property (nonatomic, retain) TTModelViewController *modelViewController;

/**
 * Asks model whether it has any data which can be deleted. Basicaly whether in fetchedViewControler
 * are any fetched objects
 */
- (BOOL)isAnythingToDelete;

- (BOOL)deleteAllObjects;

- (NSUInteger)numberOfObjects;

@end
