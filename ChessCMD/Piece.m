//
//  Piece.m
//  ChessCMD
//
//  Created by kaushik.
//  Copyright (c) 2014 administrator. All rights reserved.
//

#import "Piece.h"
#import "math.h"

@implementation Piece

- (id)init
{
    self = [super init];
    if (self)
    {
        possible = false;
    }
    return self;
}


//Swap
-(BOOL)moveCheck:(BOOL)possible1 From:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board
{
    if(possible1)
    {
        if  (board[a][b]=='x' ||
             ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:board[a][b]] && [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:board[x][y]]) ||
             ([[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:board[a][b]] && [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:board[x][y]] && board[x][y]!='x'))
        {
            possible1 = false;
        }
        else
        {
            board[x][y]=board[a][b];
            board[a][b]='x';
        }
    }
    
    for (int i=0;i<8;i++)
    {
        for(int j=0;j<8;j++)
            printf("%c", board[i][j]!='x'?board[i][j]:'.');
        printf("\n");
    }
    

    
    return possible1;
}




@end
