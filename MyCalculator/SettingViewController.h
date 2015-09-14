//
//  SettingViewController.h
//  MyCalculator
//
//  Created by RunliSong on 15/5/20.
//  Copyright (c) 2015年 zixiao zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITabBarControllerDelegate>

- (IBAction)themeColor:(UISegmentedControl *)sender;

@property (nonatomic) NSInteger selection;
@end
