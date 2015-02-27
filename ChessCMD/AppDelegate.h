//
//  AppDelegate.h
//  ChessCMD
//
//  Created by kaushik.
//  Copyright (c) 2014 administrator. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Constants.h"
#import "Pawn.h"
#import "Rook.h"
#import "Knight.h"
#import "Bishop.h"
#import "King.h"
#import "Queen.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    Piece *pc;
    NSTextField *errorDisp;
    BOOL buttonFlag;
    NSButton *prevFrom;
    NSButton *prevTo;
    NSString *prevColor;
    NSButton *from;
    NSButton *to;
    int coorda,coordb,coordx,coordy;
    char board[8][8];
    
    NSDrawer *historyDrawer;
    char fromA,toX;
    int fromB,toY;
    
    NSScrollView *sv_history;
    NSTextView *tv_history;
    int historyCounter;
}

@property (assign) IBOutlet NSWindow *window;
@property (retain) NSMutableArray *moves;

-(void)showHistoryDrawer:(id)sender;
-(void)buttonPress:(id)sender;
-(NSColor*)boxColori:(int)i j:(int)j;
-(void)errorDispCode:(NSString*)err;

@end
