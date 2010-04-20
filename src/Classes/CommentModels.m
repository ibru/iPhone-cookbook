//
//  CommentModels.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommentModels.h"
#import "Comment.h"
#import "JSON.h"
#import "Config.h"


@implementation CommentListModel

@synthesize comments = _comments;

- (id)initWithRecipeId:(NSString *)recipeId {
	if (self = [super init]) {
		_recipeId = [recipeId retain];
	}
	return self;
}


#pragma mark public methods

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	
	[super requestDidFinishLoad:request];
	
	TTDASSERT(nil != _jsonString);
	NSArray *commentsDicts = [_jsonString JSONValue];
	
	TT_RELEASE_SAFELY(_comments);
	NSMutableArray *comments = [[NSMutableArray alloc] init];
	
	for (NSDictionary *singleCommentDict in commentsDicts) {
		
		[comments addObject:[[[Comment alloc] initWithDictionary:singleCommentDict] autorelease]];
	}
	_comments = comments;
}

#pragma mark JSONDataModel methods

- (NSString *)sourceUrlFormat {
	return [kDomainUrl stringByAppendingString:kCommentListPathFormatJSON];
}

- (NSString *)sourceUrlFormatVariable {
	return _recipeId;
}

#pragma mark dealloc

- (void) dealloc {
	TT_RELEASE_SAFELY(_comments);
	TT_RELEASE_SAFELY(_recipeId);
	[super dealloc];
}


@end
