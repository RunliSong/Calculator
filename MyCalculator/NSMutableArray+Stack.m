//
//  NSMutableArray+Stack.m
//  MyCalculator
//
//  Created by zhu on 7/05/2015.
//  Copyright (c) 2015 zixiao zhu. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (calStack)

-(void)push:(NSObject*)parm
{
    //    NSMutableArray * nsmary = [[NSMutableArray alloc] init];
    [self addObject:parm];
}

-(id)peek
{   NSObject*item = [self objectAtIndex:([self count]-1)];
    return  item;
}



-(id)pop
{
    NSObject*item = [self peek];
    [self removeObjectAtIndex:([self count]-1)];
    return  item;
}



-(void) insertAtHead:(NSObject*)param
{
    [self insertObject:param atIndex:0];
}
-(id) peekAtHead
{
    NSObject *item = [self objectAtIndex:0];
    return  item;
    
}

-(id) popAtHead
{
    NSObject*item = [self peekAtHead];
    [self removeObjectAtIndex:0];
    return  item;
}


-(void)clear
{
    [self removeAllObjects];
}

@end
