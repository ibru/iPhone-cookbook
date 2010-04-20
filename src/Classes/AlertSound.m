//
//  AlertSound.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlertSound.h"


@implementation AlertSound

@synthesize title = _title;
@synthesize fileName = _fileName;
@synthesize fileExtension = _fileExtension;


- (id)initWithTitle:(NSString *)title fileName:(NSString *)name extension:(NSString *)extension {
	if (self = [super init]) {
		self.title = title;
		self.fileName = name;
		self.fileExtension = extension;
	}
	return self;
}

+ (AlertSound *)alertSoundWithTitle:(NSString *)title fileName:(NSString *)name extension:(NSString *)extension {
	return [[[self alloc] initWithTitle:title fileName:name extension:extension] autorelease];
}

- (void)dealloc {
	[_title release];
	[_fileName release];
	[_fileExtension release];
	[super dealloc];
}


@end
