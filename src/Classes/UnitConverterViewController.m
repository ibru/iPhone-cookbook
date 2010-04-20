//
//  UnitConverterViewController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UnitConverterViewController.h"


@implementation UnitConverterViewController

@synthesize flourCupsInput = _flourCupsInput;
@synthesize flourGramsInput = _flourGramsInput;
@synthesize weightPoundsInput =  _weightPoundsInput;
@synthesize weightKilosInput = _weightKilosInput;

- (id)init {
	return [self initWithNibName:@"UnitConverterView" bundle:nil];
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = TTSTYLEVAR(backgroundColor);
		
		_unitConverter = [[UnitConverter alloc] init];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSLog(@"textFieldShouldReturn");
	[textField resignFirstResponder];
	return YES;
}	

#pragma mark actions

- (IBAction)inputValueChanged:(id)sender {
	UITextField *textField = (UITextField *)sender;
	
	if ([textField isEqual:self.flourCupsInput]) {
		float_t cups = [self.flourCupsInput.text floatValue];
		self.flourGramsInput.text = [NSString stringWithFormat:@"%.2f", [_unitConverter flourCupsToGrams:cups]];
	}
	if ([textField isEqual:self.flourGramsInput]) {
		float_t grams = [self.flourGramsInput.text floatValue];
		self.flourCupsInput.text = [NSString stringWithFormat:@"%.2f", [_unitConverter flourGramsToCups:grams]];
	}
	if ([textField isEqual:self.weightKilosInput]) {
		float_t kilos = [self.weightKilosInput.text floatValue];
		self.weightPoundsInput.text = [NSString stringWithFormat:@"%.2f", [_unitConverter kilogramsToPounds:kilos]];
	}
	if ([textField isEqual:self.weightPoundsInput]) {
		float_t pounds = [self.weightPoundsInput.text floatValue];
		self.weightKilosInput.text = [NSString stringWithFormat:@"%.2f", [_unitConverter poundsToKilograms:pounds]];
	}
}

#pragma mark dealloc

- (void)dealloc {
	[_flourCupsInput release];
	[_flourGramsInput release];
	[_weightPoundsInput release];
	[_weightKilosInput release];
	[_unitConverter release];
    [super dealloc];
}


@end
