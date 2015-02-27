//
//  AppDelegate.m
//  ChessCMD
//
//  Created by kaushik.
//  Copyright (c) 2014 administrator. All rights reserved.
//

//Characters used to represent pieces
//  R - Rook
//  N - Knight
//  B - Bishop
//  K - King
//  Q - Queen
//  P - Pawn
//  x - Empty box
// White - Uppercase characters
// Black - Lowercase characters

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize moves;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //reset
    [errorDisp setObjectValue:NULL];
    [historyDrawer close];
    historyCounter = 0;
    pc = [[Piece alloc]init];
    buttonFlag = false;
    prevColor = @"black";
    moves = [[NSMutableArray alloc]initWithObjects:@"** Moves **\n", nil];
    [self arrange];
}

-(void)applicationWillTerminate:(NSNotification *)notification
{
    
}



//Display Notification
-(void)errorDispCode:(NSString*)err
{
    [errorDisp setObjectValue:err];
    
    [[NSSound soundNamed:@"Chicken"] play];
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert setMessageText:@"Chess Move Notification"];
    [alert setInformativeText:err];
    //[alert runModal];
}



//Select Image for the box
-(NSImage*)imageSelecti:(int)i j:(int)j
{
    NSImage* img = NULL;
    if(i==0)
    {
        switch (j) {
            case 0:
            case 7:
                img = [NSImage imageNamed:@"br"];
                board[i][j]='r';
                break;
            case 1:
            case 6:
                img = [NSImage imageNamed:@"bn"];
                board[i][j]='n';
                break;
            case 2:
            case 5:
                img = [NSImage imageNamed:@"bb"];
                board[i][j]='b';
                break;
            case 3:
                img = [NSImage imageNamed:@"bq"];
                board[i][j]='q';
                break;
            case 4:
                img = [NSImage imageNamed:@"bk"];
                board[i][j]='k';
                break;
            default:
                board[i][j]='x';
                break;
        }
    }
    else if (i==7)
    {
        switch (j) {
            case 0:
            case 7:
                img = [NSImage imageNamed:@"wr"];
                board[i][j]='R';
                break;
            case 1:
            case 6:
                img = [NSImage imageNamed:@"wn"];
                board[i][j]='N';
                break;
            case 2:
            case 5:
                img = [NSImage imageNamed:@"wb"];
                board[i][j]='B';
                break;
            case 3:
                img = [NSImage imageNamed:@"wq"];
                board[i][j]='Q';
                break;
            case 4:
                img = [NSImage imageNamed:@"wk"];
                board[i][j]='K';
                break;
            default:
                board[i][j]='x';
                break;
        }
    }
    else if (i==1)
    {
        img = [NSImage imageNamed:@"bp"];
        board[i][j]='p';
    }
    else if (i==6)
    {
        img = [NSImage imageNamed:@"wp"];
        board[i][j]='P';
    }
    else
    {
        board[i][j]='x';
    }
    
    return img;
}



//Sum Even - White square
//Sum Odd - Black square
-(NSColor*)boxColori:(int)i j:(int)j
{
    if( (i+j)%2 == 0 )
        return [NSColor lightGrayColor];
    else
        return [NSColor darkGrayColor];
}




