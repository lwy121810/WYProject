//
//  Demo9.m
//  WYProject
//
//  Created by lwy1218 on 16/9/26.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "Demo9.h"
#import "WYProgressView.h"
#import "SRMonthPicker.h"
@interface Demo9 ()<UIPickerViewDelegate>
{
    WYProgressView *_progress;
}
@property (nonatomic , weak) SRMonthPicker *pickerView;
@end

@implementation Demo9

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = CGRectMake(30, 100, 100, 100);
    
    WYProgressView *progress =  [[WYProgressView alloc] initWithFrame:frame withProgressCurrentColor:nil progressUnfinishColor:nil];
    [self.view addSubview:progress];
    //    progress.showRing = YES;
    progress.ringWidth = 6;
    progress.circleBackgroundColor = [UIColor grayColor];
    _progress = progress;
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    [start setFrame:CGRectMake(30, 300, 60, 30)];
    [start setTitle:@"start" forState:UIControlStateNormal];
    [start addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [start setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:start];
    
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeCustom];
    [stop setFrame:CGRectMake(200, 300, 60, 30)];
    [stop setTitle:@"stop" forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    [stop setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:stop];
    
   
    CGRect pickerFrame = CGRectMake(0, 400, self.view.width, 150);
    SRMonthPicker *picker = [[SRMonthPicker alloc] initWithDate:[NSDate date]];
    picker.frame = pickerFrame;
    picker.maximumYear = @2016;
    picker.yearFirst = YES;
    picker.delegate = self;
    [self.view addSubview:picker];
    self.pickerView = picker;
    
    
    
}

- (void)start:(UIButton *)sender
{
    [_progress start];
}
- (void)stop:(UIButton *)sender
{
    [_progress stop];
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
