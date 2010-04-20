//
//  CoreDataListModel.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CoreDataListModel.h"
#import "AppDelegate.h"


@implementation CoreDataListModel

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;

- (id)init {
	if (self = [super init]) {
		_isLoaded = NO;
		_isOutdated = YES;
	}
	return self;
}

- (BOOL)isLoaded {
	return _isLoaded;
}

- (BOOL)isLoading {
	return NO;
}

- (BOOL)isOutdated {
	return _isOutdated;
}


- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unable to fetch data. %@, %@", error, [error userInfo]);
		abort();
	}
	_isLoaded = YES;
	_isOutdated = NO;
	[super didFinishLoad];
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
	
	TTDINFO(@"Method [%@ fetchedResultsController] has to be redefined in child classes.", [self class]);
	return nil;
}   

- (NSManagedObjectContext *) managedObjectContext {
	if (_managedObjectContext == nil) {
		AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		_managedObjectContext = [appDelegate.managedObjectContext retain];
	}
	return _managedObjectContext;
}


// NSFetchedResultsControllerDelegate method to notify the delegate that all section and object changes have been processed. 
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	_isOutdated = YES;
}

#pragma mark public methods

- (BOOL)removeObjectAtIndexPath:(NSIndexPath *)indexPath {
	[_managedObjectContext deleteObject:[self objectAtIndexPath:indexPath]];
	_isOutdated = YES;
	return [self saveState];
}

- (void)deleteObject:(NSManagedObject *)object {
	[_managedObjectContext deleteObject:object];
	_isOutdated = YES;
}

- (BOOL)deleteAllObjects {
	for (NSManagedObject *object in [self fetchedObjects]) {
		[self deleteObject:object];
	}
	_isOutdated = YES;
	return [self saveState];
}


- (BOOL)saveState {
	NSError *error = nil;
	if (![_managedObjectContext save:&error]) {
		TTDERROR(@"Unable to save state of grocery list. Reason: %@", [error.userInfo description]);
		return NO;
	}
	return YES;
}

- (NSManagedObject *)objectAtIndexPath:(NSIndexPath *)indexPath {
	return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (NSArray *)fetchedObjects {
	return [self.fetchedResultsController fetchedObjects];
}


#pragma mark dealloc

- (void)dealloc {
	[_fetchedResultsController release];
	[_managedObjectContext release];
	[super dealloc];
}

@end
