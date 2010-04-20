//
//  Category.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Category.h"

@implementation Category

@synthesize title = _title;
@synthesize categoryId = _categoryId;
@synthesize parent = _parent;
@synthesize recipesNumber = _recipesNumber;
@synthesize order = _order;
@synthesize recipes = _recipes;

+ (id)categoryWithDictionary:(NSDictionary *)dictionary {
	return [[[self alloc] initWithDictionary:dictionary] autorelease];
}

- (id)initWithCategoryId:(NSString *)categoryId {
	if (self = [super init]) {
		self.categoryId = categoryId;
	}
	return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
	if (self = [super init]) {
		self.title = [dictionary objectForKey:@"title"];
		self.categoryId = [dictionary objectForKey:@"categoryId"];
		self.parent = [[[Category alloc] initWithCategoryId:[dictionary objectForKey:@"parent"]] autorelease];
		self.order = [NSNumber numberWithInt:[[dictionary objectForKey:@"order"] intValue]];
		self.recipesNumber = [NSNumber numberWithInt:[[dictionary objectForKey:@"recipeCount"] intValue]];
	}
	return self;
}

- (BOOL)isEqual:(id)anObject {
	if (anObject == nil) {
		return NO;
	}
	if (![[anObject class] isEqual:[self class]]) {
		return NO;
	}
	
	Category *other = (Category *)anObject;
	
	if (![self.categoryId isEqual:other.categoryId]) {
		return NO;
	}
	if (![self.order isEqual:other.order]) {
		return NO;
	}
	if (![self.parent isEqual:other.parent]) {
		return NO;
	}
	if (![self.recipesNumber isEqual:other.recipesNumber]) {
		return NO;
	}
	if (![self.title isEqual:other.title]) {
		return NO;
	}
	return YES;
}

- (BOOL)isEqualUsingCategoryId:(NSString *)categoryId {
	
	return [self.categoryId isEqualToString:categoryId];
}

- (NSUInteger)hash {
	NSUInteger hash = 7;
	hash = 59 * hash + (self.categoryId != nil ? [self.categoryId hash] : 0);
	hash = 59 * hash + (self.order != nil ? [self.order hash] : 0);
	hash = 59 * hash + (self.parent != nil ? [self.parent hash] : 0);
	hash = 59 * hash + (self.recipesNumber != nil ? [self.recipesNumber hash] : 0);
	hash = 59 * hash + (self.title != nil ? [self.title hash] : 0);
	return hash;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"Category instance : categoryId : '%@', title = '%@', parent = '%@', order = '%@', recipeNumber = '%@'",
			_categoryId, _title, _parent, [_order description], [_recipesNumber description]];
}

- (void) dealloc {
	[_title release];
	[_categoryId release];
	[_parent release];
	[_recipesNumber release];
	[_order release];
	[_recipes release];
	[super dealloc];
}


@end
