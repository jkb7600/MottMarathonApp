//
//  Lap.m
//  MottMarathonApp
//
//  Created by Justin Bennett on 1/15/14.
//  Copyright (c) 2014 jkb7600. All rights reserved.
//

#import "Lap.h"

@interface Lap()
@property (strong, nonatomic, readwrite)NSString *timeAsString;
@property (nonatomic, readwrite)double timeAsDouble;
@end

@implementation Lap

-(instancetype)initWithDate:(NSDate *)creationDate andTime:(double)intervalTime
{
    self = [self initWithDate:creationDate andTime:intervalTime andPauseTime:0];
    return self;
}

// for after pause
-(instancetype)initWithDate:(NSDate *)creationDate andTime:(double)intervalTime andPauseTime:(double)pauseTime
{
    self = [super init];
    if(self){
        self.creationDate = creationDate;
        self.timeAsDouble = intervalTime - pauseTime;
    }
    return self;
    
}
-(NSString *)timeAsString
{
    if(!_timeAsString){
        double time = [self timeAsDouble];
        
        NSString *hoursString;
        NSString *minString;
        NSString *secString;
        
        double hours = floor(time/3600);
        double min = floor(fmod((time/60), 60));
        double sec = fmod(time, 60);
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
        _timeAsString = [NSString stringWithFormat:@"%@:%@:%@",hoursString, minString, secString];
    }
    return _timeAsString;
}

@end
