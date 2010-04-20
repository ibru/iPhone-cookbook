//
//  CategoryListDataSource.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CategoryListDataSource.h"
#import "CategoryModels.h"
#import "Category.h"
#import "CategoryTableItem.h"
#import "CategoryTableViewCell.h"


@implementation CategoryListDataSource

- (id)initWithCategoryId:(NSString *)categoryId {
	if (self = [super init]) {
		_categoryId = [categoryId retain];
		_dataModel = [CategoryModel categoryModelWithCategoryId:_categoryId type:CategoryModelTypeJSON];
		_categoryManager = [CategoryModel categoryManagerForType:CategoryModelTypeJSON];
	}
	return self;
}

- (id<TTModel>)model {
	return _dataModel;
}

- (NSString*)titleForLoading:(BOOL)reloading {
	if (reloading) {
		return @"Updating categories ...";
	} else {
		return @"Loading categories ...";
	}
}

- (NSString*)titleForEmpty {
	return @"No categories found.";
}


- (NSString*)subtitleForError:(NSError*)error {
	return @"There was some error while loading categories. Please check your internet connection.";
}


//when model is loaded
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	
	NSArray *categoriesToDisplay = nil;
	
	if ([_categoryId isEqualToString:@"init"]) {
		categoriesToDisplay = [_categoryManager categoryModelCategoriesForRoot:_dataModel];
	}
	else if ([_categoryManager categoryModel:_dataModel hasSubcategoriesForCategoryId:_categoryId]) {
		categoriesToDisplay = [_categoryManager categoryModel:_dataModel subcategoriesForCategoryId:_categoryId];
	}
	
	if (categoriesToDisplay == nil)
		return;	//no categories found
	
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	for (Category *category in categoriesToDisplay) {
		// distinguish correct URL for all category items
		NSString *caption = @"empty";
		NSString *url = nil;
		
		
		if ([_categoryManager categoryModel:_dataModel hasRecipesForCategoryId:category.categoryId]) {
			//it has recipes, next view will be recipe list for category id
			caption = [NSString stringWithFormat:@"%d recipes", [category.recipesNumber intValue]];
			url = [NSString stringWithFormat:@"tt://recipes/%@", category.categoryId];
		}
		else if ([_categoryManager categoryModel:_dataModel hasSubcategoriesForCategoryId:category.categoryId]) {
			//it has subcategories, next view will be the same with new parent category id
			caption = nil;
			url = [NSString stringWithFormat:@"tt://category/%@", category.categoryId];
		}
		
		CategoryTableItem *item = [CategoryTableItem itemWithText:category.title
																	  caption:caption
																		  URL:url];
		[items addObject:item];
	}
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}


///////////////////////////////////////////////////////////////////////////////////////////////////  
// TTTableViewDataSource  

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object {   
	
    if ([object isKindOfClass:[CategoryTableItem class]]) {  
        return [CategoryTableViewCell class];  
    } else {  
        return [super tableView:tableView cellClassForObject:object];  
    }  
} 

#pragma mark -
#pragma mark dealloc

- (void)dealloc {
	TT_RELEASE_SAFELY(_dataModel);
	TT_RELEASE_SAFELY(_categoryId);
	[super dealloc];
}

@end
