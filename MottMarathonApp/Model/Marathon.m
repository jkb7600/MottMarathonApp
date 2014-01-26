//
//  Marathon.m
//  MottMarathonApp
//
//  Created by Justin Bennett on 1/15/14.
//  Copyright (c) 2014 jkb7600. All rights reserved.
//

#import "Marathon.h"
#import "Lap.h"

@interface Marathon()
@property (strong, nonatomic) NSDate *lastLapDate;
@end

@implementation Marathon

-(NSMutableArray *)Laps
{
    if(!_Laps){ _Laps = [[NSMutableArray alloc] init];}
    return _Laps;
}

-(NSDate *)startDate
{
    if(!_startDate){_startDate = [NSDate date];}
    return _startDate;
}

- (void)clear
{
    [self.Laps removeAllObjects];
    self.startDate = nil;
    
    //clear pause
    self.startPauseDate = nil;
    self.endPauseDate = nil;
    self.pauseTime = 0;
}

- (void)addLapWithDate:(NSDate *)currentDate
{
    Lap *lap;
    //get time interval by using start date
    if([self.Laps count] == 0){
        //First Lap
        lap = [[Lap alloc] initWithDate:currentDate andTime:[currentDate timeIntervalSinceDate:self.startDate]andPauseTime:self.pauseTime];

    }else{
        //all other laps
        Lap *lastLap = [self.Laps lastObject];
        lap = [[Lap alloc] initWithDate:currentDate andTime:[currentDate timeIntervalSinceDate:lastLap.creationDate] andPauseTime:self.pauseTime];
    }
    
    [self.Laps addObject:lap];
    
}

- (void)startPauseTime
{
    self.startPauseDate = [NSDate date];
}

- (void)endPauseTime
{
    self.endPauseDate = [NSDate date];
    [self addPauseIntervalTime];
}

- (void)addPauseIntervalTime
{
    if(!self.pauseTime){
        self.pauseTime = [self.endPauseDate timeIntervalSinceDate:self.startPauseDate];
    }else{
        self.pauseTime += [self.endPauseDate timeIntervalSinceDate:self.startPauseDate];
    }
    
    self.startPauseDate = nil;
    self.endPauseDate = nil;
}
@end
