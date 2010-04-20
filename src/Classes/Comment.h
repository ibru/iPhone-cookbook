//
//  Comment.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol User;
@protocol Recipe;


@protocol Comment<NSObject>

@property (nonatomic, retain) NSDate *onDate;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) id<User> user;
@property (nonatomic, retain) id<Recipe> recipe;

@end

// ---------------------------------------

@interface Comment : NSObject<Comment> {
	NSString *_commentId;
	NSString *_userId;
	
	NSDate *_onDate;
	NSString *_text;
	id<User> _user;
	id<Recipe> _recipe;
	
	NSString *_usersFullName;
	NSString *_usersLogin;
}

@property (nonatomic, retain) NSString *commentId;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *usersFullName;
@property (nonatomic, retain) NSString *usersLogin;


+ (id)commentWithDictionary:(NSDictionary *)dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
