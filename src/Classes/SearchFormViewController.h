//
//  SearchFormViewController.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"


@interface SearchFormViewController : TTTableViewController <UITextFieldDelegate> {
	NSString *_titleStr;
	NSString *_ingredients;
	UITextField *_titleField;
	UITextField *_ingredientsField;
}

@property (nonatomic, retain) NSString *titleStr;
@property (nonatomic, retain) NSString *ingredientsStr;

@end
