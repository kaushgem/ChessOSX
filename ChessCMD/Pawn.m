//
//  Pawn.m
//  Chess OOPS
//
//  Created by kaushik.
//  Copyright (c) 2014 administrator. All rights reserved.
//

#import "Pawn.h"

@implementation Pawn

-(BOOL)pmoveFrom:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board
{
    char c = board[a][b];
    @try{
        if(y==b)
        {
            if(c=='p')
            {
                if(a==1)
                {
                    if( (x==2 && board[x][y]=='x') || (x==3 && board[2][y]=='x') )
                        possible = true;
                }
                else if (a==7)
                {
                    possible = false;
                }
                else
                {
                    if(x == a+1 && board[x][y]=='x')
                        possible = true;
                }
            }
            else if(c=='P')
            {
                if(a==6)
                {
                    if( (x==5 && board[x][y]=='x') || (x==4 && board[5][y]=='x') )
                        possible = true;
                }
                else if (a==0)
                {
                    possible = false;
                }
                else
                {
                    if(x == a-1 && board[x][y]=='x')
                        possible = true;
                }
            }
        }
        else if(y==b+1 || y==b-1)
        {
            if(c=='p' && x==a+1)
            {
                if([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:board[x][y]])
                    possible = true;
            }
            if(c=='P' && x==a-1)
            {
                if([[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:board[x][y]] && board[x][y]!='x')
                    possible = true;
            }
        }
        
        if(possible)
        {
            board[x][y]=board[a][b];
            board[a][b]='x';
        }
        
    }
    @catch(NSException *e ) {
        NSLog(@"%@",[e reason]);
    }
    
    return (possible);//([self moveCheck:possible From:a :b To:x :y In:board]);
}

@end
