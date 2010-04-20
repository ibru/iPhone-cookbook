//
//  RecipeDetailViewController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "RecipeDetailDataSource.h"
#import "RecipeModels.h"
#import "GroceryList.h"
#import "Recipe.h"


@implementation RecipeDetailViewController


- (id)initWithRecipeId:(NSString *)recipeId {
	if (self = [self init]) {
		_recipeId = [recipeId retain];
		self.variableHeightRows = YES;
		self.tableViewStyle = UITableViewStyleGrouped;
		self.tableView.separatorColor = TTSTYLEVAR(tableSeparatorColor);
	}
	return self;
}

- (void)createModel {
	self.dataSource = [[[RecipeDetailDataSource alloc] initWithRecipeId:_recipeId] autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
																			   target:self
																			   action:@selector(addButtonClicked:)];
	self.navigationItem.rightBarButtonItem = addButton;
	[addButton release];
	
	UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"Recipe"
																style:UIBarButtonItemStyleDone 
															   target:nil
															   action:nil];
	self.navigationItem.backBarButtonItem = backBar;
	[backBar release];
}

#pragma mark UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	RecipeDetailModel *model = (RecipeDetailModel *)self.dataSource.model;
	
	if (buttonIndex == 0) {		
		if (![GroceryList addIngredientsToList:model.recipe.ingredients])
			TTAlert(@"Ouch. There was an error adding ingredients. Sorry for that...");
	}
	else if (buttonIndex == 1) {
		if (![Recipe saveRecipeToArchive:model.recipe])
			TTAlert(@"Ouch. There was an error saving recipe. Sorry for that...");
	}
}

#pragma mark actions

- (void)addButtonClicked:(id)sender {
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose your action"
															 delegate:self cancelButtonTitle:@"Cancel"
											   destructiveButtonTitle:nil
													otherButtonTitles:@"Add to grocery", @"Save recipe", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	//[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	[actionSheet showFromToolbar:self.navigationController.toolbar];
	[actionSheet release];
	
}

#pragma mark dealloc

- (void)dealloc {
	TT_RELEASE_SAFELY(_recipeId);	
    [super dealloc];
}

@end
