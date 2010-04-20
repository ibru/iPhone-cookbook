//
//  GroceryListModel.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Three20/Three20.h"
#import "CoreDataListModel.h"


@interface GroceryListModel : CoreDataListModel {
}

/**
 * returns all items needed to buy. These are items, which have not been checked yet.
 */
- (NSArray *)itemsToBuy;

@end
