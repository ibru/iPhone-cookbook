//
//  CommentListDataSource.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommentListDataSource.h"
#import "CommentModels.h"
#import "Comment.h"

@implementation CommentListDataSource

- (id)initWithRecipeId:(NSString *)recipeId {
	if (self = [super init]) {
		_dataModel = [[CommentListModel alloc] initWithRecipeId:recipeId];
	}
	return self;
}

- (id<TTModel>)model {
	return _dataModel;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_dataModel);
	
	[super dealloc];
}

- (NSString*)titleForLoading:(BOOL)reloading {
	if (reloading) {
		return @"Updating comments ...";
	} else {
		return @"Loading comments ...";
	}
}


- (NSString*)titleForEmpty {
	return @"No comments found.";
}


- (NSString*)subtitleForError:(NSError*)error {
	return @"There was some error loading comments. Please check your internet connection.";
}


//when model is loaded
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	for (Comment  *comment in [_dataModel comments]) {
		
		NSString *name = (comment.usersFullName != nil) ? comment.usersFullName : comment.usersLogin;
		
		TTTableMessageItem *item = [TTTableMessageItem itemWithTitle:name
															 caption:nil
																text:comment.text
														   timestamp:comment.onDate
																 URL:nil];
		[items addObject:item];
		name = @"";
	}
	
	// no comments?
	//if (![items count])
	//	[items addObject:[TTTableSummaryItem itemWithText:@"Recipe has no comments"]];
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}


@end
