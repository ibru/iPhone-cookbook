//
//  GroceryListViewController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GroceryListViewController.h"
#import "GroceryListDataSource.h"
#import "GroceryListDelegate.h"
#import "CDGroceryListIngredient.h"
#import "GroceryListModel.h"
#import "Config.h"


@implementation GroceryListViewController

#pragma mark private methods

- (void) updateBadgeValueToNumber: (NSInteger)number {
	if (number > 0)
		self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", number];
	else
		self.tabBarItem.badgeValue = nil;
	
	//do nothing when number < 0. But this should not happen
}

- (void)updateBadgeValue:(NSNotification *)notification {
	NSUInteger number = [[(GroceryListModel *)self.coreDataSource.coreDataModel itemsToBuy] count];
	[self updateBadgeValueToNumber:number];
}

#pragma mark super methods


- (id)init {
	if (self = [super init]) {
		self.title = @"Grocery List";
		
		UIImage* image = [UIImage imageNamed:@"groceryIcon.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:2] autorelease];
		self.tableView.separatorColor = TTSTYLEVAR(tableSeparatorColor);
		
		[self setCoreDataSource:[[[GroceryListDataSource alloc] init] autorelease]];
		[self updateBadgeValue:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(updateBadgeValue:)
													 name:kGroceryBadgeNotification
												   object:nil];
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (id<UITableViewDelegate>)createDelegate {
	return [[[GroceryListDelegate alloc] initWithController:self] autorelease];
}

- (void)deleteContent {
	[super deleteContent];
	[self updateBadgeValue:nil];
}

#pragma mark public methods

- (void)incrementBadgeValueBy: (NSUInteger) number {
	NSUInteger currentNumber = 0;
	if (self.tabBarItem.badgeValue != nil) {
		currentNumber = [self.tabBarItem.badgeValue intValue];
	}
	[self updateBadgeValueToNumber:currentNumber + number];
}


- (void)decrementBadgeValueBy: (NSUInteger) number {
	NSUInteger currentNumber = 0;
	if (self.tabBarItem.badgeValue != nil) {
		currentNumber = [self.tabBarItem.badgeValue intValue];
	}
	[self updateBadgeValueToNumber:currentNumber - number];
}

#pragma mark dealloc

- (void)dealloc {
	[super dealloc];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:kGroceryBadgeNotification
												  object:nil];
}

@end
