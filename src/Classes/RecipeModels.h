//
//  HTTPDataModel.h
//  TTTableViewTesting
//
//  Created by Jiri Urbasek on 2/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONDataModel.h"
#import "Three20/Three20.h"

@protocol Recipe;


@protocol RecipeListModel <TTModel>

@property (nonatomic, readonly) NSArray<Recipe> *recipes;

@end

// -------------------------------------------------------------

@interface RecipeListModel : JSONDataModel <RecipeListModel> {
	NSArray *_recipes;			//array of Recipe instances
	NSString *_categoryId;
}

//@property (nonatomic, retain) NSArray *recipes;

- (id)initWithCategoryId:(NSString *)categoryId;

@end

// -------------------------------------------------------------

@interface SearchedRecipeListModel : RecipeListModel {
	NSString *_title;
	NSArray *_ingredients;
}

- (id)initWithTitle:(NSString *)title ingredients:(NSArray *)ingredients;

@end


// -------------------------------------------------------------
#pragma mark -

@class Recipe;

@interface RecipeDetailModel : JSONDataModel {
	NSString *_recipeId;
	Recipe *_recipe;
}

@property (nonatomic, retain) Recipe *recipe;

- (id)initWithRecipeId:(NSString *)recipeId;

@end

