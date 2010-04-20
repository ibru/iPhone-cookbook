//
//  CDCategory.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class CDRecipe;

@interface CDCategory :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * recipesNumber;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSSet* recipes;
@property (nonatomic, retain) CDCategory * parent;

@end


@interface CDCategory (CoreDataGeneratedAccessors)
- (void)addRecipesObject:(CDRecipe *)value;
- (void)removeRecipesObject:(CDRecipe *)value;
- (void)addRecipes:(NSSet *)value;
- (void)removeRecipes:(NSSet *)value;

@end

