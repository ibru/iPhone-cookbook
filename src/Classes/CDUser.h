//
//  CDUser.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class CDComment;
@class CDRecipe;

@interface CDUser :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* recipes;
@property (nonatomic, retain) NSSet* comments;

@end


@interface CDUser (CoreDataGeneratedAccessors)
- (void)addRecipesObject:(CDRecipe *)value;
- (void)removeRecipesObject:(CDRecipe *)value;
- (void)addRecipes:(NSSet *)value;
- (void)removeRecipes:(NSSet *)value;

- (void)addCommentsObject:(CDComment *)value;
- (void)removeCommentsObject:(CDComment *)value;
- (void)addComments:(NSSet *)value;
- (void)removeComments:(NSSet *)value;

@end

