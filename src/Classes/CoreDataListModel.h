//
//  CoreDataListModel.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Three20/Three20.h"


@interface CoreDataListModel : TTModel <NSFetchedResultsControllerDelegate> {
	NSFetchedResultsController *_fetchedResultsController;
	NSManagedObjectContext *_managedObjectContext;
	
	BOOL _isOutdated;
	BOOL _isLoaded;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

/**
 * Removes object from fetchedResultsController stored at particular index path and saves state
 * of model into database
 * @param indexPath index path of object to be removed
 * @return YES when object has been removed, NO when any problem occured
 */
- (BOOL)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Deletes all objects from fetchedResultsController and saves state of model into database
 * @return YES when all object has been successfully removed, NO when any problem occured
 */
- (BOOL)deleteAllObjects;

/**
 * Saves curent state of model into database. When any error ocures during saving state, error log is
 * generated.
 * @return YES when state has been saved, NO if any problem occured
 */
- (BOOL)saveState;

/**
 * Gets object stored at particular indexPath in fetchedResultsController
 */
- (NSManagedObject *)objectAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Gets all objects from fetchedResultsController
 */
- (NSArray *)fetchedObjects;

@end
