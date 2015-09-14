//
//  RecordViewController.m
//  MyCalculator
//
//  Created by RunliSong on 15/5/14.
//  Copyright (c) 2015年 zixiao zhu. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordTableViewCell.h"

@interface RecordViewController ()
- (IBAction)backButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *recordTableView;
@end

@implementation RecordViewController
{
    NSInteger selectedRecord;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self.recordTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_recordTableView registerNib:[UINib nibWithNibName:@"RecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"Record"];
    [[self recordTableView] setDataSource:self];
    [[self recordTableView] setDelegate:self];
    [self.recordTableView reloadData];
    _recordTableView.backgroundColor = [UIColor clearColor];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark table view methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_record.count != 0)
        return _record.count;
    else
        return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_record.count != 0)
    {
        RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Record" forIndexPath:indexPath];
        cell.recordDetail.text = [_record objectAtIndex:indexPath.item];
        return cell;
    }
    else
    {
         RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Record" forIndexPath:indexPath];
        cell.recordDetail.text = @"No record yet... ...";
       
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(_record.count != 0)
    {
        UIAlertView *deleteRecord = [[UIAlertView alloc] initWithTitle:@"Do you want to delete this record?" message:@"Press OK if yes..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [deleteRecord show];
        selectedRecord = indexPath.item;
    }

}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        [_recordTableView reloadData];
        
    }
    else
    {
        [_record removeObjectAtIndex:selectedRecord];
        [_recordTableView reloadData];
    }
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
