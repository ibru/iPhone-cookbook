//
//  JSONCategoryModel.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CategoryModels.h"
#import "Three20/Three20.h"
#import "JSON.h"
#import "Category.h"
#import "Config.h"


@implementation CategoryModel

@synthesize categories = _categories;
@synthesize categoryId = _categoryId;

+ (id)categoryModelWithCategoryId:(NSString *)categoryId type:(CategoryModelType)type {
	
	switch (type) {
		case CategoryModelTypeJSON :
			;
			JSONCategoryModel *instance = [JSONCategoryModel sharedInstance];
			instance.categoryId = categoryId;
			return instance;
			break;
		case CategoryModelTypeXML:
			return nil;
			break;
	}
	return nil;
}

+ (id<CategoryManagerDataSource>)categoryManagerForType:(CategoryModelType)type {
	switch (type) {
		case CategoryModelTypeJSON:
			return [JSONCategoryModel sharedInstance];
			break;
		case CategoryModelTypeXML:
			return nil;
			break;
	}
	return nil;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_categories);
	TT_RELEASE_SAFELY(_categoryId);
	[super dealloc];
}

@end

#pragma mark -
// ------------------------------------------------------------------------------------
// JSONCategoryModel

static JSONCategoryModel *instance = nil;

@implementation JSONCategoryModel


#pragma mark singleton related methods

+ (JSONCategoryModel *)sharedInstance {
	
	if (!instance) {
		instance = [[super allocWithZone:NULL] init];
	}
	return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedInstance] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

#pragma mark private methods

- (BOOL)needsReload {
	if ([_categoryId isEqualToString:@"init"])
		return YES;

	return NO;
}

#pragma mark public methods

/*
//load url request
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	
	//if ([self needsReload]) {
		[super load:cachePolicy more:more];
	//}
}
 */

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	
	[super requestDidFinishLoad:request];
	
	TTDASSERT(nil != _jsonString);
	
	NSArray *categoriesData = [_jsonString JSONValue];
	
	TT_RELEASE_SAFELY(_categories);
	NSMutableArray *categories = [[NSMutableArray alloc] init];
	
	for (NSDictionary *categoryData in categoriesData) {
		[categories addObject:[[[Category alloc] initWithDictionary:categoryData] autorelease]];
	}
	self.categories = categories;
	TT_RELEASE_SAFELY(categories);
}

#pragma mark JSONDataModel methods


- (NSString *)sourceUrlFormat {
	return [kDomainUrl stringByAppendingString:kCategoriesPathJSON];
	//return kCategoriesJSONURL;
}

- (NSString *)sourceUrlFormatVariable {
	return _categoryId;
}

#pragma mark CategoryManagerDataSource methods

//returns array of Category instances which are subcategories of category with id categoryId
- (NSArray *)categoryModel:(CategoryModel *)categoryModel subcategoriesForCategoryId: (NSString *)categoryId {
	
	if (categoryModel.categories == nil) {
		return nil;
		//or throw an exception
	}
	NSMutableArray *results = [NSMutableArray array];
	
	for (Category *category in categoryModel.categories) {
		if ([(Category *)category.parent isEqualUsingCategoryId:categoryId])
			[results addObject:category];
	}
	return results;
}

//returns array of Category instances which have not parents = its parent property has value 0
- (NSArray *)categoryModelCategoriesForRoot:(CategoryModel *)categoryModel {
	
	return [self categoryModel:categoryModel subcategoriesForCategoryId:@"0"];
}

//- (NSArray *)categoryModel:(CategoryModel *)categoryModel recipesForCategoryId: (NSString *)categoryId {	return nil;}

- (BOOL)categoryModel:(CategoryModel *)categoryModel hasSubcategoriesForCategoryId: (NSString *)categoryId {
	return [[self categoryModel:categoryModel subcategoriesForCategoryId:categoryId] count] > 0;
}

- (BOOL)categoryModel:(CategoryModel *)categoryModel hasRecipesForCategoryId: (NSString *)categoryId {
	
	if (categoryModel.categories == nil) {
		return NO;
		//or throw an exception
	}
	
	for (Category *category in categoryModel.categories) {
		if ([category.categoryId isEqualToString:categoryId])
			return [category.recipesNumber intValue] > 0;
	}
	//category not found? something is really wrong... throw exception?
	return NO;
}


@end
