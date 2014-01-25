//
//  Marathon.m
//  MottMarathonApp
//
//  Created by Justin Bennett on 1/15/14.
//  Copyright (c) 2014 jkb7600. All rights reserved.
//

#import "Marathon.h"
#import "Lap.h"
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

- (void)addLapWithIntervalTime:(double)intervalTime
{
    Lap *lap = [[Lap alloc]initWithIntervalTime:intervalTime];
    [self.Laps addObject:lap];
}
@end
