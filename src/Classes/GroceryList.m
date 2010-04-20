//
//  GroceryList.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GroceryList.h"
#import <CoreData/CoreData.h>
#import "CDGroceryListIngredient.h"
#import "Ingredient.h"
#import "Three20/Three20.h"
#import "AppDelegate.h"
#import "Config.h"

@implementation GroceryList


+ (BOOL)addIngredientsToList:(NSSet<Ingredient> *)ingredients {

	NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
	
	for (id<Ingredient> ingredient in ingredients) {
		CDGroceryListIngredient *newIngredient = [NSEntityDescription insertNewObjectForEntityForName:@"GroceryListIngredient"
															 inManagedObjectContext:managedObjectContext];
		newIngredient.checked = NO;
		newIngredient.descr = ingredient.descr;
	}
	
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
		NSLog(@"%@", [error description]);
		return NO;
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:kGroceryBadgeNotification object:nil];
	 
	return YES;
}
@end
