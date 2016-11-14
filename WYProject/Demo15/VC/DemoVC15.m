//
//  DemoVC15.m
//  WYProject
//
//  Created by lwy1218 on 16/11/14.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "DemoVC15.h"
#import "WYManagerNavController.h"


@interface DemoVC15 ()

@end

@implementation DemoVC15

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupMainData];
}

- (void)setupMainData
{
    NSMutableArray *viewCs = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    
    
    for (int i = 0; i < 7; i++) {
        UIViewController *contentVc = [[UIViewController alloc] init];
   
        //标记下标 区别是哪个控制器
        NSString *title = [NSString stringWithFormat:@"标题%d", i];
        [viewCs addObject:contentVc];
        contentVc.view.backgroundColor = [UIColor randomColor];
        [titles addObject:title];
        
    }
    
    WYManagerNavController *manager = [[WYManagerNavController alloc] initWithViewControllers:viewCs];
    [self addChildViewController:manager];
    manager.view.frame = self.view.bounds;
    manager.view.y = 64;
    [self.view addSubview:manager.view];
    //设置标题
    [manager setupTitles:titles];
    
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
