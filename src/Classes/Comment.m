//
//  Comment.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Comment.h"
#import "Recipe.h"
#import "User.h"

@implementation Comment

@synthesize commentId = _commentId;
@synthesize userId = _userId;

@synthesize onDate = _onDate;
@synthesize text = _text;
@synthesize user = _user;
@synthesize recipe = _recipe;

@synthesize usersFullName = _usersFullName;
@synthesize usersLogin = _usersLogin;


+ (id)commentWithDictionary:(NSDictionary *)dictionary {
	return [[[self alloc] initWithDictionary:dictionary] autorelease];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
	if (self = [super init]) {
		self.commentId = [dictionary objectForKey:@"commentId"];
		self.userId = [dictionary objectForKey:@"userId"];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
		self.onDate = [formatter dateFromString:[dictionary objectForKey:@"dateAdded"]];
		[formatter release];
		
		self.text = [dictionary objectForKey:@"text"];
		
		if (![(NSString *)[dictionary objectForKey:@"usersFullName"] isEqualToString:@""]) {
			self.usersFullName = [dictionary objectForKey:@"usersFullName"];
		}
		if (![(NSString *)[dictionary objectForKey:@"usersLogin"] isEqualToString:@""]) {
			self.usersLogin = [dictionary objectForKey:@"usersLogin"];
		}
	}
	return self;
}

- (void)dealloc {
	[_commentId release];
	[_userId release];
	
	[_onDate release];
	[_text release];
	[_user release];
	[_recipe release];
	
	[_usersFullName release];
	[_usersLogin release];
	
	[super dealloc];
}

@end
