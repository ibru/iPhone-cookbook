//
//  ArchivedRecipesListModel.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ArchivedRecipesListModel.h"
#import "AppDelegate.h"


@implementation ArchivedRecipesListModel

@synthesize recipes = _recipes;


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
	
	if (_fetchedResultsController != nil) {
		return _fetchedResultsController;
	}
	
	/*
	 Set up the fetched results controller.
	 */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe"
											  inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Select only those, who arent
	//NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %d", FlightSetTypeArchive];
	//[fetchRequest setPredicate:predicate];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"descr" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
	// nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
																								managedObjectContext:self.managedObjectContext
																								  sectionNameKeyPath:nil
																										   cacheName:@"archivedRecipesListCache"];
	aFetchedResultsController.delegate = self;
	self.fetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	return _fetchedResultsController;
}   

#pragma mark public methods

- (NSArray<Recipe>* )recipes {
	return [self fetchedObjects];
}

#pragma mark dealloc

- (void)dealloc {
	TT_RELEASE_SAFELY(_recipes);
	[super dealloc];
}

@end
