//
//  SearchedRecipeListViewController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SearchedRecipeListViewController.h"
#import "SearchedRecipeListDataSource.h"


@implementation SearchedRecipeListViewController

- (id)initWithTitle:(NSString *)title ingredients:(NSArray *)ingredients {
	if (self = [super init]) {
		self.dataSource = [[SearchedRecipeListDataSource alloc] initWithTitle:title ingredients:ingredients];
		self.variableHeightRows = YES;
		self.title = @"Search result";
		self.tableView.separatorColor = TTSTYLEVAR(tableSeparatorColor);
	}
	return self;
}


- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
	TTDINFO(@"%@", [query description]);
	return [self initWithTitle:[query objectForKey:@"title"] ingredients:[query objectForKey:@"ingredients"]];
}

- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end
