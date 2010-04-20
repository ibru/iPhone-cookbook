//
//  JSONDataModel.h
//  Kucharka
//
//  Created by Jiri Urbasek on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"


@interface JSONDataModel : TTURLRequestModel {
	NSString *_jsonString;
	BOOL _isOutdated;
}

//format of url where json string is grabbed. This method must be redefined by subclasses to
//specify correct url where to grab proper json source
- (NSString *)sourceUrlFormat;

//variable for url format. Because in url format there is usuasy varying recipeId or categoryId etc.
//subclasses must redefine this method to set proper variable needed
- (NSString *)sourceUrlFormatVariable;

@end
