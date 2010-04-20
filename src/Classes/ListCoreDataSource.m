//
//  ListCoreDataSource.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ListCoreDataSource.h"


@implementation ListCoreDataSource

@synthesize coreDataModel = _dataModel;
@synthesize modelViewController = _viewController;


- (id<TTModel>)model {
	return _dataModel;
}

#pragma mark public methods

- (BOOL)deleteAllObjects {
	return [self.coreDataModel deleteAllObjects];
}

- (BOOL)isAnythingToDelete {
	return [[self.coreDataModel fetchedObjects] count] > 0;
}

- (NSUInteger)numberOfObjects {
	return [[self.coreDataModel fetchedObjects] count];
}

#pragma mark editing

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
	    if (![self.coreDataModel removeObjectAtIndexPath:indexPath]) {
			TTAlert(@"Uh. Some unexpected things during removing your recipe happend.");
		} else {
			[self.modelViewController refresh];
		}
    }   
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}


#pragma mark dealloc

- (void)dealloc {
	TT_RELEASE_SAFELY(_dataModel);
	TT_RELEASE_SAFELY(_viewController);
	[super dealloc];
}

@end
