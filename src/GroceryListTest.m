#import <SenTestingKit/SenTestingKit.h>
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "GroceryList.h"
#import "Ingredient.h"
#import "CDGroceryListIngredient.h"

@interface GroceryListTest : SenTestCase {
	NSManagedObjectModel *model;
	NSPersistentStoreCoordinator *coordinator;
	NSManagedObjectContext *context;
}

@end


@implementation GroceryListTest


- (void) setUp {
	model = [NSManagedObjectModel mergedModelFromBundles:nil];
	NSLog(@"model: %@", model);
	STAssertEquals([[model entities] count], (NSUInteger)6, @"");	//6 entities should be there
	coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
	context = [[NSManagedObjectContext alloc] init];
	[context setPersistentStoreCoordinator:coordinator];
}

- (void) tearDown {
	//[model release];
	//[coordinator release];
	[context release];
}

- (void) testAddIngredientsToList {
	Ingredient *i1 = [[Ingredient alloc] init];
	i1.descr = @"Ingredient 1";
	
	Ingredient *i2 = [[Ingredient alloc] init];
	i2.descr = @"Ingredient 2";
	
	Ingredient *i3 = [[Ingredient alloc] init];
	i3.descr = @"Ingredient 3";
	
	NSArray *add = [NSArray arrayWithObjects:i1, i2, i3, nil];
	
	NSDictionary           * entities = [model entitiesByName];
	NSEntityDescription    * entity   = [entities valueForKey:@"CDGroceryListIngredient"];
	
//	NSPredicate * predicate;
//	predicate = [NSPredicate predicateWithFormat:@"creationDate > %@", date];
	
	NSSortDescriptor * sort = [[NSSortDescriptor alloc] initWithKey:@"descr" ascending:NO];
	NSArray * sortDescriptors = [NSArray arrayWithObject: sort];
	
	NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
	[fetch setEntity: entity];
//	[fetch setPredicate: predicate];
	[fetch setSortDescriptors: sortDescriptors];
	
	NSArray * results = [context executeFetchRequest:fetch error:nil];
	
	//it should be empty
	STAssertTrue([results count] == 0, @"");
	
	[GroceryList addIngredientsToList:add];
	
	results = [context executeFetchRequest:fetch error:nil];
	STAssertTrue([results count] == 3, @"");
	
}

@end
