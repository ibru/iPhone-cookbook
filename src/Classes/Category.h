//
//  Category.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"


@protocol Category<NSObject>

@property (nonatomic, retain) NSNumber *recipesNumber;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSSet<Recipe> *recipes;
@property (nonatomic, retain) id<Category> parent;


@end

// -------------------------------------------

@interface Category : NSObject<Category> {
	NSString *_categoryId;
	
	NSString *_title;
	Category *_parent;
	NSNumber *_recipesNumber;
	NSNumber *_order;
	NSSet<Recipe> *_recipes;
}

@property (nonatomic, copy) NSString *categoryId;


+ (id)categoryWithDictionary:(NSDictionary *)dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (BOOL)isEqualUsingCategoryId:(NSString *)categoryId;


@end
