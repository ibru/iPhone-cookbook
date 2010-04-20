//
//  GroceryListViewDelegate.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GroceryListDelegate.h"
#import "GroceryListViewController.h"
#import "GroceryListDataSource.h"
#import "CDGroceryListIngredient.h"
#import "GroceryListModel.h"
#import "Config.h"


@implementation GroceryListDelegate


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	
	GroceryListModel *model = (GroceryListModel *)self.controller.dataSource.model;
	CDGroceryListIngredient *ingredient = [model.fetchedResultsController objectAtIndexPath:indexPath];
	
	if ([ingredient.checked boolValue]) {
		ingredient.checked = [NSNumber numberWithBool:NO];
		[(GroceryListViewController *)self.controller incrementBadgeValueBy:1];
	} else {
		ingredient.checked = [NSNumber numberWithBool:YES];
		[(GroceryListViewController *)self.controller decrementBadgeValueBy:1];
	}

	[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
