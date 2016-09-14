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
                           @{title:@"DemoVC2",content:@"", vc:@"ResponderViewController"},
                           @{title:@"DemoVC3",content:@"绘画板--并保存image", vc:@"DemoVc3ViewController"},
                           @{title:@"DemoVc4" , content:@"粒子动画",vc:@"DemoVc4"},
                           @{title:@"DemoVC5" , content:@"城市选择器 可自由定义显示的列数 1~3列",vc:@"WYDemoVC5"},
                           @{title:@"Demo6" , content:@"动画 扇形按钮展开 波纹动画",vc:@"Demo6"},
                           @{title:@"DemoVC7" , content:@"地图学习 用户定位 地理编码与反编码",vc:@"DemoVC7"},
                           @{title:@"DemoVC8" , content:@"地图学习 用户定位 地理编码与反编码",vc:@"DemoVC8"}
                           ];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
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
    
    NSString *vcKey = @"vc";
    NSDictionary *infoDict = self.dataArray[indexPath.row];
    
    NSString *vcName = infoDict[vcKey];
    
    Class targetClass = NSClassFromString(vcName);
    id targetVc = [[targetClass alloc] init];
    [self.navigationController pushViewController:targetVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
