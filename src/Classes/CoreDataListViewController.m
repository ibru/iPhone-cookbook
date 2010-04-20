//
//  CoreDataListViewController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CoreDataListViewController.h"
#import "ListCoreDataSource.h"


@implementation CoreDataListViewController

- (id)init {
	if (self = [super init]) {
		UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
																				   target:self
																				   action:@selector(clearButtonClicked)];
		self.navigationItem.leftBarButtonItem = clearItem;
		[clearItem release];
		
		self.navigationItem.rightBarButtonItem = self.editButtonItem;
		self.variableHeightRows = YES;
	}
	return self;
}

- (void)refresh {
	[super refresh];
	
	if ([self.coreDataSource isAnythingToDelete]) {
		self.navigationItem.leftBarButtonItem.enabled = YES;
		self.navigationItem.rightBarButtonItem.enabled = YES;
	}
	else {
		self.navigationItem.leftBarButtonItem.enabled = NO;
		self.navigationItem.rightBarButtonItem.enabled = NO;
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self refresh];
}


- (ListCoreDataSource *)coreDataSource {
	return (ListCoreDataSource *)self.dataSource;
}

- (void)setCoreDataSource:(ListCoreDataSource *)dataSource {
	dataSource.modelViewController = self;
	self.dataSource = (TTTableViewDataSource *)dataSource;
}

#pragma mark actions

- (void)deleteContent {
	if (![self.coreDataSource deleteAllObjects])
		TTAlert(@"Uh. something went wrong during emptying grocery list. Sorry for that...");
	
	[self refresh];
}

- (void)clearButtonClicked {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirm"
														message:@"Are you sure to delete everything?"
													   delegate:self
											  cancelButtonTitle:@"Cancel"
											  otherButtonTitles:@"Delete", nil];
	[alertView show];
	[alertView release];
}


#pragma mark UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 1) {
		[self deleteContent];
	}
}


@end
