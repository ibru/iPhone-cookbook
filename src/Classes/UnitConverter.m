//
//  UnitConverter.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UnitConverter.h"

static float_t kFlourCupGramsRatio = 136.0;
static float_t kPoundKilogramsRatio = 0.45359237;

@implementation UnitConverter


- (float_t)flourGramsToCups:(float_t)grams {
	return grams / kFlourCupGramsRatio;
}

- (float_t)flourCupsToGrams:(float_t)cups {
	return cups * kFlourCupGramsRatio;
}

- (float_t)poundsToKilograms:(float_t)pounds {
	return pounds * kPoundKilogramsRatio;
}

- (float_t)kilogramsToPounds:(float_t)kilograms {
	return kilograms / kPoundKilogramsRatio;
}

@end
