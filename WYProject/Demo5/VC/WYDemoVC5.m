//
//  WYDemoVC5.m
//  WYProject
//
//  Created by lwy1218 on 16/9/9.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "WYDemoVC5.h"
#import "WYAreaChooseView.h"
@interface WYDemoVC5 ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic , strong) WYAreaChooseView *areaView;
@end

@implementation WYDemoVC5
- (WYAreaChooseView *)areaView
{
    if (!_areaView) {
        WYAreaChooseView *area = [[WYAreaChooseView alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 0)];
        [self.view addSubview:area];
        self.areaView = area;
    }
    return _areaView;
}
- (IBAction)start:(UIButton *)sender {
    self.areaView.hidden = NO;
    
    __weak typeof(self)weakSelf = self;
    self.areaView.selectRowBlock = ^(NSInteger index , NSString *text){
        if (index == 0) {//取消
            NSLog(@"取消");
        }else if (index == 1){//确定
            NSLog(@"确定");
            weakSelf.textLabel.text = text;
        }
    };
}
- (IBAction)one:(id)sender {
    self.areaView.numberOfComponents = 1;
}
- (IBAction)two:(id)sender {
    self.areaView.numberOfComponents = 2;
}
- (IBAction)three:(id)sender {
    self.areaView.numberOfComponents = 3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
