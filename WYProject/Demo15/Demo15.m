//
//  Demo15.m
//  WYProject
//
//  Created by lwy on 2018/2/28.
//  Copyright © 2018年 lwy1218. All rights reserved.
//

#import "Demo15.h"
#import "WYImageBrowserView.h"

@interface Demo15 ()

@property (nonatomic , strong) WYImageBrowserView *imageView;
@end

@implementation Demo15

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)click:(UIButton *)sender {
    if (!_imageView) {
        UIImage *high = [UIImage imageNamed:@"highImage"];
        WYImageBrowserView *imageView = [[WYImageBrowserView alloc] initWithOriginImage:sender.imageView.image highlightedImage:high fromRect:sender.frame];
        imageView.maximumZoomScale = 4;
        _imageView = imageView;
        
    }
    [_imageView showInView:nil];
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
