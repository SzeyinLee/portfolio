//
//  ViewController.h
//  TicTacToe_Lee
//
//  Created by Szeyin Lee on 9/15/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSInteger whoseTurn;
    NSInteger countTurn;
}

@property (strong, nonatomic) IBOutlet UIButton *box1;
@property (strong, nonatomic) IBOutlet UIButton *box2;
@property (strong, nonatomic) IBOutlet UIButton *box3;
@property (strong, nonatomic) IBOutlet UIButton *box4;
@property (strong, nonatomic) IBOutlet UIButton *box5;
@property (strong, nonatomic) IBOutlet UIButton *box6;
@property (strong, nonatomic) IBOutlet UIButton *box7;
@property (strong, nonatomic) IBOutlet UIButton *box8;
@property (strong, nonatomic) IBOutlet UIButton *box9;

@property (strong, nonatomic) IBOutlet UIButton *reset;
-(IBAction) didPress:(id)press;
-(IBAction) boardreset;
-(BOOL) checkForWin;

@end


