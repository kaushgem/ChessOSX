//
//  Piece.h
//  ChessCMD
//
//  Created by kaushik.
//  Copyright (c) 2014 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Piece : NSObject
{
    BOOL possible;
    char fromA, toX;
    int fromB, toY;
}

-(BOOL)pmoveFrom:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board;
-(BOOL)rmoveFrom:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board;
-(BOOL)hmoveFrom:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board;
-(BOOL)bmoveFrom:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board;
-(BOOL)qmoveFrom:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board;
-(BOOL)kmoveFrom:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board;

-(BOOL)moveCheck:(BOOL)possible From:(int)a :(int)b To:(int)x :(int)y In:(char[8][8])board;

@end