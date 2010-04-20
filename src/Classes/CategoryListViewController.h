//
//  CategoryListController.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"


@interface CategoryListViewController : TTTableViewController {
	NSString *_categoryId;
}

@property (nonatomic, copy) NSString *categoryId;

@end
