//
//  SettingViewController.m
//  MyCalculator
//
//  Created by RunliSong on 15/5/20.
//  Copyright (c) 2015年 zixiao zhu. All rights reserved.
//

#import "SettingViewController.h"
#import "ViewController.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorControl;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[ViewController class]]) {
        ViewController *rvc = (ViewController *) viewController;
        rvc.color = _selection;
    }
    return true;
}


- (IBAction)themeColor:(UISegmentedControl *)sender {
    switch (self.colorControl.selectedSegmentIndex) {
        case 0:
            self.view.backgroundColor = [UIColor blueColor];
            _selection = 0;
            break;
        case 1:
            self.view.backgroundColor = [UIColor yellowColor];
            _selection = 1;
            break;
        case 2:
            self.view.backgroundColor = [UIColor redColor];
            _selection = 2;
            break;
        default:
            self.view.backgroundColor = [UIColor grayColor];
            break;
    }

}
@end
