//
//  ViewController.m
//  MyCalculator
//
//  Created by zhu on 28/04/2015.
//  Copyright (c) 2015 zixiao zhu. All rights reserved.
//


#import "ViewController.h"
#import "RecordViewController.h"

@interface ViewController ()
//declare a private attribute to tell entering process
@property  (nonatomic) BOOL isEntering;
@end

@implementation ViewController
@synthesize display = _display;
@synthesize isEntering=_isEntering;
@synthesize process=_process;
@synthesize nsArray;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    switch (_color) {
        case 0:
            self.view.backgroundColor = [UIColor blueColor];
            break;
        case 1:
            self.view.backgroundColor = [UIColor yellowColor];
            break;
        case 2:
            self.view.backgroundColor = [UIColor redColor];
            break;
        default:
            self.view.backgroundColor = [UIColor grayColor];
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    nsArray = [[NSMutableArray alloc] init];
    _records = [[NSMutableArray alloc] init];
    digitStack = [[NSMutableArray alloc] init ];
    operationStack = [[NSMutableArray alloc] init ];
    resultStack=[[NSMutableArray alloc] init ];
    right=[[NSMutableArray alloc] init ];
    self.tabBarController.delegate = self;
    
}

-(IBAction)clearPressed:(UIButton *)sender {
    self.process.text=@"";
    self.display.text=@"0";
    [digitStack clear];
    [operationStack clear];
    [right clear];
}





- (IBAction)digiPressed:(UIButton *)sender {
    if([self.process.text hasSuffix:@"="])
    {
        self.process.text=@"";
        self.display.text=@"";
        [digitStack clear];
        [operationStack clear];
        [right clear];
        self.isEntering=YES;
    }
    self.process.text=[self.process.text stringByAppendingString:[sender currentTitle]];
    //executing as digits entered
    if(self.isEntering==YES)
    {
        //if it was already entering
        if([_display.text length]<12)
        {
            //if entered digits less than 12
            self.display.text = [self.display.text stringByAppendingString:[sender currentTitle]];
            //appending entered digits and displaying
        }else{
            //if digits were over 12 returning
            return;
        }
        
    }else{//if it was not in entering
        //display current text
        self.display.text=[sender currentTitle];
        self.isEntering=YES;
    }
    
}



-(IBAction)pmPressed:(UIButton *)sender {
    NSMutableString *pm = [[NSMutableString alloc] initWithString:self.display.text];
    NSString *replace;
    NSString *search;
    NSRange substr;
    
    if ([[self.display.text substringToIndex:1]isEqualToString:@"-"]) {
        search =@"-";
        replace = @"+";
        substr=[self.display.text rangeOfString:search];
        //if([[self.display.text substringToIndex:1]isEqualToString:@"-"])
        if(substr.location != NSNotFound)
        {
            [pm replaceCharactersInRange:substr withString:replace];
        }
        self.display.text=pm;
        
    }
    else{
        if([self.display.text hasPrefix:@"+"])
        {
            self.display.text=[@"-" stringByAppendingString:[self.display.text substringFromIndex:1]];
        }
        else
        {
            self.display.text=[@"-" stringByAppendingString:self.display.text];
        }
        
    }
    
    
    self.process.text=self.display.text;
    
}

//as operational buttons pressed
- (IBAction)operatePressed:(UIButton *)sender {
    //if result button pressed
    if([self.process.text hasSuffix:@"="])
    {
        //displaying text
        self.process.text=self.display.text;
        [digitStack clear];
        [operationStack clear];
        [right clear];
    }
    id top_op,InfixExp_op;
    self.process.text=[self.process.text stringByAppendingString:[sender currentTitle]];
    self.isEntering=NO;
    currentNum=[self.display.text doubleValue];
    
    //if brackets used in calculating
    if([[sender currentTitle] isEqualToString:@"("])
    {
        [operationStack push:[sender currentTitle]];
    }
    else if([[sender currentTitle] isEqualToString:@")"] && [operationStack containsObject:@"("])///////----///////
    {
        [right push:@")"];
        [digitStack push:self.display.text];
        //put the symbols between two digits in right calculating orders
        while(![[operationStack peek] isEqualToString:@"("])
        {
            [digitStack push:[operationStack pop]];
            NSLog(@"digitStack: %@",digitStack);
            NSLog(@"operationStack: %@",operationStack);
        }
        [operationStack pop];
        NSLog(@"operationStack: %@",operationStack);
    }
    else//if there is no brackets involved
    {
        NSLog(@"self.display.text: %@",self.display.text);
        if([right count]==0)
        {
            [digitStack push:self.display.text];
        }
        else
            [right pop];
        
        if([operationStack count] > 0)
        {
            top_op=[operationStack peek];
            InfixExp_op=[sender currentTitle];
            //tell the calculating priorities
            while([self isHigh:top_op andAnother:InfixExp_op]==true && [operationStack count] > 0 )
            {
                [digitStack push:[operationStack pop]];
                
                if([operationStack count] > 0){
                    top_op=[operationStack peek];
                }
                
                
                
            }
        }
        [operationStack push:[sender currentTitle]];
        
    }
   
    
}

