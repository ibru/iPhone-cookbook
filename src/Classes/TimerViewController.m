//
//  TimerViewController.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimerViewController.h"
#import "AlertSound.h"

@implementation TimerViewController

@synthesize timePicker = _timePicker;
@synthesize counterLabel = _counterLabel;
@synthesize actionButton = _actionButton;

@synthesize alertSounds = _alertSounds;

@synthesize soundFileURLRef;
@synthesize soundFileObject;


- (id)init {
	return [self initWithNibName:@"TimerView" bundle:nil];
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		_timer = nil;
		hours = 0;
		minutes = 0;
		seconds = 0;
		
		_button  = [[TTButton buttonWithStyle:@"timerStartButton:" title:@"Start"] retain];
		_button.frame = CGRectMake(20, 300, 280, 40);
		[self.view addSubview:_button];
		[_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
		self.actionButton.hidden = YES;
		
		self.title = @"Timer";
		
		[self initializeAlertSounds];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.counterLabel.hidden = YES;
	self.timePicker.countDownDuration = 60;
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
	self.timePicker = nil;
	self.actionButton = nil;
	self.counterLabel = nil;
}

#pragma mark private methods

-(void)updateLabel{
	if (hours > 0)
		self.counterLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
	else
		self.counterLabel.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

- (void)showEndAlert {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done"
													message:@"Hey, you are done. Your timer expired."
												   delegate:self
										  cancelButtonTitle:@"Okay"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}


- (void)playAlertSound:(AlertSound *)alertSound {
	
	
	
	AudioServicesPlayAlertSound (self.soundFileObject);
}

- (void)vibrateDevice {
	AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

- (void)fireCountingEnd {
	// TODO: play sound or whatever
	// Get the main bundle for the app
	
	[self showEndAlert];
	[self playAlertSound:[self.alertSounds objectAtIndex:0]];
	//[self vibrateDevice];
	
	[_timer invalidate];
	[self countingStopped];
}

- (void)decrementBySecond {
	
	if (hours <= 0 && minutes <= 0 && seconds <= 0) {
		[self fireCountingEnd];
	}
	
	if (seconds >= 1) {
		seconds--;
	}
	else {
		minutes--;
		seconds = 59;
	}
	if (seconds == 0 && minutes == 0 && hours >= 1) {
		hours--;
		minutes = 59;
		seconds = 59;
	}
	
	[self updateLabel];
}

- (void)initializeCounter {
	
	int duration = [self.timePicker countDownDuration];
	hours = (int)(duration / (60 * 60));
	duration -= hours * 60 * 60;
	
	minutes = (int)(duration / 60);
	duration -= minutes * 60;
	
	seconds = duration;
}

- (void)initializeAlertSounds {
	
	AlertSound *sound1 = [AlertSound alertSoundWithTitle:@"Bicycle Bell" fileName:@"bicycleBell" extension:@"wav"];
	AlertSound *sound2 = [AlertSound alertSoundWithTitle:@"Vintage Phone Ringing" fileName:@"vintagePhoneRinging" extension:@"wav"];
	AlertSound *sound3 = [AlertSound alertSoundWithTitle:@"Dog Whistle" fileName:@"dogWhistle" extension:@"wav"];
	
	NSArray *sounds = [[NSArray alloc] initWithObjects: sound1, sound2, sound3, nil];
	
	self.alertSounds = sounds;
	if (_selectedAlertSound == nil) {
		_selectedAlertSound = [[self.alertSounds objectAtIndex:0] retain];
	}
	[sounds release];
	
	//initialize first sound
	// Get the main bundle for the app
	CFBundleRef mainBundle;
	mainBundle = CFBundleGetMainBundle ();
	
	AlertSound *alertSound = [self.alertSounds objectAtIndex:0];
	const char *fileName = [alertSound.fileName cStringUsingEncoding:NSASCIIStringEncoding];
	const char *extension = [alertSound.fileExtension cStringUsingEncoding:NSASCIIStringEncoding];
	// Get the URL to the sound file to play
	soundFileURLRef  =	CFBundleCopyResourceURL (
												 mainBundle,
												 CFStringCreateWithCString(NULL,fileName, kCFStringEncodingASCII),
												 CFStringCreateWithCString(NULL, extension, kCFStringEncodingASCII),
												 NULL
												 );
	
	// Create a system sound object representing the sound file
	AudioServicesCreateSystemSoundID (
									  soundFileURLRef,
									  &soundFileObject
									  );
}

#pragma mark public methods

- (void)countingStarted {
	
	self.counterLabel.hidden = NO;
	self.timePicker.hidden = YES;
	[_button setStylesWithSelector:@"timerStopButton:"];
	[self.actionButton setTitle:@"Stop" forState:UIControlStateNormal];	 
	self.actionButton.titleLabel.backgroundColor = [UIColor redColor];
}

- (void)countingStopped {
	
	self.counterLabel.hidden = YES;
	self.timePicker.hidden = NO;
	self.actionButton.titleLabel.text = @"Start";
	[_button setStylesWithSelector:@"timerStartButton:"];
	self.actionButton.backgroundColor = [UIColor whiteColor];
}

#pragma mark actions

- (IBAction)buttonClicked:(id)sender {
	
	if (self.counterLabel.hidden) {		
				
		[self initializeCounter];
		[self updateLabel];
		[self countingStarted];
		
		_timer = [NSTimer scheduledTimerWithTimeInterval:1
												  target:self
												selector:@selector(decrementBySecond)
												userInfo:nil
												 repeats:YES];

	}
	else {
		[self countingStopped];
	}
}

- (IBAction)pickerValueChanged:(id)sender {
}


#pragma mark dealloc

- (void)dealloc {
	[_timePicker release];
	[_counterLabel release];
	[_actionButton release];
	[_timer release];
	[_button release];
	[_alertSounds release];
	[_selectedAlertSound release];
	
	AudioServicesDisposeSystemSoundID (soundFileObject);
	CFRelease (soundFileURLRef);
	
    [super dealloc];
}


@end
