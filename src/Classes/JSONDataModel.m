//
//  JSONDataModel.m
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "JSONDataModel.h"


@implementation JSONDataModel

- (id)init {
	if (self = [super init]) {
		_isOutdated = NO;
	}
	return self;
}

- (BOOL)isOutdated { return _isOutdated; }

- (NSString *)sourceUrlFormat {
	[NSException raise:@"IlegalStateException"
				format:@"Method sourceUrlFormat of JSONDataModel must be redefined by all its subclases."];
	return nil;
}

- (NSString *)sourceUrlFormatVariable {
	[NSException raise:@"IlegalStateException"
				format:@"Method sourceUrlFormatVariable of JSONDataModel must be redefined by all its subclases."];
	return nil;
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading) {
		_isOutdated = YES;
		NSString* url = [NSString stringWithFormat:[self sourceUrlFormat], [self sourceUrlFormatVariable]];
		
		TTURLRequest* request = [TTURLRequest requestWithURL:url delegate:self];
		
		id<TTURLResponse> response = [[TTURLDataResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);

		request.cachePolicy = cachePolicy;
		//request.cacheExpirationAge = 0;
		
		[request send];
	}
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	
	TTURLDataResponse *response = request.response;
	// This response is designed for NSData objects, so if we get anything else it's probably a
	// mistake.
	TTDASSERT([response.data isKindOfClass:[NSData class]]);
	
	if (_jsonString != nil)
		TT_RELEASE_SAFELY(_jsonString);
	
	//set ivar to received http response body
	if ([response.data isKindOfClass:[NSData class]]) {
		NSString *recipeDataStr = [[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding];
		_jsonString = recipeDataStr;
	}
	
	[super requestDidFinishLoad:request];
	_isOutdated = NO;
}

#pragma mark -
#pragma mark dealloc

- (void) dealloc {
	TT_RELEASE_SAFELY(_jsonString);
	[super dealloc];
}

@end
