//
//  ViewController.m
//  CustomNavicationController
//
//  Created by YiJiang Chen on 15/10/21.
//  Copyright (c) 2015年 YiJiang Chen. All rights reserved.
//

#import "Demo14.h"
#import "UINavigationBar+Background.h"
#import "DescriptionView.h"

#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface Demo14 ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic)  UITableView *tableView;
@property (nonatomic) CGFloat halfHeight;
@property (nonatomic, strong) DescriptionView *descriptionView;
@end

@implementation Demo14

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
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CustomCell"];
    _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    //_tableView.rowHeight = 90;
    //CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    _halfHeight = (kScreenHeight) * 0.5 - 64;
    [_tableView setContentInset:UIEdgeInsetsMake(_halfHeight, 0, 0, 0)];
    
    _descriptionView = [[NSBundle mainBundle] loadNibNamed:@"DescriptionView" owner:nil options:nil][0];
    _descriptionView.frame = CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), 42);
    //[[DescriptionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 42)];
    [self.view addSubview:_descriptionView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//导航栏的背景色是黑色, 字体为白色
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar cnReset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor *color = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= - _halfHeight - 64) {
        CGFloat alpha = MIN(1, (_halfHeight + 64 + offsetY)/_halfHeight);
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
        _descriptionView.alpha = 1 - alpha;
    } else {
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"text";
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 65;
//}

@end
