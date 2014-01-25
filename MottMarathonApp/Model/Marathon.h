//
//  Marathon.h
//  MottMarathonApp
//
//  Created by Justin Bennett on 1/15/14.
//  Copyright (c) 2014 jkb7600. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lap.h"

@interface Marathon : NSObject
@property (strong, nonatomic) NSMutableArray *Laps; //of Lap
@property (strong, nonatomic) NSDate *startDate;

- (void)addLapWithDate:(NSDate *)currentDate;
- (void)clear;
@end
