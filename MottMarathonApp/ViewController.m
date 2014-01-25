//
//  ViewController.m
//  MottMarathonApp
//
//  Created by Justin Bennett on 1/15/14.
//  Copyright (c) 2014 jkb7600. All rights reserved.
//

#import "ViewController.h"
#import "Marathon.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) Marathon *marathon;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController

// Lazy marathon instantiation
- (Marathon *)marathon
{
    if (!_marathon) {
        _marathon = [[Marathon alloc] init];
    }
    return _marathon;
}

- (IBAction)startButtonPress:(id)sender {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (IBAction)stopButtonPress:(id)sender {
    [self.timer invalidate];
}

- (void)updateTimer
{
    [self formatDoubleTimeInterval:[[NSDate date]timeIntervalSinceDate:self.marathon.startDate]];
}

- (void)formatDoubleTimeInterval:(double)timeInterval
{
    if (timeInterval > 0) {
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
    @end
