//
//  MyTableViewDataSource.m
//  TTTableViewTesting
//
//  Created by Jiri Urbasek on 2/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeListDataSource.h"
#import "Recipe.h"
#import "RecipeModels.h"
#import "ArchivedRecipesListModel.h"
#import "Config.h"


@implementation RecipeListDataSource


- (id)initWithCategoryId:(NSString *)categoryId {
	if (self = [super init]) {
		_dataModel = [[RecipeListModel alloc] initWithCategoryId:categoryId];
	}
	return self;
}

- (id<TTModel>)model {
	return _dataModel;
}

- (id<RecipeListModel>)dataModel {
	return _dataModel;
}


- (NSString*)titleForLoading:(BOOL)reloading {
	if (reloading) {
		return @"Updating recipes ...";
	} else {
		return @"Loading recipes ...";
	}
}


- (NSString*)titleForEmpty {
	return @"No recipes found.";
}


- (NSString*)subtitleForError:(NSError*)error {
	return @"There was some error loading recipes. Please check your internet connection.";
}


//when model is loaded
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	for (Recipe *recipe in [_dataModel recipes]) {
		
		NSString *remoteImage = [NSString stringWithFormat:[kDomainUrl stringByAppendingString:kImageResizeFormatJSON], 57, 57, recipe.imageUrl];
		NSString *url = [NSString stringWithFormat:@"tt://recipeDetail/%@", recipe.recipeId];
		NSString *caption = [NSString stringWithFormat:@"duration: %2.1f h, servings: %d",
							 [recipe.durationTime floatValue], [recipe.servings intValue]];
		
		TTTableMessageItem *item = [TTTableMessageItem itemWithTitle:recipe.title
															 caption:caption
																text:recipe.procedure
														   timestamp:recipe.dateAdded
															   imageURL:remoteImage
																 URL:url];
		[items addObject:item];
	}
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

#pragma mark dealloc

- (void)dealloc {
	TT_RELEASE_SAFELY(_dataModel);
	
	[super dealloc];
}

@end
