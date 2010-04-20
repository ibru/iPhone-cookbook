//
//  MyTableViewDataSource.h
//  TTTableViewTesting
//
//  Created by Jiri Urbasek on 2/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@class RecipeListModel;
@protocol RecipeListModel;


@interface RecipeListDataSource : TTListDataSource {
	id<RecipeListModel> _dataModel;
}

//inits data source with model fetching recipe list for particular category identified by its categoryId
- (id)initWithCategoryId:(NSString *)categoryId;

@end
