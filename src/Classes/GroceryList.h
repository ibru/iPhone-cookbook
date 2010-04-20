//
//  GroceryList.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Ingredient;

@interface GroceryList : NSObject {

}


+ (BOOL)addIngredientsToList:(NSSet<Ingredient> *)ingredients;

@end
