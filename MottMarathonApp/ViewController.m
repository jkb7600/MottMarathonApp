//
//  ViewController.m
//  MottMarathonApp
//
//  Created by Justin Bennett on 1/15/14.
//  Copyright (c) 2014 jkb7600. All rights reserved.
//

#import "ViewController.h"
#import "Marathon.h"
#import "LapsTableViewController.h"

@interface ViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) Marathon *marathon;
@property (strong, nonatomic) NSTimer *timer;

// Button outlets
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *lapButton;

@end

@implementation ViewController

/*
 Handle start pausing
 */

// Lazy marathon instantiation
- (Marathon *)marathon
{
    if (!_marathon) {
        _marathon = [[Marathon alloc] init];
    }
    return _marathon;
}

#pragma mark - Button Actions

- (IBAction)startButtonPress:(id)sender {
    [self toggleStartLap];
    
    if (self.stopButton.hidden) {
        [self toggleStopClear];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [self.timer fire];
    
    if(self.marathon.startPauseDate){
        [self.marathon endPauseTime];
    }
}

- (IBAction)stopButtonPress:(id)sender {
    [self toggleStartLap];
    [self toggleStopClear];
    [self.timer invalidate];
    [self.marathon startPauseTime];
}

#define DEFAULT_TIMER_LABEL_TEXT @"00:00:00.00"

- (IBAction)clearButtonPressed:(id)sender {

    UIAlertView *cancelAlert = [[UIAlertView alloc] initWithTitle:@"Cancel" message:@"Are you sure you want to clear all data for this marathon?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];
    
    [cancelAlert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self toggleStopClear];
        [self.marathon clear];
        self.timerLabel.text = DEFAULT_TIMER_LABEL_TEXT;
    }
    
}

- (IBAction)lapButtonPressed:(id)sender {
    //[self.marathon addLapWithIntervalTime:[[NSDate date]timeIntervalSinceDate:self.marathon.startDate]];
    [self.marathon addLapWithDate:[NSDate date]];
}

#pragma mark - Button State Changes

- (void)toggleStartLap
{
    if(self.lapButton.hidden){
        self.startButton.hidden = YES;
        self.lapButton.hidden = NO;
    }else{
        self.startButton.hidden = NO;
        self.lapButton.hidden = YES;
    }
}

- (void)toggleStopClear
{
    if (self.clearButton.hidden) {
        self.stopButton.hidden = YES;
        self.clearButton.hidden = NO;
    }else{
        self.clearButton.hidden = YES;
        self.stopButton.hidden = NO;
    }
}

#pragma mark - Timer Label Updating

- (void)updateTimer
{
    [self formatDoubleTimeInterval:[[NSDate date]timeIntervalSinceDate:self.marathon.startDate]];
}

- (void)formatDoubleTimeInterval:(double)timeInterval
{
    if (timeInterval > 0) {
        
        timeInterval -= self.marathon.pauseTime;
        
        NSString *hoursString;
        NSString *minString;
        NSString *secString;
        
        double hours = floor(timeInterval/3600);
        double min = floor(fmod((timeInterval/60), 60));
        double sec = fmod(timeInterval, 60);
        //sec = ceil(sec);
        
        if (hours < 10) {
            hoursString = [NSString stringWithFormat:@"0%g", hours];
        }else{
            hoursString = [NSString stringWithFormat:@"%g", hours];
        }
        
        if(min < 10){
            minString = [NSString stringWithFormat:@"0%g", min];
        }else{
            minString = [NSString stringWithFormat:@"%g", min];
        }
        
        if(sec < 10){
            secString = [NSString stringWithFormat:@"0%.2f", sec];
        }else{
            secString = [NSString stringWithFormat:@"%.2f",sec];
        }
        
        //set ouput
        self.timerLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hoursString, minString, secString];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"View Laps Segue"]){
        if ([segue.destinationViewController isKindOfClass:[LapsTableViewController class]]) {
            LapsTableViewController *ltvc = (LapsTableViewController *) segue.destinationViewController;
            ltvc.laps = self.marathon.Laps;
        }
        
    }
}

@end
