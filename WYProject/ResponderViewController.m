//
//  ResponderViewController.m
//  WYProject
//
//  Created by lwy1218 on 16/8/29.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "ResponderViewController.h"
#import "ResponderView.h"
@interface ResponderViewController ()
@property (nonatomic , strong) ResponderView *responderView;
@end

@implementation ResponderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];

    ResponderView *responderView = [[ResponderView alloc] initWithFrame:CGRectMake(64, 100, 200, 200)];
    [self.view addSubview:responderView];
    responderView.backgroundColor  = [UIColor yellowColor];
    self.responderView = responderView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [responderView addGestureRecognizer:tap];
}
- (void)tap
{
    NSLog(@"tap");
}
//UITouch代表点击对象 UIEvent代表事件对象
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [super touchesBegan:touches withEvent:event];
//    UIResponder *next = [self nextResponder];
//    while (next != nil) {
//        next = [next nextResponder];
//    }

    //事件类型
//   UIEventType type = event.type;
//    //事件产生时间
//    NSTimeInterval timestamp = event.timestamp;
//    
//    UITouch *touch = nil;
//    //返回值 point代表触摸在view上的位置 如果是nil的话返回的是触摸点在UIWindow的位置
//    CGPoint point = [touch locationInView:nil];
//    //记录前一个触摸点的位置
//    CGPoint previousPoint = [touch previousLocationInView:nil];
//    NSLog(@"ResponderViewController touchesBegan");
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
