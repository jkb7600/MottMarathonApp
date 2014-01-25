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
}

- (void)addLapWithDate:(NSDate *)currentDate
{
    Lap *lap;
    //get time interval by using start date
    if([self.Laps count] == 0){
        //First Lap
        lap = [[Lap alloc] initWithDate:currentDate andTime:[currentDate timeIntervalSinceDate:self.startDate]];

    }else{
        //all other laps
        Lap *lastLap = [self.Laps lastObject];
        lap = [[Lap alloc] initWithDate:currentDate andTime:[currentDate timeIntervalSinceDate:lastLap.creationDate]];
        NSLog(@"NEW LAP");
    }
    
    [self.Laps addObject:lap];
    
}
@end
