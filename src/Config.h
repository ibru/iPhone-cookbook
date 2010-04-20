//
//  Config.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kDomainUrl @"http://devel.urbasek.cz/cookbook"
#define kCategoriesPathJSON @"/json/category/default/"
#define kRecipeListPathFormatJOSN @"/json/category/recipes/%@"
#define kRecipeDetailPathFormatJSON @"/json/recipe/default/%@"
#define kRecipeSearchPathFormatJSON @"/json/search/recipe/%@"
#define kCommentListPathFormatJSON @"/json/recipe/comments/%@"
#define kImageResizeFormatJSON @"/json/image/resize/?x=%d&y=%d&file=%@"

#define kGroceryBadgeNotification @"GrocerBadgeNotification"