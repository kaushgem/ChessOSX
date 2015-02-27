//
//  Knight.m
//  Chess OOPS
//
//  Created by kaushik.
//  Copyright (c) 2014 administrator. All rights reserved.
//

#import "Knight.h"

@implementation Knight

//Knight
-(BOOL)hmoveFrom:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board
{
    if(fabs(a-x)+fabs(b-y) == 3)
        possible = true;
    return ([self moveCheck:possible From:a :b To:x :y In:board]);
}

@end
