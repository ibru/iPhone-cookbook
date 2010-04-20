//
//  SavedRecipeDetailViewController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SavedRecipeDetailViewController.h"
#import "Recipe.h"
#import "Ingredient.h"
#import "GroceryList.h"


@implementation SavedRecipeDetailViewController

- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query { 
	if (self = [super init]){ 
		if(query && [query objectForKey:@"recipe"]){ 
			_recipe = (id<Recipe>)[[query objectForKey:@"recipe"] retain];
		} else {
			_recipe = nil;
		}

		self.variableHeightRows = YES;
		self.tableViewStyle = UITableViewStyleGrouped;
		self.tableView.separatorColor = TTSTYLEVAR(tableSeparatorColor);
	} 
	return self; 
}

- (void)createModel {
	
	NSMutableArray *sections = [NSMutableArray array];
	NSMutableArray *items = [NSMutableArray array];
	
	NSString *info = [NSString stringWithFormat:@"duration time: %2.1f h, servings: %d",
					  [_recipe.durationTime floatValue], [_recipe.servings intValue]];
	
	NSMutableArray *headerItems = [[NSMutableArray alloc] initWithObjects:
								   [TTTableTextItem itemWithText:_recipe.title],
								   [TTTableGrayTextItem itemWithText:info],
								   nil];
	
	NSMutableArray *ingredientsItems = [[NSMutableArray alloc] init];
	for (id<Ingredient> ingredient in _recipe.ingredients) {
		[ingredientsItems addObject:[TTTableTextItem itemWithText:ingredient.descr]];
	}
	
	TTTableLongTextItem *descriptionItem = [TTTableLongTextItem itemWithText:_recipe.procedure];

	//Note: comments are not displayed in saved recipe detail
	sections = [NSArray arrayWithObjects:@"", @"Ingredients", @"Description",  nil];
	items = [NSArray arrayWithObjects: headerItems,
				  ingredientsItems,
				  [NSArray arrayWithObject:descriptionItem],
				  nil];
	
	self.dataSource = [TTSectionedDataSource dataSourceWithItems:items sections:sections];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = @"";
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
																			   target:self
																			   action:@selector(addButtonClicked:)];
	self.navigationItem.rightBarButtonItem = addButton;
	[addButton release];
}

#pragma mark UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {		
		if (![GroceryList addIngredientsToList:_recipe.ingredients])
			TTAlert(@"Ouch. There was an error adding ingredients. Sorry for that.");
	}
}

#pragma mark actions

- (void)addButtonClicked:(id)sender {
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose your action"
															 delegate:self cancelButtonTitle:@"Cancel"
											   destructiveButtonTitle:nil
													otherButtonTitles:@"Add to grocery", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	//[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	[actionSheet showFromToolbar:self.navigationController.toolbar];
	[actionSheet release];
	
}

#pragma mark dealloc

- (void)dealloc {
	TT_RELEASE_SAFELY(_recipe);
	[super dealloc];
}

@end
