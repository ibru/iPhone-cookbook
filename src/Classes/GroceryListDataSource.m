//
//  GroceryListDataSource.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GroceryListDataSource.h"
#import "CDGroceryListIngredient.h"
#import "GroceryListModel.h"
#import "Config.h"


@implementation GroceryListDataSource


- (id)init {
	if (self = [super init]) {
		_dataModel = [[GroceryListModel alloc] init];
	}
	return self;
}

- (NSString*)titleForLoading:(BOOL)reloading {
	if (reloading) {
		return @"Updating grocery ...";
	} else {
		return @"Loading grocery ...";
	}
}


- (NSString*)titleForEmpty {
	return @"Add your grocery list items here.";
}


- (NSString*)subtitleForError:(NSError*)error {
	return @"There was some error loading grocery list.";
}

- (void)tableView:(UITableView*)tableView cell:(UITableViewCell*)cell
willAppearAtIndexPath:(NSIndexPath*)indexPath {
	
	CDGroceryListIngredient *ingredient = (CDGroceryListIngredient *)[_dataModel objectAtIndexPath:indexPath];
	if ([ingredient.checked boolValue])
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	else
		cell.accessoryType = UITableViewCellAccessoryNone;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	
	NSMutableArray *items = [[NSMutableArray alloc] init];
	for (CDGroceryListIngredient *ingredient in [_dataModel fetchedObjects]) {		
		TTTableTextItem *item = [TTTableTextItem itemWithText:ingredient.descr URL:@"tt://noActionUrl"];
		
		[items addObject:item];
	}
	self.items = items;
	[items release];	
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
	[super tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:kGroceryBadgeNotification object:nil];
}


@end
