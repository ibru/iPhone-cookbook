//
//  HTTPDataModel.m
//  TTTableViewTesting
//
//  Created by Jiri Urbasek on 2/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeModels.h"
#import "JSON.h"
#import "Recipe.h"
#import "Ingredient.h"
#import "Comment.h"

#import "Config.h"

//static NSString *kRecipeSearchUrlFormat = @"http://localhost/dev/scripts/post.php%@";


@implementation RecipeListModel

@synthesize recipes = _recipes;

- (id)initWithCategoryId:(NSString *)categoryId {
	if (self = [super init]) {
		_categoryId = [categoryId retain];
	}
	return self;
}


#pragma mark public methods

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	
	[super requestDidFinishLoad:request];

	TTDASSERT(nil != _jsonString);
	TTDINFO(@"%@",_jsonString);
	NSArray *recipesDicts = [_jsonString JSONValue];
	
	TT_RELEASE_SAFELY(_recipes);
	NSMutableArray *recipes = [[NSMutableArray alloc] init];
	
	for (NSDictionary *singleRecipeDict in recipesDicts) {
			
		[recipes addObject:[[[Recipe alloc] initWithDictionary:singleRecipeDict] autorelease]];
	}
	_recipes = recipes;
}

#pragma mark JSONDataModel methods

- (NSString *)sourceUrlFormat {
	//return kRecipeListUrlFormat;
	return [kDomainUrl stringByAppendingString:kRecipeListPathFormatJOSN];
}

- (NSString *)sourceUrlFormatVariable {
	return _categoryId;
}

#pragma mark dealloc

- (void) dealloc {
	TT_RELEASE_SAFELY(_recipes);
	TT_RELEASE_SAFELY(_categoryId);
	[super dealloc];
}

@end

// ---------------------------------------------------------------------------
#pragma mark -

#define	TITLE_VARIABLE			@"title"
#define	INGREDIENTS_VARIABLE	@"ingredients"
#define	SUBMIT_VARIABLE			@"submit"

@implementation SearchedRecipeListModel

- (id)initWithTitle:(NSString *)title ingredients:(NSArray *)ingredients {
	if (self = [super init]) {
		_ingredients = [ingredients retain];
		_title = [title retain];
	}
	return self;
}

#pragma mark TTURLRequest methods

/*
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading) {
		NSString* url = [NSString stringWithFormat:[self sourceUrlFormat], [self sourceUrlFormatVariable]];
		
		TTURLRequest* request = [TTURLRequest requestWithURL:url delegate:self];
		NSString *body = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",
						  TITLE_VARIABLE, _title,
						  INGREDIENTS_VARIABLE, [_ingredients componentsJoinedByString:@","],
						  SUBMIT_VARIABLE, @"Search"];
		
		NSData *requestData = [[NSData alloc] initWithBytes:[body UTF8String] length:[body length]];
		request.httpBody = requestData;
		[requestData release];
		request.httpMethod = @"POST";
		request.cachePolicy = cachePolicy;
		//request.cacheExpirationAge = TT_DEFAULT_CACHE_INVALIDATION_AGE;
		
		id<TTURLResponse> response = [[TTURLDataResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		[request send];
	}
}
*/
#pragma mark JSONDataModel methods

- (NSString *)sourceUrlFormat {
	//return kRecipeSearchUrlFormat;
	return [kDomainUrl stringByAppendingString:kRecipeSearchPathFormatJSON];
}

- (NSString *)sourceUrlFormatVariable {
	
	NSString *title = [NSString string];
	NSString *ingredients = [NSString string];
	
	if (_title != nil)
		title = _title;
	
	if (_ingredients != nil && [_ingredients count])
		ingredients = [_ingredients componentsJoinedByString:@","];
	
	NSString *ret = [NSString stringWithFormat:@"?%@=%@&%@=%@&%@=%@",
					 TITLE_VARIABLE, [title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
					 INGREDIENTS_VARIABLE, [ingredients stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
					 SUBMIT_VARIABLE, @"Search"];
	
	return ret;
}

#pragma mark dealloc

- (void) dealloc {
	TT_RELEASE_SAFELY(_title);
	TT_RELEASE_SAFELY(_ingredients);
	[super dealloc];
}

@end

// ---------------------------------------------------------------------------
#pragma mark -

@implementation RecipeDetailModel

@synthesize recipe = _recipe;


- (id)initWithRecipeId:(NSString *)recipeId {
	if (self = [super init]) {
		_recipeId = [recipeId retain];
	}
	return self;
}

#pragma mark public methods

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	
	[super requestDidFinishLoad:request];
	
	TTDASSERT(nil != _jsonString);
	
	NSArray *recipeInfo = [_jsonString JSONValue];
	
	TTDASSERT([recipeInfo isKindOfClass:[NSArray class]]);
	TTDASSERT([recipeInfo count] == 3);
	
	TT_RELEASE_SAFELY(_recipe);
	Recipe *recipe = [[Recipe alloc] initWithDictionary:[recipeInfo objectAtIndex:0]];
	
	NSMutableSet<Ingredient> *ingredients = [[NSMutableSet alloc] init];
	NSMutableSet<Comment> *comments = [[NSMutableSet alloc] init];
	
	for (NSDictionary *ingredientsInfo in (NSArray *)[recipeInfo objectAtIndex:1]) {
		[ingredients addObject:[Ingredient ingredientWithDictionary:ingredientsInfo]];
	}
	//for (NSDictionary *ingredientsInfo in (NSArray *)[recipeInfo objectAtIndex:2]) {
	//	[comments addObject:[Comment commentWithDictionary:ingredientsInfo]];
	//}
	NSDictionary *pictureDict = [recipeInfo objectAtIndex:2];
	
	//in case when recipe has no picture, this will be NSNull (not nil!)
	if ([pictureDict class] != [NSNull class]) {
		recipe.imageUrl = [pictureDict objectForKey:@"fileName"];
		recipe.imageCaption = [pictureDict objectForKey:@"caption"];
	}
	
	recipe.ingredients = ingredients;
	//recipe.comments = comments;
	
	
	_recipe = recipe;
	
	TT_RELEASE_SAFELY(ingredients);
	TT_RELEASE_SAFELY(comments);
}

#pragma mark JSONDataModel methods

- (NSString *)sourceUrlFormat {
	//return kRecipeDetailUrlFormat;
	return [kDomainUrl stringByAppendingString:kRecipeDetailPathFormatJSON];
}

- (NSString *)sourceUrlFormatVariable {
	return _recipeId;
}

#pragma mark dealloc

- (void) dealloc {
	TT_RELEASE_SAFELY(_recipe);
	TT_RELEASE_SAFELY(_recipeId);
	[super dealloc];
}

@end

