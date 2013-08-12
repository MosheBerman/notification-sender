//
//  NNViewController.m
//  NotificationSender
//
//  Created by Moshe Berman on 8/12/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "NNViewController.h"

@interface NNViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (nonatomic, assign) NSInteger numberOfNotificationsAtOnce;
@property (nonatomic, assign) NSInteger intervalBetweenNotifications;

@property (nonatomic, strong) NSArray *intervals;
@property (nonatomic, strong)	NSArray *counts;
@property (strong, nonatomic) IBOutlet UITextField *alertBody;

@end

@implementation NNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
		
		_intervals = @[@(1), @(2), @(3), @(4), @(5), @(10), @(15), @(20), @(30), @(45), @(60)];
		_counts = @[@(1), @(2), @(3), @(4), @(5), @(10), @(15), @(20), @(30), @(45), @(60)];
		_intervalBetweenNotifications = 1;
		_numberOfNotificationsAtOnce = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
		return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
		
		NSInteger numberOfComponents = 0;
		
		if (0 == component) {
				return [[self counts] count];
		}
		
		if (1 == component) {
				return [[self intervals] count];
		}
		
		return numberOfComponents;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
		
		NSAttributedString *title = nil;
		NSString *unattributedString = nil;
		
		if (0 == component) {
				unattributedString = [[[self counts] objectAtIndex:row] stringValue];

		}
		else if (1 == component) {
				unattributedString = [[[self intervals] objectAtIndex:row] stringValue];
		}

		title = [[NSAttributedString alloc] initWithString:unattributedString];
		
		return title;
		
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
		NSInteger selectedObject = 0;
		
		if (0 == component) {
				selectedObject = [[[self counts] objectAtIndex:row] integerValue];
				[self setNumberOfNotificationsAtOnce:selectedObject];
				
		}
		else if (1 == component) {
				selectedObject = [[[self intervals] objectAtIndex:row] integerValue];
				[self setIntervalBetweenNotifications:component];
		}
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
		[textField resignFirstResponder];
		return YES;
}

#pragma mark - Send Notification

- (IBAction)scheduleTapped:(id)sender
{

		NSInteger offset = [self intervalBetweenNotifications];
		NSDate *date = [NSDate date];
		
		for (NSInteger i = 0; i < [self numberOfNotificationsAtOnce]; i++) {

				date = [date dateByAddingTimeInterval:offset];
				
				UILocalNotification *notification = [[UILocalNotification alloc] init];
				
        [notification setSoundName:UILocalNotificationDefaultSoundName];
				[notification setAlertBody:[[self alertBody] text]];
				[notification setFireDate:date];
				
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
		}
		

		
}

@end
