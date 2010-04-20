//
//  TimerViewController.h
//  Kucharka
//
//  Created by Jiri Urbasek on 3/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import "Three20/Three20.h"

@class AlertSound;

@interface TimerViewController : UIViewController {
	UIDatePicker *_timePicker;
	UILabel *_counterLabel;
	UIButton *_actionButton;
	
	NSTimer *_timer;
	TTButton *_button;
	
	int hours;
	int minutes;
	int seconds;
	
	NSArray *_alertSounds;
	AlertSound *_selectedAlertSound;
	
	CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
	
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property (nonatomic, retain) IBOutlet UIDatePicker *timePicker;
@property (nonatomic, retain) IBOutlet UILabel *counterLabel;
@property (nonatomic, retain) IBOutlet UIButton *actionButton;

@property (nonatomic, retain) NSArray *alertSounds;

- (IBAction)buttonClicked:(id)sender;

- (IBAction)pickerValueChanged:(id)sender;

- (void)countingStarted;

- (void)countingStopped;

@end
