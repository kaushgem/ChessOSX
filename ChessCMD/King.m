//
//  King.m
//  Chess OOPS
//
//  Created by kaushik.
//  Copyright (c) 2014 administrator. All rights reserved.
//

#import "King.h"

@implementation King

//King
-(BOOL)kmoveFrom:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board
{
    if((int)fabs(a-x) == (int)fabs(b-y))
        if((int)fabs(a-x) == 1)
            possible = true;
    
    if((a==x && (int)fabs(b-y)==1) || (b==y && (int)fabs(a-x)==1))
        possible = true;
    
    return ([self moveCheck:possible From:a :b To:x :y In:board]);
}

@end