//Arrange the board
-(void)arrange
{
    int buttonSize = 80;
    for(int i=0 ; i<8 ; i++)
    {
        for(int j=0 ; j<8 ; j++)
        {
            NSButton *box = [[NSButton alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0+(buttonSize*j), 0+(buttonSize*i), buttonSize, buttonSize))];
            box.title = @"";
            box.identifier = [NSString stringWithFormat:@"%d",((7-i)*10)+j];
            [[box cell] setBackgroundColor:[self boxColori:(7-i) j:j]];
            [box setImage:[self imageSelecti:(7-i) j:j]];
            [box setTarget:self];
            [box setAction:@selector(buttonPress:)];
            [self.window.contentView addSubview:box];
        }
    }
    
    //Error Display Label
    errorDisp = [[NSTextField alloc] initWithFrame:(CGRectMake(400, 650, 150, 17))];
    [errorDisp setDrawsBackground:NO];
    [errorDisp setEditable:NO];
    [errorDisp setSelectable:NO];
    [errorDisp setBezeled:NO];
    [errorDisp setBackgroundColor:[NSColor redColor]];
    [[errorDisp cell]setBackgroundColor:[NSColor redColor]];
    [errorDisp setTextColor:[NSColor redColor]];
    [self.window.contentView addSubview:errorDisp];
    
    //Reset Button
    NSButton *bReset = [[NSButton alloc] initWithFrame:NSRectFromCGRect(CGRectMake(520, 650, 50, 20))];
    [bReset setTitle: @"Reset"];
    [bReset setAction:@selector(applicationDidFinishLaunching:)];
    [[[self window] contentView] addSubview:bReset];
    
    //History Button
    NSButton *bHistory = [[NSButton alloc] initWithFrame:NSRectFromCGRect(CGRectMake(580, 650, 50, 20))];
    [bHistory setTitle: @"History"];
    [bHistory setAction:@selector(showHistoryDrawer:)];
    [[[self window] contentView] addSubview:bHistory];
    
    NSSize contentSize = NSMakeSize(150, 10);
    historyDrawer = [[NSDrawer alloc] initWithContentSize:contentSize preferredEdge:NSMaxXEdge];
    [historyDrawer setParentWindow:self.window];
    [historyDrawer setMinContentSize:contentSize];
    [historyDrawer setMaxContentSize:contentSize];
    
    tv_history = [[NSTextView alloc]initWithFrame:NSRectFromCGRect(CGRectMake(25, 15, 100, 600))];
    [tv_history setDrawsBackground:NO];
    [tv_history setAlignment:NSCenterTextAlignment];
    sv_history = [[NSScrollView alloc]initWithFrame:NSRectFromCGRect(CGRectMake(25, 15, 90, 600))];
    //[[historyDrawer contentView]frame]];
    [sv_history setDrawsBackground:NO];
    [sv_history setHasVerticalScroller:YES];
    [sv_history setDocumentView:tv_history];
    [historyDrawer.contentView addSubview:sv_history];
}


-(void)showHistoryDrawer:(id)sender
{    
    NSDrawerState state = [historyDrawer state];
    if (NSDrawerOpeningState == state || NSDrawerOpenState == state) {
        [historyDrawer close];
    } else {
        [historyDrawer openOnEdge:NSMaxXEdge];
    }
    
    
}

