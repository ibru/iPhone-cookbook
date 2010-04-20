//
//  UnitConverter.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UnitConverter : NSObject {

}

- (float_t)flourGramsToCups:(float_t)grams;
- (float_t)flourCupsToGrams:(float_t)cups;

- (float_t)poundsToKilograms:(float_t)pounds;
- (float_t)kilogramsToPounds:(float_t)kilograms;

@end
