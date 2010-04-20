//
//  RecipeDetailDataSource.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeDetailDataSource.h"
#import "RecipeModels.h"
#import "Recipe.h"
#import "Ingredient.h"
#import "GroceryList.h"

#import "Config.h"



@implementation RecipeDetailDataSource


- (id)initWithRecipeId:(NSString *)recipeId {
	if (self = [super init]) {
		_recipeId = [recipeId retain];
		_dataModel = [[RecipeDetailModel alloc] initWithRecipeId:recipeId];
	}
	return self;
}

- (id<TTModel>)model {
	return _dataModel;
}

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
	
	
	Recipe *recipe = _dataModel.recipe;
	NSString *info = [NSString stringWithFormat:@"duration time: %2.1f h, servings: %d",
					  [recipe.durationTime floatValue], [recipe.servings intValue]];
	NSString *remoteImageSmall = [NSString stringWithFormat:[kDomainUrl stringByAppendingString:kImageResizeFormatJSON], 57, 57, recipe.imageUrl];
	NSString *remoteImageFullSize = [NSString stringWithFormat:[kDomainUrl stringByAppendingString:kImageResizeFormatJSON], 0, 0, recipe.imageUrl];
	
	NSMutableArray *headerItems = [[NSMutableArray alloc] initWithObjects:
								   //[TTTableTextItem itemWithText:recipe.title],
								   [TTTableImageItem itemWithText:recipe.title imageURL:remoteImageSmall URL:remoteImageFullSize],
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
	TT_RELEASE_SAFELY(_dataModel);
	TT_RELEASE_SAFELY(_recipeId);
	
	[super dealloc];
}

@end
