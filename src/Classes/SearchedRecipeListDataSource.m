//
//  SearchedRecipeListDataSource.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SearchedRecipeListDataSource.h"
#import "RecipeModels.h"


@implementation SearchedRecipeListDataSource

- (id)initWithTitle:(NSString *)title ingredients:(NSArray *)ingredients {
	if (self = [super init]) {
		_dataModel = [[SearchedRecipeListModel alloc] initWithTitle:title ingredients:ingredients];
	}
	return self;
}

@end
