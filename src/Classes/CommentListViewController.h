//
//  CommentListViewController.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"


@interface CommentListViewController : TTTableViewController {
	NSString *_recipeId;
}

@property (nonatomic, retain) NSString *recipeId;

- (id)initWithRecipeId:(NSString *)recipeId;

@end
