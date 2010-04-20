//
//  CategoryListDataSource.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"
#import "CategoryManagerDataSource.h"

@class CategoryModel;

@interface CategoryListDataSource : TTListDataSource {
	CategoryModel *_dataModel;
	NSString *_categoryId;
	id<CategoryManagerDataSource> _categoryManager;
}

@end

