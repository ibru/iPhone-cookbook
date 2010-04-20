//
//  AppDelegate.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/25/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AppDelegate.h"
#import "GreenStyleSheet.h"
#import "TabBarController.h"
#import "CategoryListViewController.h"
#import "RecipeListViewController.h"
#import "SavedRecipesListViewController.h"
#import "RecipeDetailViewController.h"
#import "SavedRecipeDetailViewController.h"
#import "SearchedRecipeListViewController.h"
#import "CommentListViewController.h"
#import "SearchFormViewController.h"
#import "GroceryListViewController.h"
#import "ExtrasViewController.h"
#import "UnitConverterViewController.h"
#import "TimerViewController.h"

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	[TTStyleSheet setGlobalStyleSheet:[[[GreenStyleSheet alloc] init] autorelease]];
	
	TTNavigator* navigator = [TTNavigator navigator];
	navigator.persistenceMode = TTNavigatorPersistenceModeNone;
	navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
	navigator.supportsShakeToReload = YES;
	
	TTURLMap* map = navigator.URLMap;
	
	[map from:@"*" toViewController:[TTWebController class]];
	[map from:@"tt://tabBar" toSharedViewController:[TabBarController class]];
	[map from:@"tt://category/(initWithCategoryId:)" toViewController:[CategoryListViewController class]];
	[map from:@"tt://categoryIsEmpty" toViewController:[CategoryListViewController class] selector:@selector(categoryIsEmptyAlert)];
	[map from:@"tt://recipes/(initWithCategoryId:)" toViewController:[RecipeListViewController class]];
	[map from:@"tt://recipeDetail/(initWithRecipeId:)" toViewController:[RecipeDetailViewController class]];
	[map from:@"tt://savedRecipeDetail" toViewController:[SavedRecipeDetailViewController class]];
	[map from:@"tt://comments/(initWithRecipeId:)" toViewController:[CommentListViewController class]];
	[map from:@"tt://search" toViewController:[SearchFormViewController class]];
	[map from:@"tt://searchResult" toViewController:[SearchedRecipeListViewController class]];
	[map from:@"tt://grocery" toViewController:[GroceryListViewController class]];
	[map from:@"tt://archive" toViewController:[SavedRecipesListViewController class]];
	[map from:@"tt://extras" toViewController:[ExtrasViewController class]];
	[map from:@"tt://unitConverter" toViewController:[UnitConverterViewController class] transition:UIViewAnimationTransitionFlipFromLeft];
	[map from:@"tt://timer" toViewController:[TimerViewController class] transition:UIViewAnimationTransitionFlipFromLeft];
	
	if (![navigator restoreViewControllers]) {
		// This is the first launch, so we just start with the tab bar
		[navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://tabBar"]];
	}
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
	[[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
	return YES;
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
	NSError *error = nil;
	if (managedObjectContext != nil) {
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		} 
	}
}

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
	if (managedObjectContext != nil) {
		return managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) {
		managedObjectContext = [[NSManagedObjectContext alloc] init];
		[managedObjectContext setPersistentStoreCoordinator: coordinator];
	}
	return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
	if (managedObjectModel != nil) {
		return managedObjectModel;
	}
	managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
	return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
	if (persistentStoreCoordinator != nil) {
		return persistentStoreCoordinator;
	}
	
	
	NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"SuperHledac.sqlite"];
	/*
	 Set up the store.
	 For the sake of illustration, provide a pre-populated default store.
	 */
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// If the expected store doesn't exist, copy the default store.
	if (![fileManager fileExistsAtPath:storePath]) {
		NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"defaultDB" ofType:@"sqlite"];
		if (defaultStorePath) {
			[fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
		}
	}
	
	NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
	
	NSError *error = nil;
	persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}    
	
	return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[managedObjectContext release];
	[managedObjectModel release];
	[persistentStoreCoordinator release];
	[super dealloc];
}





@end
