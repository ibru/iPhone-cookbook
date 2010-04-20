//
//  SavedRecipeDetailViewController.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@protocol Recipe;

@interface SavedRecipeDetailViewController : TTTableViewController <UIActionSheetDelegate> {
	id<Recipe> _recipe;

}

@end
