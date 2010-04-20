//
//  UnitConverterViewController.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "UnitConverter.h"


@interface UnitConverterViewController : UIViewController<UITextFieldDelegate> {
	UITextField *_flourCupsInput;
	UITextField *_flourGramsInput;
	UITextField *_weightPoundsInput;
	UITextField *_weightKilosInput;
	
	UnitConverter *_unitConverter;
}

@property (nonatomic, retain) IBOutlet UITextField *flourCupsInput;
@property (nonatomic, retain) IBOutlet UITextField *flourGramsInput;
@property (nonatomic, retain) IBOutlet UITextField *weightPoundsInput;
@property (nonatomic, retain) IBOutlet UITextField *weightKilosInput;

- (IBAction)inputValueChanged:(id)sender;

@end
