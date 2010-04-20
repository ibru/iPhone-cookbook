//
//  SearchFormViewController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SearchFormViewController.h"
#import "SearchFormDataSource.h"


@implementation SearchFormViewController

@synthesize titleStr = _titleStr;
@synthesize ingredientsStr = _ingredients;


- (id)init {
	if (self = [super init]) {
		self.title = @"Search";
		
		self.tableViewStyle = UITableViewStyleGrouped;
		self.autoresizesForKeyboard = YES;
		self.variableHeightRows = YES;
		self.tableView.separatorColor = TTSTYLEVAR(tableSeparatorColor);
		
		self.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1] autorelease];
		
		_titleField = [[UITextField alloc] init];
		_titleField.placeholder = @"title";
		_titleField.font = TTSTYLEVAR(font);
		_titleField.delegate = self;
		
		_ingredientsField = [[UITextField alloc] init];
		_ingredientsField.placeholder = @"ingredients";
		_ingredientsField.font = TTSTYLEVAR(font);
		_ingredientsField.delegate = self;
		
		TTTableButton *submitButton = [TTTableButton itemWithText:@"Search" URL:nil];
		
		self.dataSource = [SearchFormDataSource dataSourceWithObjects:
						   @"",
						   _titleField,
						   @"",
						   _ingredientsField,
						   @"",
						   submitButton,
						   nil];
	}
	return self;
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	
	//chech if this is search button
	if (indexPath.section == 2 && indexPath.row == 0) {
		if ([_titleStr length] == 0 && [_ingredients length] == 0) {
			TTAlert(@"You need to fill in at least one of the fields.");
			return;
		}
		
		NSArray *ingredients = [_ingredients componentsSeparatedByString:@","];
		
		TTURLAction *urlAction = [[[TTURLAction alloc] initWithURLPath:@"tt://searchResult"] autorelease];
		urlAction.query = [NSDictionary dictionaryWithObjectsAndKeys:_titleStr, @"title", ingredients, @"ingredients", nil];
		urlAction.animated = YES;
		[[TTNavigator navigator] openURLAction:urlAction];
	}
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	if ([textField isEqual:_titleField]) {
		self.titleStr = textField.text;
	}
	else if ([textField isEqual:_ingredientsField]) {
		self.ingredientsStr = textField.text;
	}
	
	[textField resignFirstResponder];
	
	return YES;
	
}

#pragma mark actions


#pragma mark dealloc

- (void)dealloc {
	TT_RELEASE_SAFELY(_titleStr);
	TT_RELEASE_SAFELY(_ingredients);
	TT_RELEASE_SAFELY(_titleField);
	TT_RELEASE_SAFELY(_ingredientsField);
	
	[super dealloc];
}

@end
