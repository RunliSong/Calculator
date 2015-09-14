//
//  RecordViewController.h
//  MyCalculator
//
//  Created by RunliSong on 15/5/14.
//  Copyright (c) 2015年 zixiao zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) NSMutableArray *record;
@end
