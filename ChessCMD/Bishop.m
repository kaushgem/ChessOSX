//
//  Bishop.m
//  Chess OOPS
//
//  Created by kaushik.
//  Copyright (c) 2014 administrator. All rights reserved.
//

#import "Bishop.h"

@implementation Bishop

//Bishop
-(BOOL)bmoveFrom:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board
{
    if((int)fabs(a-x) == (int)fabs(b-y))
    {
        possible = true;
        if( ((a-x)/(b-y)) == 1 )
        {
            for(int i=MIN(a,x)+1, j=MIN(b,y)+1 ; i < MAX(a,x) ; i++, j++)
            {
                if(board[i][j]!='x')
                {
                    possible=false;
                    break;
                }
            }
        }
        else if ( ((a-x)/(b-y)) == -1 )
        {
            for(int i=MIN(a,x)+1, j=MAX(b,y)-1 ; i < MAX(a,x) ; i++, j--)
            {
                if(board[i][j]!='x')
                {
                    possible=false;
                    break;
                }
            }
        }
    }
    
    return ([self moveCheck:possible From:a :b To:x :y In:board]);
}

@end
