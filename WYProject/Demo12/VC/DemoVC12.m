//
//  DemoVC12.m
//  WYProject
//
//  Created by lwy1218 on 16/10/17.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "DemoVC12.h"
#import "MXNavigationBarManager.h"
#import "GradientTableViewController.h"
#import "TranslateTableViewController.h"
#import "MutationTableViewController.h"
#import "ReversalTableViewController.h"


static NSString *const menuCellIdentifer = @"menuCellIdentifer";
@interface DemoVC12 ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DemoVC12

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.delegate = self;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 100;
        
        self.tableView = tableView;
    }
    return _tableView;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    [MXNavigationBarManager reStoreWithFullStatus];
    self.tableView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Menu";
    _titles = @[@"全透明导航栏",
                @"渐变导航栏",
                @"突变导航栏",
                @"颜色反转导航栏"];
    _viewControllers = @[[TranslateTableViewController class],
                         [GradientTableViewController class],
                         [MutationTableViewController class],
                         [ReversalTableViewController class]];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:menuCellIdentifer];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifer
                                                            forIndexPath:indexPath];
    cell.textLabel.text = _titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[_viewControllers[indexPath.row] new] animated:YES];
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

@end
