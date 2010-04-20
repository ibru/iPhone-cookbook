//
//  ArchivedRecipesListModel.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Three20/Three20.h"
#import "CoreDataListModel.h"
#import "RecipeModels.h"



@interface ArchivedRecipesListModel : CoreDataListModel<RecipeListModel> {
	NSArray *_recipes;
}

@end
