//
//  RecipeDetailViewController.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"


@interface RecipeDetailViewController : TTTableViewController <UIActionSheetDelegate> {
	NSString *_recipeId;

}

- (id)initWithRecipeId:(NSString *)recipeId;

@end
