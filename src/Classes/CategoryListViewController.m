//
//  CategoryListController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CategoryListViewController.h"
#import "CategoryListDataSource.h"


@implementation CategoryListViewController

@synthesize categoryId = _categoryId;

- (id) init {
	if (self = [super init]) {
		self.title = @"Categories";
		self.variableHeightRows = YES;
		
		UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
																				   target:self
																				   action:@selector(reload)];
		refreshItem.style = UIBarButtonItemStylePlain;
		self.navigationItem.rightBarButtonItem = refreshItem;
		[refreshItem release];
		
		self.tableView.separatorColor = TTSTYLEVAR(tableSeparatorColor);
		
		UIImage* image = [UIImage imageNamed:@"categoriesIcon.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
	}
	
	return self;
}

- (id)initWithCategoryId:(NSString *)catgoryId {
	if (self = [self init]) {
		TTDASSERT(nil != catgoryId);
		self.categoryId = catgoryId;
	}
	return self;
}

- (void)createModel {
	self.dataSource = [[[CategoryListDataSource alloc] initWithCategoryId:_categoryId] autorelease];
	/*	
	self.dataSource = [TTListDataSource dataSourceWithObjects:
						[TTTableSubtitleItem itemWithText:@"Sample item" subtitle:@"" URL:@"tt://categoryIsEmpty"],
						[TTTableSubtitleItem itemWithText:@"Sample item" subtitle:@""],
						[TTTableSubtitleItem itemWithText:@"Sample item" subtitle:@""],
						nil];
	*/
}


- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewPlainDelegate alloc] initWithController:self] autorelease];
}

//displays allert saying category is empty
- (void)categoryIsEmptyAlert {
	NSLog(@"kategorie je prazdna");
}

#pragma mark -
#pragma mark dealloc

- (void)dealloc {
	TT_RELEASE_SAFELY(_categoryId);
	[super dealloc];
}

@end
