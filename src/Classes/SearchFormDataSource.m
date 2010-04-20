//
//  SearchFormDataSource.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SearchFormDataSource.h"


@implementation SearchFormDataSource

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	if (section == 0) {
		return @"Specify string you want to match recipe title";
	}
	else if (section == 1) {
		return @"Specify ingredients to search."
		"You can search for multiple ingredients by separating them using colon (,) character";
	}
	return nil;
}
@end