//Get From and To coordinate buttons
-(void)buttonPress:(id)sender
{
    if(!buttonFlag)
    {
        [errorDisp setObjectValue:NULL];
        coorda = [[sender identifier] intValue]/10;
        coordb = [[sender identifier] intValue]%10;
        
        if(board[coorda][coordb]=='x')
        {
            [self errorDispCode:ERR_SEL_PCE];
        }
        else if(([prevColor isEqualToString:@"black"] && [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:board[coorda][coordb]]) ||
                ([prevColor isEqualToString:@"white"] && [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:board[coorda][coordb]]))
        {
            [self errorDispCode:ERR_NOT_YOUR_MOVE];
        }
        else
        {
            buttonFlag = true;
            from = sender;
            [[from cell]setBackgroundColor:[NSColor whiteColor]];
        }
    }
    else
    {
        to = sender;
        
        coordx = [[sender identifier] intValue]/10;
        coordy = [[sender identifier] intValue]%10;
        
        NSLog(@"Title %@ %@",[from title],[to title]);
        NSLog(@"Coords %d %d %d %d",coorda,coordb,coordx,coordy);
        
        if([self moveFrom:coorda :coordb To:coordx :coordy])
        {
            if([[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:board[coordx][coordy]])
                prevColor = @"black";
            else if([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:board[coordx][coordy]])
                prevColor = @"white";
        }
        else
        {
            [[from cell]setBackgroundColor:[self boxColori:coorda j:coordb]];
        }
        buttonFlag = false;
    }
    
}



//Check possiblity and move the piece
-(BOOL)moveFrom:(int)a :(int)b To:(int)x :(int)y
{
    BOOL possible = false;

    switch(board[a][b])
    {
        case 'p':
        case 'P':
        {
            pc = [[Pawn alloc]init];
            possible = [pc pmoveFrom:a :b To:x :y In:board];
            break;
        }
        case 'r':
        case 'R':
        {
            pc = [[Rook alloc]init];
            possible = [pc rmoveFrom:a :b To:x :y In:board];
            break;
        }
        case 'n':
        case 'N':
        {
            pc = [[Knight alloc]init];
            possible = [pc hmoveFrom:a :b To:x :y In:board];
            break;
        }
        case 'b':
        case 'B':
        {
            pc = [[Bishop alloc]init];
            possible = [pc bmoveFrom:a :b To:x :y In:board];
            break;
        }
        case 'k':
        case 'K':
        {
            pc = [[King alloc]init];
            possible = [pc kmoveFrom:a :b To:x :y In:board];
            break;
        }
        case 'q':
        case 'Q':
        {
            pc = [[Queen alloc]init];
            possible = [pc qmoveFrom:a :b To:x :y In:board];
            break;
        }
        case 'x':
        {
            NSLog(@"No Piece!!");
            [self errorDispCode:@"ERR_SEL_PCE"];
            break;
        }
        default:
        {
            NSLog(@"Error!!");
            [self errorDispCode:@"ERR"];
        }
    }
    
    if(possible)
    {
        [to setImage:([from image])];
        [[from cell] setBackgroundColor:[self boxColori:a j:b]];
        [from setImage:NULL];
        
        
        [self addHistoryFrom:a:b To:x:y];
        
//        printf("\nCount - %ld\n",[moves count]);
//        for (NSString *s in moves)
//        {
//            NSLog(@"Log - %@",moves);
//        }
        
        NSLog(@"Success!!");
        [self errorDispCode:SUCCESS];
    }
    else
    {
        NSLog(@"Move not possible!!");
        [self errorDispCode:ERR_MV_NOT_POSS];
    }
    return possible;
}



-(void)addHistoryFrom:(int)a :(int)b To:(int)x :(int)y
{
    char horizontalChars[] = "ABCDEFGH";
    
    fromA = horizontalChars[b];
    fromB = (char)8-a;
    
    toX = horizontalChars[y];
    toY = (char)8-x;
    
    NSLog(@"%c%d to %c%d",fromA,fromB,toX,toY);
    [moves addObject:[[NSString alloc]initWithFormat:@"%d) %c%d to %c%d",++historyCounter,fromA,fromB,toX,toY ]];
    [tv_history setString:[moves componentsJoinedByString:@"\n"]];
}

@end




/*
 NSButton *button = [[NSButton alloc] initWithFrame:NSZeroRect];
 [button setBezelStyle:NSRegularSquareBezelStyle];
 [button setBordered:YES];
 [button setImagePosition:NSImageAbove];
 [button setButtonType:NSMomentaryChangeButton];
 [button setImage:[NSImage imageNamed:@"myImage"]];
 [button setTitle:@"Button Title"];
 [button setTarget:self];
 [button setAction:@selector(buttonAction:)];
 [self.window.contentView addSubview:button];
 
 NSButton *br1 = [[NSButton alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0, 0, 50, 50))];
 br1.title = @"BRook";
 [br1 setImage:[NSImage imageNamed:@"br"]];
 [br1 setTarget:self];
 // [br1 setAction:@selector(start:)];
 //  [self performSelector:@selector(gamex:y:)withObject:br1 withObject:@"num2"];
 [br1 setAction:@selector(start:)];
 //[br1 performSelector:@selector(startx:y:)withObject:@"n1" withObject:@"n2"];
 //[br1 setAction:@selector(start:)withObject:1 withObject:2];
 //    [br1 setAction:@selector(start:(int)7:(int)0)];
 [self.window.contentView addSubview:br1];
 */