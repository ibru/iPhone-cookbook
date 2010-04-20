//
//  GreenStyleSheet.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GreenStyleSheet.h"


@implementation GreenStyleSheet

#pragma mark background

- (UIColor*)backgroundColor {
	return RGBCOLOR(209, 246, 212);
}

#pragma mark navigationController

- (UIColor*)navigationBarTintColor {
	return RGBCOLOR(0, 140, 0);
}

#pragma mark tables

- (UIColor*)tableGroupedBackgroundColor {
	return [self tablePlainBackgroundColor];
}

- (UIColor*)tablePlainBackgroundColor {
	return [self backgroundColor];
}

- (UIColor*)tableSeparatorColor {
	return RGBCOLOR(170, 255, 170);
}

#pragma mark refresh header

- (UIColor*)tableRefreshHeaderBackgroundColor {
	return [self backgroundColor];
}

#pragma mark tabBar

- (UIColor*)tabBarTintColor {
	return [self navigationBarTintColor];
}

- (UIColor*)tabTintColor {
	return [self navigationBarTintColor];
}

- (UIColor*)toolbarTintColor {
	return [self navigationBarTintColor];
}

#pragma mark custom buttons

- (TTStyle*)timerStartButton:(UIControlState)state {
	if (state == UIControlStateNormal) {
		return 
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
		 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 1, 0) next:
		  [TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0) blur:1 offset:CGSizeMake(0, 1) next:
		   [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(0, 170, 0)
											   color2:RGBCOLOR(0, 130, 0) next:
			[TTSolidBorderStyle styleWithColor:RGBCOLOR(161, 167, 178) width:1 next:
			 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(10, 12, 9, 12) next:
			  [TTTextStyle styleWithFont:nil color:[UIColor whiteColor]
							 shadowColor:[UIColor colorWithWhite:255 alpha:0.4]
							shadowOffset:CGSizeMake(0, -1) next:nil]]]]]]];
	} else if (state == UIControlStateHighlighted) {
		return 
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
		 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 1, 0) next:
		  [TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0.9) blur:1 offset:CGSizeMake(0, 1) next:
		   [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(0, 120, 0)
											   color2:RGBCOLOR(0, 100, 0) next:
			[TTSolidBorderStyle styleWithColor:RGBCOLOR(161, 167, 178) width:1 next:
			 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(10, 12, 9, 12) next:
			  [TTTextStyle styleWithFont:nil color:[UIColor whiteColor]
							 shadowColor:[UIColor colorWithWhite:255 alpha:0.4]
							shadowOffset:CGSizeMake(0, -1) next:nil]]]]]]];
	} else {
		return nil;
	}
}

- (TTStyle*)timerStopButton:(UIControlState)state {
	if (state == UIControlStateNormal) {
		return 
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
		 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 1, 0) next:
		  [TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0) blur:1 offset:CGSizeMake(0, 1) next:
		   [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(255, 0, 0)
											   color2:RGBCOLOR(216, 0, 0) next:
			[TTSolidBorderStyle styleWithColor:RGBCOLOR(161, 167, 178) width:1 next:
			 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(10, 12, 9, 12) next:
			  [TTTextStyle styleWithFont:nil color:[UIColor whiteColor]
							 shadowColor:[UIColor colorWithWhite:255 alpha:0.4]
							shadowOffset:CGSizeMake(0, -1) next:nil]]]]]]];
	} else if (state == UIControlStateHighlighted) {
		return 
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
		 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 1, 0) next:
		  [TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0.9) blur:1 offset:CGSizeMake(0, 1) next:
		   [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(200, 0, 0)
											   color2:RGBCOLOR(176, 0, 0) next:
			[TTSolidBorderStyle styleWithColor:RGBCOLOR(161, 167, 178) width:1 next:
			 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(10, 12, 9, 12) next:
			  [TTTextStyle styleWithFont:nil color:[UIColor whiteColor]
							 shadowColor:[UIColor colorWithWhite:200 alpha:0.4]
							shadowOffset:CGSizeMake(0, -1) next:nil]]]]]]];
	} else {
		return nil;
	}
}

@end
