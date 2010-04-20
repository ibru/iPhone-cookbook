//
//  Ingredient.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Recipe;


@protocol Ingredient<NSObject>

@property (nonatomic, retain) NSString *descr;
@property (nonatomic, retain) id<Recipe> recipe;

@end

// ---------------------------------------------

@interface Ingredient : NSObject<Ingredient> {
	NSString *_ingredientId;
	NSString *_description;
	id<Recipe> _recipe;
}

@property (nonatomic, retain) NSString *ingredientId;
@property (nonatomic, retain) NSString *descr;

+ (id)ingredientWithDictionary:(NSDictionary *)dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
