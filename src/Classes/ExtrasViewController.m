//
//  ExtrasViewController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExtrasViewController.h"


@implementation ExtrasViewController

- (id)init {
	if (self = [super init]) {
		self.title = @"Extras";
		
		UIImage* image = [UIImage imageNamed:@"extrasIcon.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:4] autorelease];
	}
	return self;
}

- (void)loadView {
	[super loadView];
	
	_launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
	_launcherView.delegate = self;
	_launcherView.columnCount = 4;
	_launcherView.pages = [NSArray arrayWithObjects:
						   [NSArray arrayWithObjects:
							[[[TTLauncherItem alloc] initWithTitle:@"Unit convert"
															 image:@"bundle://convert.png"
															   URL:@"tt://unitConverter" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Timer"
															 image:@"bundle://timer.png"
															   URL:@"tt://timer" canDelete:NO] autorelease],
							nil
							],
						   nil
						   ];
	[self.view addSubview:_launcherView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTLauncherViewDelegate

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
	[item.URL openURL];
}

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
	[self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] 
												 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
												 target:_launcherView action:@selector(endEditing)] autorelease] animated:YES];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
}

#pragma mark dealloc


- (void)dealloc {
	TT_RELEASE_SAFELY(_launcherView);
	[super dealloc];
}

@end
