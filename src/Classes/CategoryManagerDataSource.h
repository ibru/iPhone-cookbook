/*
 *  CategoryManagerDataSource.h
 *  Kucharka
 *
 *  Created by Jiri Urbasek on 2/26/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

@class CategoryModel;

@protocol CategoryManagerDataSource<NSObject>

- (NSArray *)categoryModel:(CategoryModel *)categoryModel subcategoriesForCategoryId: (NSString *)categoryId;

- (NSArray *)categoryModelCategoriesForRoot:(CategoryModel *)categoryModel;

//- (NSArray *)categoryModel:(CategoryModel *)categoryModel recipesForCategoryId: (NSString *)categoryId;

- (BOOL)categoryModel:(CategoryModel *)categoryModel hasSubcategoriesForCategoryId: (NSString *)categoryId;

- (BOOL)categoryModel:(CategoryModel *)categoryModel hasRecipesForCategoryId: (NSString *)categoryId;

//- (NSDictionary *)categoryModel:(CategoryModel *)categoryModel categoryInfoForCategoryId: (NSString *)categoryId;

@end
