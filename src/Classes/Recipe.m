//
//  Recipe.m
//  TTTableViewTesting
//
//  Created by Jiri Urbasek on 2/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Recipe.h"
#import "Three20/Three20.h"
#import "AppDelegate.h"

#import "Ingredient.h"
#import "Comment.h"
#import "User.h"
#import "Category.h"

#import "CDRecipe.h"
#import "CDComment.h"
#import "CDCategory.h"
#import "CDIngredient.h"


@implementation Recipe

@synthesize recipeId = _recipeId;
@synthesize userId = _userId;
@synthesize title = _title;
@synthesize descr = _description;
@synthesize procedure = _procedure;
@synthesize servings = _servings;
@synthesize durationTime = _durationTime;
@synthesize dateAdded = _dateAdded;
@synthesize ingredients = _ingredients;
@synthesize comments = _comments;
@synthesize category = _category;
@synthesize user = _user;
@synthesize imageUrl = _imageUrl;
@synthesize imageCaption = _imageCaption;


+ (BOOL)saveRecipeToArchive:(id<Recipe>)recipe {
	NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
	
	CDRecipe *savedRecipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe"
														  inManagedObjectContext:managedObjectContext];
	
	//save ingredients
	for (id<Ingredient> ingredient in recipe.ingredients) {
		CDIngredient *savedIngredient = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient"
																			   inManagedObjectContext:managedObjectContext];
		savedIngredient.descr = ingredient.descr;
		savedIngredient.recipe = savedRecipe;
		
		//add to recipe
		[savedRecipe addIngredientsObject:savedIngredient];
	}
	
	//save comments
	for (id<Comment> comment in recipe.comments) {
		CDComment *savedComment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment"
																inManagedObjectContext:managedObjectContext];
		savedComment.onDate = comment.onDate;
		savedComment.recipe = savedRecipe;
		savedComment.text = comment.text;
		//TODO search for user and use or create new if not exits
		//savedComment.user = nil;
		
		//add to recipe
		[savedRecipe addCommentsObject:savedComment];
	}
	//TODO search for category and use it or create new, if not exists
	//savedRecipe.category = nil;
	
	savedRecipe.dateAdded = recipe.dateAdded;
	//savedRecipe.descr = recipe.descr;			//deprecated
	savedRecipe.durationTime = recipe.durationTime;
	savedRecipe.procedure = recipe.procedure;
	savedRecipe.servings = recipe.servings;
	savedRecipe.title = recipe.title;
	
	//TODO search for user and use or create new if not exits
	//savedRecipe.user = nil;
	
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
		NSLog(@"Unable to save recipe for ofline use. Error: %@", [error description]);
		return NO;
	}
	//successfully saved
	return YES;
}

+ (id)reicpeWithDictionary:(NSDictionary *)dictionary {
	return [[[self alloc] initWithDictionary:dictionary] autorelease];
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
	return [self initWithDictionary:dictionary allDetails:NO];
}

- (id)initWithDictionary:(NSDictionary *)dictionary allDetails:(BOOL)allDetails {
	if (self = [super init]) {
		self.recipeId = [dictionary objectForKey:@"recipeId"];
		self.title = [dictionary objectForKey:@"title"];
		self.descr = [dictionary objectForKey:@"description"];
		self.procedure = [dictionary objectForKey:@"procedure"];
		self.servings = [NSNumber numberWithInt:[[dictionary objectForKey:@"servings"] intValue]];
		self.durationTime = [NSNumber numberWithFloat:[[dictionary objectForKey:@"duration"] floatValue]];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
		self.dateAdded = [formatter dateFromString:[dictionary objectForKey:@"dateAdded"]];
		[formatter release];
		
		self.imageUrl = [dictionary objectForKey:@"picturePath"];
		
		if (allDetails) {
			//probably this will be depricated, because I will initialize ingredients and comments externaly
		}
	}
	return self;
}

#pragma mark dealloc

- (void)dealloc {
	TT_RELEASE_SAFELY(_recipeId);
	TT_RELEASE_SAFELY(_userId);
	TT_RELEASE_SAFELY(_title);
	TT_RELEASE_SAFELY(_description);
	TT_RELEASE_SAFELY(_procedure);
	TT_RELEASE_SAFELY(_servings);
	TT_RELEASE_SAFELY(_durationTime);
	TT_RELEASE_SAFELY(_dateAdded);
	TT_RELEASE_SAFELY(_ingredients);
	TT_RELEASE_SAFELY(_comments);
	TT_RELEASE_SAFELY(_category);
	TT_RELEASE_SAFELY(_user);
	TT_RELEASE_SAFELY(_imageUrl);
	TT_RELEASE_SAFELY(_imageCaption);
	[super dealloc];
}

@end
