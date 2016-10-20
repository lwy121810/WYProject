//
//  GSKScaleLabelHeaderView.m
//  Example
//
//  Created by lwy1218 on 16/10/19.
//  Copyright © 2016年 Jose Alcalá Correa. All rights reserved.
//

#import "WYScaleLabelView.h"
#import "UIView+Extension.h"

@interface WYScaleLabelView ()
@property (nonatomic , weak) UIImageView *headerIcon;
@property (nonatomic , weak) UILabel *nameLabel;
@property (nonatomic , weak) UILabel *describeLabel;
@property (nonatomic , weak) UIButton *careButton;
@property (nonatomic , weak) UIButton *seriveButton;
@property (nonatomic , weak) UIButton *contentButton;
@end
@implementation WYScaleLabelView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (UILabel *)createLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
- (void)setup
{
    
    
    
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
    backImageView.frame = self.contentView.bounds;
    [self.contentView addSubview:backImageView];
    backImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIImageView *header = [[UIImageView alloc] init];
    header.image = [UIImage imageNamed:@"2.jpg"];
    CGFloat headerW = 100;
    CGFloat headerX = self.contentView.width * 0.5 - headerW * 0.5;
    header.frame = CGRectMake(headerX, 44, headerW, headerW);
    [self.contentView addSubview:header];
    self.headerIcon = header;
    header.clipsToBounds = YES;
    
    header.layer.cornerRadius = header.width * 0.5;
    header.borderColor = [UIColor yellowColor];
    header.borderWidth = 5;
    
    
    CGFloat minFontSize = 20;
    
    UILabel *label =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.height)];
//    label.autoresizingMask = [.flexibleWidth, .flexibleHeight];
    label.font = [UIFont monospacedDigitSystemFontOfSize:minFontSize weight:UIFontWeightMedium];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.text = @"Scale Text";
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.label = label;
    
    
    self.maximumContentHeight = self.frame.size.width;
    self.minimumContentHeight = 64;
    [self.contentView addSubview:self.label];
    
    UILabel *number = [self createLabel];
    number.text = @"粉丝数 500";
    number.frame = CGRectMake(0, self.label.y + self.label.height + 20, self.label.width, 40);
    [self.contentView addSubview:number];
    number.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    
    self.number = number;
    
    
    self.backgroundColor = [UIColor orangeColor];
//    label.backgroundColor = [UIColor yellowColor];
    self.contentView.backgroundColor = [UIColor blueColor];
}

- (UIButton *)createButtonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.tag = tag;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return button;
}
- (void)buttonAction:(UIButton *)sender
{
    
}
-(void)didChangeStretchFactor:(CGFloat)stretchFactor
{
    [super didChangeStretchFactor:stretchFactor];
        CGFloat minFontSize = 20;
    self.label.font = [UIFont monospacedDigitSystemFontOfSize:minFontSize weight:UIFontWeightMedium];
    self.number.y = self.contentView.height - self.number.height;
//    if (self.number.y <= self.minimumContentHeight) {
//        self.number.hidden = YES;
//    }else{
//        self.number.hidden = NO;
//    }
    CGFloat offset = self.number.y - self.headerIcon.y - self.headerIcon.height;
    if (offset < 10 && offset > 0) {
        self.headerIcon.y = self.number.y - 10 - self.headerIcon.height;
        self.headerIcon.alpha = stretchFactor;
    }else{
        self.headerIcon.y = 44;
        self.headerIcon.alpha = 1;
    }
    self.number.alpha = stretchFactor;
    
    NSLog(@"stretchFactor -- %.2f  number.y-- %.2f  self.minimumContentHeight ---  %.2f  contentView H --   %.2f self H ---   %.2f", stretchFactor, self.number.y, self.minimumContentHeight, self.contentView.height , self.height);
    NSLog(@"offset --  %.2f" , offset);
    
//    CGFloat fontSize = CGFloatTranslateRange(MIN(1, stretchFactor), 0, 1, minFontSize, maxFontSize );
//    if (fabs(fontSize - self.label.font.pointSize) > 0.05) {
//        self.label.font = [UIFont monospacedDigitSystemFontOfSize:fontSize weight:UIFontWeightMedium];
//    }
}
@end
