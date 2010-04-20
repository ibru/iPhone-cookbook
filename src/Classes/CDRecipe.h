//
//  CDRecipe.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class CDCategory;
@class CDComment;
@class CDIngredient;
@class CDUser;

@interface CDRecipe :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * procedure;
@property (nonatomic, retain) NSNumber * durationTime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSNumber * servings;
@property (nonatomic, retain) NSSet* comments;
@property (nonatomic, retain) CDCategory * category;
@property (nonatomic, retain) NSSet* ingredients;
@property (nonatomic, retain) CDUser * user;

@end


@interface CDRecipe (CoreDataGeneratedAccessors)
- (void)addCommentsObject:(CDComment *)value;
- (void)removeCommentsObject:(CDComment *)value;
- (void)addComments:(NSSet *)value;
- (void)removeComments:(NSSet *)value;

- (void)addIngredientsObject:(CDIngredient *)value;
- (void)removeIngredientsObject:(CDIngredient *)value;
- (void)addIngredients:(NSSet *)value;
- (void)removeIngredients:(NSSet *)value;

@end

