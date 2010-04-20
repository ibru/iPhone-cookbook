//
//  JSONCategoryModel.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONDataModel.h"
#import "Three20/Three20.h"
#import "CategoryManagerDataSource.h"

typedef enum {
	CategoryModelTypeJSON,
	CategoryModelTypeXML
} CategoryModelType;

// -------------------------------------------------------------

@interface CategoryModel : JSONDataModel {
	NSArray *_categories;		//array of Category instances
	NSString *_categoryId;
}

@property (nonatomic, retain) NSArray *categories;
@property (nonatomic, retain) NSString *categoryId;

+ (id)categoryModelWithCategoryId:(NSString *)categoryId type:(CategoryModelType)type;
+ (id<CategoryManagerDataSource>)categoryManagerForType:(CategoryModelType)type;

@end


// ---------------------------------------------------------------

//singleton instance which downloads json of all categories and then it can display
//proper hieararchy using CategoryManagerDataSource protocol
@interface JSONCategoryModel : CategoryModel <CategoryManagerDataSource> {
}

+ (JSONCategoryModel *)sharedInstance;

@end

