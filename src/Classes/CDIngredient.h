//
//  CDIngredient.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class CDRecipe;

@interface CDIngredient :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) CDRecipe * recipe;

@end



