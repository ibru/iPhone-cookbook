//
//  RecipeListViewController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeListViewController.h"
#import "RecipeListDataSource.h"

@implementation RecipeListViewController

- (id) init {
	if (self = [super init]) {
		self.title = @"Recipe list";
		self.variableHeightRows = YES;
		_recipeId = [[NSString alloc] init];
		
		self.tableView.separatorColor = TTSTYLEVAR(tableSeparatorColor);
	}
	return self;
}

- (id)initWithCategoryId:(NSString *)recipeId {
	if (self = [self init]) {
		_recipeId = [recipeId retain];
	}
	return self;
}

- (void)createModel {
	self.dataSource = [[[RecipeListDataSource alloc] initWithCategoryId:_recipeId] autorelease];
}

- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

- (void) dealloc {
	TT_RELEASE_SAFELY(_recipeId);
	[super dealloc];
}

@end
