//
//  SaverRecipeDetailDataSource.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SavedRecipeDetailDataSource.h"
#import "Ingredient.h"


@implementation SavedRecipeDetailDataSource

- (NSString*)titleForLoading:(BOOL)reloading {
	if (reloading) {
		return @"Updating recipe detail ...";
	} else {
		return @"Loading recipe detail ...";
	}
}


- (NSString*)titleForEmpty {
	return @"No such recipe found.";
}


- (NSString*)subtitleForError:(NSError*)error {
	return @"There was some error loading recipe. Please check your internet connection.";
}


//when model is loaded
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	
	Recipe *recipe = _recipe;
	NSString *info = [NSString stringWithFormat:@"duration time: %2.1f h, servings: %d",
					  [recipe.durationTime floatValue], [recipe.servings intValue]];
	
	NSMutableArray *headerItems = [[NSMutableArray alloc] initWithObjects:
								   [TTTableTextItem itemWithText:recipe.title],
								   [TTTableGrayTextItem itemWithText:info],
								   nil];
	
	NSMutableArray *ingredientsItems = [[NSMutableArray alloc] init];
	for (Ingredient *ingredient in recipe.ingredients) {
		[ingredientsItems addObject:[TTTableTextItem itemWithText:ingredient.descr]];
	}
	
	TTTableLongTextItem *descriptionItem = [TTTableLongTextItem itemWithText:recipe.procedure];
	TTTableTextItem *commentsItem = [TTTableTextItem itemWithText:@"Comments"
															  URL:[NSString stringWithFormat:@"tt://comments/%@",
																   recipe.recipeId]];
	
	self.sections = [NSArray arrayWithObjects:@"", @"Ingredients", @"Description", @"Comments", nil];
	self.items = [NSArray arrayWithObjects: headerItems,
				  ingredientsItems,
				  [NSArray arrayWithObject:descriptionItem],
				  [NSArray arrayWithObject:commentsItem],
				  nil];
	
	TT_RELEASE_SAFELY(ingredientsItems);
}

#pragma mark dealloc

- (void)dealloc {
	TT_RELEASE_SAFELY(_recipe);
	
	[super dealloc];
}


@end
