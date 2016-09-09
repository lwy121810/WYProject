//
//  DemoVc3ViewController.m
//  WYProject
//
//  Created by lwy1218 on 16/8/30.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "DemoVc3ViewController.h"
#import "DrawImageView.h"
@interface DemoVc3ViewController ()
@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic , strong) DrawImageView *customView;
@end

@implementation DemoVc3ViewController
- (IBAction)saveImage:(id)sender {
    UIGraphicsBeginImageContext(self.customView.size);
    [self.customView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    self.imageView.image = image;
}
- (IBAction)backView:(id)sender {
    [self.customView backView];
}
- (IBAction)clearView:(id)sender {
    [self.customView clearView];
}
- (DrawImageView *)customView
{
    if (!_customView) {
        self.customView = [[DrawImageView alloc] initWithFrame:CGRectMake(100, 150, 300, 300)];
        [self.view addSubview:_customView];
        self.customView.backgroundColor = [UIColor yellowColor];
        self.customView.lineColor = [UIColor greenColor];
        self.customView.lineWidth = 5;
    }
    return _customView;
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 450, 200, 200)];
        [self.view addSubview:_imageView];
        _imageView.layer.borderColor = [UIColor greenColor].CGColor;
        _imageView.layer.borderWidth = 2;
    }
    return _imageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customView];
    [self imageView];
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
