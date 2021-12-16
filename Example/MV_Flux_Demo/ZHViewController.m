//
//  ZHViewController.m
//  MV_Flux_Demo
//
//  Created by itxiansheng on 12/13/2021.
//  Copyright (c) 2021 itxiansheng. All rights reserved.
//

#import "ZHViewController.h"

@interface ZHViewController ()

@property (nonatomic,strong) NSArray *itemList;

@end

@implementation ZHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.itemList = @[@{@"MVC":@"ZHMVCController"},
                      @{@"MVVM":@"ZHMVVMController"},
                      @{@"MVP":@"ZHMVPController"},
                      @{@"FLUX":@"STADVideoPlayerViewController"}
                     ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSDictionary *dict = self.itemList[indexPath.row];
    cell.textLabel.text = dict.allKeys[0];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.itemList[indexPath.row];
    NSString *className = dict.allValues[0];
    Class vcClass = NSClassFromString(className);
    UIViewController *vc = [[vcClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
