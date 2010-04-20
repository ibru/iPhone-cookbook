//
//  CDComment.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class CDRecipe;
@class CDUser;

@interface CDComment :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * onDate;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) CDUser* user;
@property (nonatomic, retain) CDRecipe * recipe;

@end


@interface CDComment (CoreDataGeneratedAccessors)
- (void)addUserObject:(CDUser *)value;
- (void)removeUserObject:(CDUser *)value;
- (void)addUser:(NSSet *)value;
- (void)removeUser:(NSSet *)value;

@end

