//
//  ViewController.m
//  TicTacToe_Lee
//
//  Created by Szeyin Lee on 9/15/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController;


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self boardreset];
}

-(IBAction)didPress:(id)press {
    if (whoseTurn == 1) {
        if ([press titleLabel].text==nil){countTurn++;}
        
        [press setTitle:@"X" forState:UIControlStateNormal];
        if (self.checkForWin) {
            UIAlertView *playerWon=[[UIAlertView alloc] initWithTitle:@"YAY!" message:@"Player X Wins!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [playerWon show];}
        
        else if (countTurn == 9){
            UIAlertView *playerTie=[[UIAlertView alloc] initWithTitle:@"Tie!" message:@"Let's try again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [playerTie show];}
        
        else{
            whoseTurn=0;}}
    else{
        if ([press titleLabel].text==nil){countTurn++;}
        [press setTitle:@"O" forState:UIControlStateNormal];
        if (self.checkForWin) {
            UIAlertView *playerWon=[[UIAlertView alloc] initWithTitle:@"Player O Wins!" message:@"Victory!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [playerWon show];}
        else if (countTurn == 9){
            UIAlertView *playerTie=[[UIAlertView alloc] initWithTitle:@"Tie!" message:@"Let's try again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [playerTie show];}
        else{
            whoseTurn=1;}}
}



-(BOOL)checkForWin{
    //check for horizontal wins
    if ([[[self.box1 titleLabel] text] isEqualToString:[[self.box2 titleLabel] text]]) {
        if ([[[self.box2 titleLabel] text] isEqualToString:[[self.box3 titleLabel] text]]){
            return YES;}}
    if ([[[self.box4 titleLabel] text] isEqualToString:[[self.box5 titleLabel] text]]) {
        if ([[[self.box5 titleLabel] text] isEqualToString:[[self.box6 titleLabel] text]]){
            return YES;}}
    if ([[[self.box7 titleLabel] text] isEqualToString:[[self.box8 titleLabel] text]]) {
        if ([[[self.box8 titleLabel] text] isEqualToString:[[self.box9 titleLabel] text]]){
            return YES;}}
    
    //check for vertical wins
    if ([[[self.box1 titleLabel] text] isEqualToString:[[self.box4 titleLabel] text]]){
        if ([[[self.box4 titleLabel] text] isEqualToString:[[self.box7 titleLabel] text]]){
            return YES;}}
    if ([[[self.box2 titleLabel] text] isEqualToString:[[self.box5 titleLabel] text]]){
        if ([[[self.box5 titleLabel] text] isEqualToString:[[self.box8 titleLabel] text]]){
            return YES;}}
    if ([[[self.box3 titleLabel] text] isEqualToString:[[self.box6 titleLabel] text]]) {
        if ([[[self.box6 titleLabel] text] isEqualToString:[[self.box9 titleLabel] text]]){
            return YES;}}
    
    //check for diagonal wins
    if ([[[self.box1 titleLabel] text] isEqualToString:[[self.box5 titleLabel] text]]){
        if ([[[self.box5 titleLabel] text] isEqualToString:[[self.box9 titleLabel] text]]){
            return YES;}}
    if ([[[self.box3 titleLabel] text] isEqualToString:[[self.box5 titleLabel] text]]) {
        if ([[[self.box5 titleLabel] text] isEqualToString:[[self.box7 titleLabel] text]]){
            return YES;}}
    return NO;
}

-(IBAction) boardreset{
    [self.box1 setTitle:nil forState:UIControlStateNormal];
    [self.box1 titleLabel].text=nil;
    [self.box2 setTitle:nil forState:UIControlStateNormal];
    [self.box2 titleLabel].text=nil;
    [self.box3 setTitle:nil forState:UIControlStateNormal];
    [self.box3 titleLabel].text=nil;
    [self.box4 setTitle:nil forState:UIControlStateNormal];
    [self.box4 titleLabel].text=nil;
    [self.box5 setTitle:nil forState:UIControlStateNormal];
    [self.box5 titleLabel].text=nil;
    [self.box6 setTitle:nil forState:UIControlStateNormal];
    [self.box6 titleLabel].text=nil;
    [self.box7 setTitle:nil forState:UIControlStateNormal];
    [self.box7 titleLabel].text=nil;
    [self.box8 setTitle:nil forState:UIControlStateNormal];
    [self.box8 titleLabel].text=nil;
    [self.box9 setTitle:nil forState:UIControlStateNormal];
    [self.box9 titleLabel].text=nil;
    self->whoseTurn=1;
    self->countTurn=0;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    whoseTurn=1;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
