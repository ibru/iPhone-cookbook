//
//  SavedRecipesListViewController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SavedRecipesListViewController.h"
#import "SavedRecipeListDataSource.h"
#import "Recipe.h"

@implementation SavedRecipesListViewController

- (id)init {
	if (self = [super init]) {
		self.title = @"My recipes";
		
		UIImage* image = [UIImage imageNamed:@"archiveIcon.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:3] autorelease];
		
		self.tableView.separatorColor = TTSTYLEVAR(tableSeparatorColor);
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	//[self reload];
	[self refresh];
}


- (void)createModel {
	[self setCoreDataSource:[[[SavedRecipeListDataSource alloc] init] autorelease]];
	
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	
	id<Recipe> recipe = (id<Recipe>)[self.coreDataSource.coreDataModel objectAtIndexPath:indexPath];
									 
	TTURLAction *urlAction = [[[TTURLAction alloc] initWithURLPath:@"tt://savedRecipeDetail"] autorelease];
	urlAction.query = [NSDictionary dictionaryWithObject:recipe forKey:@"recipe"];
	urlAction.animated = YES;
	[[TTNavigator navigator] openURLAction:urlAction];
}

#pragma mark dealloc

- (void) dealloc {
	[super dealloc];
}

@end
