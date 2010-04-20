//
//  Ingredient.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Ingredient.h"
#import "Recipe.h"


@implementation Ingredient

@synthesize ingredientId = _ingredientId;
@synthesize descr = _description;
@synthesize recipe = _recipe;


+ (id)ingredientWithDictionary:(NSDictionary *)dictionary {
	return [[[self alloc] initWithDictionary:dictionary] autorelease];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
	if (self = [super init]) {
		self.ingredientId = [dictionary objectForKey:@"ingredientId"];
		self.descr = [dictionary objectForKey:@"description"];
	}
	return self;
}

- (void)dealloc {
	[_ingredientId release];
	[_description release];
	[_recipe release];
	[super dealloc];
}
@end
