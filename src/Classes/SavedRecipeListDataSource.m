//
//  SavedRecipeListDataSource.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SavedRecipeListDataSource.h"
#import "ArchivedRecipesListModel.h"
#import "Three20/Three20.h"
#import "Recipe.h"


@implementation SavedRecipeListDataSource

- (id)init {
	if (self = [super init]) {
		_dataModel = [[ArchivedRecipesListModel alloc] init];
	}
	return self;
}

- (NSString*)titleForLoading:(BOOL)reloading {
	if (reloading) {
		return @"Updating archive ...";
	} else {
		return @"Loading archive ...";
	}
}

- (NSString*)titleForEmpty {
	return @"Save recipes for offline use here.";
}


- (NSString*)subtitleForError:(NSError*)error {
	return @"There was some error loading content of your archive.";
}


//when model is loaded
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	for (id<Recipe> recipe in [_dataModel fetchedObjects]) {
		
		NSString *url = nil;
		NSString *caption = [NSString stringWithFormat:@"duration: %2.1f h, servings: %d",
							 [recipe.durationTime floatValue], [recipe.servings intValue]];
		
		TTTableMessageItem *item = [TTTableMessageItem itemWithTitle:recipe.title
															 caption:caption
																text:recipe.procedure
														   timestamp:recipe.dateAdded
																 URL:url];
		[items addObject:item];
	}
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

@end
