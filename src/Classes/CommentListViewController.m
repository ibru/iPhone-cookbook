//
//  CommentListViewController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommentListViewController.h"
#import "CommentListDataSource.h"


@implementation CommentListViewController

@synthesize recipeId = _recipeId;


- (id)initWithRecipeId:(NSString *)recipeId {
	if (self = [super init]) {
		TTDASSERT(nil != recipeId);
		self.recipeId = recipeId;
		self.title = @"Comments";
		self.variableHeightRows = YES;
		self.tableView.separatorColor = TTSTYLEVAR(tableSeparatorColor);
	}
	return self;
}

- (void)createModel {
	self.dataSource = [[[CommentListDataSource alloc] initWithRecipeId:_recipeId] autorelease];
}

- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

#pragma mark dealloc

- (void)dealloc {
	TT_RELEASE_SAFELY(_recipeId);
	[super dealloc];
}

@end
