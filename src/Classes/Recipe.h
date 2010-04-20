//
//  Recipe.h
//  TTTableViewTesting
//
//  Created by Jiri Urbasek on 2/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Ingredient;
@protocol Category;
@protocol User;
@protocol Comment;


@protocol Recipe<NSObject>

@property (nonatomic, retain) NSString * procedure;
@property (nonatomic, retain) NSNumber * durationTime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSNumber * servings;
@property (nonatomic, retain) NSSet<Comment> * comments;
@property (nonatomic, retain) id<Category> category;
@property (nonatomic, retain) NSSet<Ingredient> *ingredients;
@property (nonatomic, retain) id<User> user;

@end

// ---------------------------------------------

@interface Recipe : NSObject <Recipe> {
	NSString *_recipeId;
	NSString *_userId;
	
	NSString *_title;
	NSString *_description;
	NSString *_procedure;
	NSNumber *_servings;
	NSNumber *_durationTime;
	NSDate *_dateAdded;
	NSSet<Ingredient> *_ingredients;
	NSSet<Comment> *_comments;
	id<Category> _category;
	id<User> _user;
	
	NSString *_imageUrl;
	NSString *_imageCaption;
}

@property (nonatomic, retain) NSString *recipeId;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *imageCaption;


//saves recipe into archive for online use. Archive uses core data as its strorage
+ (BOOL)saveRecipeToArchive:(id<Recipe>)recipe;


+ (id)reicpeWithDictionary:(NSDictionary *)dictionary;

//separates only basic info from dictionary, which is usefull for list of recipes, where we do not need
//information about comments, ingredients etc. and creates new instance only with this basic info
- (id)initWithDictionary:(NSDictionary *)dictionary;

//cretes instance with all possible information including comments, ingredients etc. It is usefull for recipe
//detail where we want to display all details about recipe
- (id)initWithDictionary:(NSDictionary *)dictionary allDetails:(BOOL)allDetails;

@end
