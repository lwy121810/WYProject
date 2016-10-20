//
//  GSKScaleLabelViewController.m
//  Example
//
//  Created by lwy1218 on 16/10/19.
//  Copyright © 2016年 Jose Alcalá Correa. All rights reserved.
//

#import "DemoVC13.h"
#import "WYScaleLabelView.h"
@interface DemoVC13 ()<UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic , strong) WYScaleLabelView *headerView;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIScrollView *scrollView;
@end
@implementation DemoVC13
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureExpandModeButton];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIScrollView *mainView = [[UIScrollView alloc] init];
//    [self.view addSubview:mainView];
//    mainView.frame = self.view.bounds;
//    
//    mainView.contentSize = CGSizeMake(0, mainView.frame.size.height * 2);
//    
//    mainView.backgroundColor = [UIColor blueColor];
    CGRect frame = CGRectMake(0, 0, self.tableView.frame.size.width, 320);
    
    self.headerView = [[WYScaleLabelView alloc] initWithFrame:frame];
    
//    [mainView addSubview:self.headerView];
    [self.tableView addSubview:self.headerView];
}
- (id)loadStretchyHeaderView
{
    CGRect frame = CGRectMake(0, 0, self.tableView.frame.size.width, 320);
    
    self.headerView = [[WYScaleLabelView alloc] initWithFrame:frame];
    
    return self.headerView;
}

- (void)configureExpandModeButton
{
    NSString *buttonTitle = self.headerView.expansionMode == GSKStretchyHeaderViewExpansionModeTopOnly ? @"Top only":@"Immediate";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:buttonTitle style:UIBarButtonItemStylePlain target:self action:@selector(switchExpandMode)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    [self gsk_setNavigationBarTransparent:YES animated:NO];
}
- (void)gsk_setNavigationBarTransparent:(BOOL)transparent
                               animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.33 : 0 animations:^{
        if (transparent) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                     forBarMetrics:UIBarMetricsDefault];
            self.navigationController.navigationBar.shadowImage = [UIImage new];
            self.navigationController.navigationBar.translucent = YES;
            self.navigationController.view.backgroundColor = [UIColor clearColor];
            self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
        } else {
            [self.navigationController.navigationBar setBackgroundImage:nil
                                     forBarMetrics:UIBarMetricsDefault];
        }
    }];
}
- (void)switchExpandMode
{
    switch (self.headerView.expansionMode) {
        case GSKStretchyHeaderViewExpansionModeTopOnly:
        {
            
            self.headerView.expansionMode =GSKStretchyHeaderViewExpansionModeImmediate;
        }
            break;
        case GSKStretchyHeaderViewExpansionModeImmediate:
        {
            
            self.headerView.expansionMode =GSKStretchyHeaderViewExpansionModeTopOnly;

        }
            break;
            
        default:
            break;
    }
    
    [self configureExpandModeButton];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UIColor *)randomColor {
    
    
    return [UIColor greenColor];
    
//    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.contentView.backgroundColor = [self randomColor];
    
    return cell;
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
