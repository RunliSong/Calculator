//
//  ViewController.h
//  MyCalculator
//
//  Created by zhu on 28/04/2015.
//  Copyright (c) 2015 zixiao zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalStack.h"
#import "NSMutableArray+Stack.h"

@interface ViewController : UIViewController <UITabBarControllerDelegate>
{
    NSMutableArray *nsArray;
    double currentNum;
    NSString *currentOP;
   
    NSMutableArray *digitStack;
    NSMutableArray *operationStack;
    NSMutableArray *resultStack;
    NSMutableArray *right;
    
}
@property (nonatomic)  NSMutableArray *records;
@property (nonatomic) NSInteger color;

//digital buttons pressing
- (IBAction)digiPressed:(id)sender;
//operational buttons pressing
- (IBAction)operatePressed:(id)sender;
//result button pressing
- (IBAction)enterPressed:(id)sender;
//clear button pressing
-(IBAction)clearPressed:(id)sender;
-(IBAction)displayRecords:(id)sender;

-(IBAction)pmPressed:(id)sender;
-(int)isWhat:(NSString *) current;
-(double)getValue:(NSString *)NUM1 and:(NSString *)NUM2 and:(int) operation;
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak,nonatomic) IBOutlet UILabel *process;
@property (nonatomic, retain) NSMutableArray *nsArray;
- (BOOL)isHigh:(NSString *)top_op andAnother:(NSString *)InfixExp_op;

@end

