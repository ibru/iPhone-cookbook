//
//  User.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol Recipe;
@protocol Comment;

@protocol User<NSObject>

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *surname;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSSet<Recipe> *recipes;
@property (nonatomic, retain) NSSet<Comment> *comments;

@end

// -------------------------------------

@interface User : NSObject {

}

@end
