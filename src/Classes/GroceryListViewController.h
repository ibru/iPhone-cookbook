//
//  GroceryListViewController.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"
#import "CoreDataListViewController.h"


@interface GroceryListViewController : CoreDataListViewController {

}

- (void)incrementBadgeValueBy: (NSUInteger) number;
- (void)decrementBadgeValueBy: (NSUInteger) number;

@end
