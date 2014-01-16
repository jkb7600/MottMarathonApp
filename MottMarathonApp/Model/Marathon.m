//
//  Marathon.m
//  MottMarathonApp
//
//  Created by Justin Bennett on 1/15/14.
//  Copyright (c) 2014 jkb7600. All rights reserved.
//

#import "Marathon.h"


@implementation Marathon

-(NSMutableArray *)Laps
{
    if(!_Laps){ _Laps = [[NSMutableArray alloc] init];}
    return _Laps;
}

@end
