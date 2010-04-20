//
//  CommentModels.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONDataModel.h"


@interface CommentListModel : JSONDataModel {
	NSArray *_comments;
	NSString *_recipeId;
}

@property (nonatomic, retain) NSArray *comments;

- (id)initWithRecipeId:(NSString *)recipeId;

@end
