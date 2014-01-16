//
//  Lap.h
//  MottMarathonApp
//
//  Created by Justin Bennett on 1/15/14.
//  Copyright (c) 2014 jkb7600. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lap : NSObject
@property (strong, nonatomic, readonly) NSString *timeAsString;
@property (nonatomic, readonly) double timeAsDouble;

-(instancetype)initWithStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate;

@end
