//
//  NSMutableArray+Stack.h
//  MyCalculator
//
//  Created by zhu on 7/05/2015.
//  Copyright (c) 2015 zixiao zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (calStack)
-(void)push:(NSObject*)parm;
-(id)peek;
-(id)pop;
-(void) insertAtHead:(NSObject*)param;
-(id) peekAtHead;
-(id) popAtHead;
-(void)clear;
@end
