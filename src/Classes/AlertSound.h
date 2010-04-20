//
//  AlertSound.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AlertSound : NSObject {
	NSString *_title;
	NSString *_fileName;
	NSString *_fileExtension;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) NSString *fileExtension;

- (id)initWithTitle:(NSString *)title fileName:(NSString *)name extension:(NSString *)extension;

+ (AlertSound *)alertSoundWithTitle:(NSString *)title fileName:(NSString *)name extension:(NSString *)extension;

@end
