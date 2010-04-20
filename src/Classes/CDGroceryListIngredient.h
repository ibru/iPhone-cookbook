//
//  CDGroceryListIngredient.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface CDGroceryListIngredient :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSNumber * checked;

@end



