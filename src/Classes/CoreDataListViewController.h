//
//  CoreDataListViewController.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@class ListCoreDataSource;


@interface CoreDataListViewController : TTTableViewController<UIAlertViewDelegate> {

}

@property (nonatomic, retain) ListCoreDataSource *coreDataSource;

- (void)deleteContent;

@end
