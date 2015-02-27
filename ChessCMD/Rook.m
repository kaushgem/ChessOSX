//
//  Rook.m
//  Chess OOPS
//
//  Created by kaushik.
//  Copyright (c) 2014 administrator. All rights reserved.
//

#import "Rook.h"

@implementation Rook

//Rook
-(BOOL)rmoveFrom:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board
{
    //Check for all possible moves
    if (a==x || b==y)
    {
        if(a==x)
        {
            possible = true;
            for(int i=MIN(b,y)+1 ; i<MAX(b,y) ; i++)
            {
                if(board[a][i]!='x')
                {
                    possible=false;
                    break;
                }
            }
        }
        else if (b==y)
        {
            possible = true;
            for(int i=MIN(a,x)+1 ; i<MAX(a,x) ; i++)
            {
                if(board[i][b]!='x')
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