- (IBAction)enterPressed:(id)sender {
    
    if([operationStack count]==0||[self.process.text length]==0||[self.process.text hasSuffix:@"="]){
        return;
    }
    self.process.text=[self.process.text stringByAppendingString:[sender currentTitle]];
    NSString *result;
    //press result button
    self.isEntering=NO;
    if([right count]==0)
    {
        [digitStack push:self.display.text];
    }
    while ([operationStack count] > 0) {
        [digitStack push:[operationStack pop]];
    }
    NSLog(@"digitStack: %@",digitStack);
    while([digitStack count]>0){
        if([self isWhat:[digitStack peekAtHead]]==5)
        {
            [resultStack push:[digitStack popAtHead]];
            NSLog(@"resultStack: %@",resultStack);
        }
        else
        {
            //while([resultStack count]!=1&&[digitStack count]>0)
            // {
            result = [NSString stringWithFormat:@"%f",[self getValue:[resultStack pop] and:[resultStack pop]and:[self isWhat:[digitStack popAtHead]]]];
            [resultStack push:result];
            //}
        }
    }
    NSLog(@"resultStack: %@",resultStack);
    NSLog(@"resultStack: %@",[[resultStack peek]substringFromIndex: [[resultStack peek] length]-6]);
    if([[[resultStack peek]substringFromIndex: [[resultStack peek] length]-6]isEqualToString:@"000000"])
    {
        self.display.text=[[resultStack peek]substringToIndex: [[resultStack peek] length]-7] ;
    }
    else
    {
        self.display.text=[resultStack pop];
    }
    [_records addObject:[_process.text stringByAppendingString:_display.text]];//test
    
}

-(BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[RecordViewController class]]) {
        RecordViewController *rvc = (RecordViewController *) viewController;
        rvc.record = _records;
    }
    return true;
}

//tell what the symbol is between the digits
-(int)isWhat:(NSString *) current{
    if([current isEqualToString:@"+"]) return 1;
    if([current isEqualToString:@"-"]) return 2;
    if([current isEqualToString:@"x"]) return 3;
    if([current isEqualToString:@"÷"]) return 4;
    else  return 5;
}


//always calculating result between two digits
-(double)getValue:(NSString *)NUM1 and:(NSString *)NUM2 and:(int) operation{
    
    double num2=[NUM1 doubleValue];
    double num1=[NUM2 doubleValue];
    switch (operation) {
        case 1:
            return num1+num2;
            break;
        case 2:
            return num1-num2;
            break;
        case 3:
            return num1*num2;
            break;
        case 4:
            return num1/num2;
            break;
        default:
            break;
    }
    return 0;
}

//tell priority of calculating sybmbols
- (BOOL)isHigh:(NSString *)top_op andAnother:(NSString *)InfixExp_op{
    if ([top_op isEqualToString:@"+"] && [InfixExp_op isEqualToString:@"+"]) return true;
    if ([top_op isEqualToString:@"+"] && [InfixExp_op isEqualToString:@"-"]) return true;
    if ([top_op isEqualToString:@"-"] && [InfixExp_op isEqualToString:@"+"]) return true;
    if ([top_op isEqualToString:@"-"] && [InfixExp_op isEqualToString:@"-"]) return true;
    if ([top_op isEqualToString:@"x"] && [InfixExp_op isEqualToString:@"+"]) return true;
    if ([top_op isEqualToString:@"x"] && [InfixExp_op isEqualToString:@"-"]) return true;
    if ([top_op isEqualToString:@"x"] && [InfixExp_op isEqualToString:@"x"]) return true;
    if ([top_op isEqualToString:@"x"] && [InfixExp_op isEqualToString:@"÷"]) return true;
    if ([top_op isEqualToString:@"÷"] && [InfixExp_op isEqualToString:@"+"]) return true;
    if ([top_op isEqualToString:@"÷"] && [InfixExp_op isEqualToString:@"-"]) return true;
    if ([top_op isEqualToString:@"÷"] && [InfixExp_op isEqualToString:@"x"]) return true;
    if ([top_op isEqualToString:@"÷"] && [InfixExp_op isEqualToString:@"÷"]) return true;
    if ([InfixExp_op isEqualToString:@")"]) return true;
    return false;        }

@end

