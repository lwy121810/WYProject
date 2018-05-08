//
//  ViewController.m
//  WYProject
//
//  Created by lwy1218 on 16/8/27.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "ViewController.h"
#import "ResponderViewController.h"
#import "DemoVc3ViewController.h"
#import "DemoVc4.h"
#import "WYDemoVC5.h"
#import "Demo6.h"
#import "DemoVC7.h"
#import "DemoVC8.h"
#import "Demo9.h"
#import "DemoVC10.h"
#import "DemoVC11.h"
#import "DemoVC12.h"
#import "Demo14.h"
#import "Demo15.h"
#import "NSDate+WYExtension.h"
#import "User.h"

@interface ViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSArray *dataArray;
@end
static NSString *cellID = @"tableViewCell";
@implementation ViewController
- (NSArray *)dataArray
{
    if (!_dataArray) {
        NSString *title = @"title";
        NSString *content = @"content";
        NSString *vc = @"vc";
        self.dataArray = @[@{title:@"DemoVC1",content:@"使用shareSDK进行第三方登录", vc:@"DemoVC1"},
                           @{title:@"DemoVC2",content:@"响应者链学习 未完...", vc:@"ResponderViewController"},
                           @{title:@"DemoVC3",content:@"绘画板--并保存image", vc:@"DemoVc3ViewController"},
                           @{title:@"DemoVc4" , content:@"粒子动画",vc:@"DemoVc4"},
                           @{title:@"DemoVC5" , content:@"城市选择器 可自由定义显示的列数 1~3列",vc:@"WYDemoVC5"},
                           @{title:@"Demo6" , content:@"动画 扇形按钮展开 波纹动画",vc:@"Demo6"},
                           @{title:@"DemoVC7" , content:@"地图学习 用户定位 地理编码与反编码",vc:@"DemoVC7"},
                           @{title:@"DemoVC8" , content:@"地图学习 用户定位 地理编码与反编码",vc:@"DemoVC8"},
                           @{title:@"Demo9" , content:@"圆形进度, 只有两列的时间选择器",vc:@"Demo9"},
                           @{title:@"DemoVC10" , content:@"瀑布流",vc:@"DemoVC10"},
                           @{title:@"DemoVC11" , content:@"地图学习-- 画线",vc:@"DemoVC11"},
                           @{title:@"DemoVC12" , content:@"导航栏渐变效果  网上找的demo（1️⃣）",vc:@"DemoVC12"},
                           @{title:@"DemoVC13" , content:@"使用GSK实现tableView的header的动画",vc:@"DemoVC13"},
                           @{title:@"Demo14" , content:@"导航渐变demo（二）",vc:@"Demo14"},
                           @{title:@"Demo15" , content:@"图片的点击放大",vc:@"Demo15"}
                           
                           
                           ];
    }
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    
    User *user = [[User alloc] initWithUserBuilder:^(UserBuilder *builder) {
        builder.name = @"lwy";
        builder.age = 90;
    }];
    
    NSLog(@"name: %@, age: %ld", user.name, user.age);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.contentView.backgroundColor = [UIColor redColor];
    NSDictionary *infoDict = self.dataArray[indexPath.row];
    
    NSString *titleKey = @"title";
    NSString *contentKey = @"content";
    
    NSString *title = infoDict[titleKey];
    NSString *content = infoDict[contentKey];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = content;
    cell.contentView.backgroundColor = self.tableView.backgroundColor;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDate *date = [NSDate wy_dateWithYear:2018 month:5 day:10];
    NSDate *now = [NSDate date];
    
    NSArray *dates = [now betweenDaysWithOtherDate:date];
    
    NSLog(@"%@",dates);
//    NSString *vcKey = @"vc";
//    NSString *title = @"title";
//
//    NSDictionary *infoDict = self.dataArray[indexPath.row];
//
//    NSString *vcName = infoDict[vcKey];
//
//    Class targetClass = NSClassFromString(vcName);
//    UIViewController * targetVc = [[targetClass alloc] init];
//    targetVc.title = [infoDict valueForKey:title];
//    [self.navigationController pushViewController:targetVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
