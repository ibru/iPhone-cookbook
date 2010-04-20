//
//  RecipeDetailDataSource.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@class RecipeDetailModel;

@interface RecipeDetailDataSource : TTSectionedDataSource {
	RecipeDetailModel *_dataModel;
	NSString *_recipeId;

}

- (id)initWithRecipeId:(NSString *)recipeId;

@end
