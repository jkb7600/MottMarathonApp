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

@property (nonatomic)double averageLapTimeAsFloat;
@property (nonatomic)double estimatedFinishTimeAsDouble;
@property (nonatomic)double timeElapsed;
@property (nonatomic)double tempPauseTime; // For lap correction after a pause

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
    self.timeElapsed = 0;
    
    //clear pause
    self.startPauseDate = nil;
    self.endPauseDate = nil;
    self.pauseTimeTotal = 0;
    self.tempPauseTime = 0;
    
}

- (void)addLapWithDate:(NSDate *)currentDate
{
    Lap *lap;
    //get time interval by using start date
    if([self.Laps count] == 0){
        //First Lap include pause time
        lap = [[Lap alloc] initWithDate:currentDate andTime:[currentDate timeIntervalSinceDate:self.startDate]andPauseTime:self.pauseTimeTotal];

    }else{
        //all other laps
        Lap *lastLap = [self.Laps lastObject];
        lap = [[Lap alloc] initWithDate:currentDate andTime:[currentDate timeIntervalSinceDate:lastLap.creationDate] andPauseTime:self.tempPauseTime];
        self.tempPauseTime = 0;

    }
    
    [self.Laps addObject:lap];
    [self calculateStats];
    
    if(!self.timeElapsed){
        self.timeElapsed = lap.timeAsDouble;
    }else{
        self.timeElapsed += lap.timeAsDouble;
    }
    
}

#pragma mark - Pause Handling

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
    self.tempPauseTime = [self.endPauseDate timeIntervalSinceDate:self.startPauseDate];
    if(!self.pauseTimeTotal){
        self.pauseTimeTotal = self.tempPauseTime;
    }else{
        self.pauseTimeTotal += self.tempPauseTime;
    }
    
    self.startPauseDate = nil;
    self.endPauseDate = nil;
}

#pragma mark - Stats

- (void)calculateStats
{
    [self calculateAverageLapTime];
    [self calculateEstimatedFinishTime];

}

- (void)calculateAverageLapTime
{
    double totalTime = 0;
    
    for(Lap *lap in self.Laps){
        totalTime += lap.timeAsDouble;
    }
    float averageTime = totalTime / [self.Laps count];
    
    self.averageLapTimeAsFloat = averageTime;
    self.avgLapTimeAsString = [self formatFloatTimeToOutputText:averageTime];
}

- (void)calculateEstimatedFinishTime
{
    int lapsRemaining = 105 - (int)[self.Laps count];
    float timeRemaining = lapsRemaining * self.averageLapTimeAsFloat;
    
    self.estFinishTimeAsString = [self formatFloatTimeToOutputText:timeRemaining];
}



- (NSString *)formatFloatTimeToOutputText:(float)time
{
    NSString *hoursString;
    NSString *minString;
    NSString *secString;
    
    double hours = floor(time/3600);
    double min = floor(fmod((time/60), 60));
    double sec = fmod(time, 60);
   
    
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
    return [NSString stringWithFormat:@"%@:%@:%@",hoursString, minString, secString];
}
@end
