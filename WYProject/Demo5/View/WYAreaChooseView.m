//
//  WYAreaChooseView.m
//  yibolai
//
//  Created by lwy1218 on 16/9/8.
//  Copyright © 2016年 liangang. All rights reserved.
//

#import "WYAreaChooseView.h"


@interface WYAreaChooseView ()<UIPickerViewDataSource , UIPickerViewDelegate>
@property (nonatomic , strong) UIPickerView *pickerView;
//data
@property (strong,nonatomic) NSDictionary *pickerDic;
/**省数据数组*/
@property (strong,nonatomic) NSArray *provinceDatas;
/**市数据数组*/
@property (strong,nonatomic) NSArray *cityDatas;
/**区县数据数组*/
@property (strong,nonatomic) NSArray *townDatas;
/** 选择数组*/
@property (strong,nonatomic) NSArray *selectedArray;
@end
@implementation WYAreaChooseView

- (NSArray *)provinceDatas
{
    if (!_provinceDatas) {
        self.provinceDatas = [NSArray array];
    }
    return _provinceDatas;
}
- (NSArray *)cityDatas
{
    if (!_cityDatas) {
        self.cityDatas = [NSArray array];
    }
    return _cityDatas;
}
- (NSArray *)townDatas
{
    if (!_townDatas) {
        self.townDatas = [NSArray array];
    }
    return _townDatas;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self getdata];
        _numberOfComponents = 2;
        [self setup];
    }
    return self;
}
- (UIButton *)createButtonWithTag:(NSInteger)tag title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    if (tag ==    350) {//取消
        button.wy_titleColor_Normal = [UIColor lightGrayColor];
    }else if (tag == 351)//确定
    {
        button.wy_titleColor_Normal = [UIColor redColor];
    }
    [button wy_addTarget:self action:@selector(buttonAction:)];
    button.wy_title_Normal = title;
    return button;
}
//按钮的点击事件
- (void)buttonAction:(UIButton *)sender
{
    NSInteger index = sender.tag - 350;
    NSArray *allDatas = [NSArray arrayWithObjects:self.provinceDatas , self.cityDatas , self.townDatas, nil];
    NSInteger selectComponent = 0;
    NSInteger selectRow = 0;
    NSString *title = @"";
    while (selectComponent < _numberOfComponents) {
        selectRow = [self.pickerView selectedRowInComponent:selectComponent];
        NSArray *arr = allDatas[selectComponent];
        if (arr.count > 0) {
            NSString *text = [arr objectAtIndex:selectRow];
            title = [title stringByAppendingString:[NSString stringWithFormat:@"--%@" , text]];
        }
        selectComponent++;
    }
    if (self.selectRowBlock) {
        self.selectRowBlock(index, title);
    }
}
- (void)setup
{
    UILabel *titleLabel =[[UILabel alloc] init];
    UIButton *cancel = [self createButtonWithTag:350 title:@"取消"];
    UIButton *done = [self createButtonWithTag:351 title:@"确定"];
    [self wy_addSubviews:@[titleLabel , cancel , done]];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"所在城市";
    titleLabel.frame = CGRectMake(0, 0, self.width, 35);
    self.pickerView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame), self.width, 200);
    
    CGFloat w = self.width * 0.5;
    CGFloat y = CGRectGetMaxY(self.pickerView.frame);
    CGFloat h = 35;
    cancel.frame = CGRectMake(0, y, w, h);
    done.frame = CGRectMake(w, y, w, h);
    
    self.height = CGRectGetMaxY(cancel.frame);
}
- (void)getdata{
    //得到数据
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *firstDatas = [self.pickerDic allKeys];
    /**得到省级数据*/
    self.provinceDatas = firstDatas;
    /**选中的数据数组*/
    self.selectedArray = [self.pickerDic objectForKey:[firstDatas objectAtIndex:0]];
    if (self.selectedArray.count>0) {
        self.cityDatas = [[self.selectedArray objectAtIndex:0]allKeys];
    }
    if (self.cityDatas.count>0) {
        self.townDatas = [[self.selectedArray objectAtIndex:0]allKeys];
    }
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        UIPickerView *picker = [[UIPickerView alloc] init];
        picker.delegate = self;
        picker.dataSource = self;
        [self addSubview:picker];
        _pickerView = picker;
    }
    return _pickerView;
}
- (void)setNumberOfComponents:(NSInteger)numberOfComponents
{
    if (numberOfComponents < 1) {
        numberOfComponents = 1;
    }
    if (numberOfComponents > 3) {
        numberOfComponents = 3;
    }
    _numberOfComponents = numberOfComponents;
    [self.pickerView reloadAllComponents];
}
#pragma mark -UIPickerViewDelegate
/**列数*/
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _numberOfComponents;
}
/**每列多少行*/
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceDatas.count;
    }else if(component ==1){
        return self.cityDatas.count;
    }else{
        return self.townDatas.count;
    }
}
/**显示数据*/
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [self.provinceDatas objectAtIndex:row];
    }else if (component==1){
        return [self.cityDatas objectAtIndex:row];
    }else{
        return [self.townDatas objectAtIndex:row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.provinceDatas.count <= 0) {
        return;
    }
    if (component==0) {//第一列 选中
        //取出选中的省
        NSString *provinceName = [self.provinceDatas objectAtIndex:row];
        //selectedArray 取出对应省的数据 是一个包含字典的数组 只有一个字典对象 字典的key就是城市数据 key对应的value是一个包含县/区的字符的数组
        self.selectedArray = [self.pickerDic objectForKey:provinceName];
        //取出数据 该字典key是城市名称
        NSDictionary *cityData = self.selectedArray.firstObject;
        if (self.selectedArray.count > 0) {
            //取出该省所有的城市数据
            self.cityDatas = [cityData allKeys];
            
        } else {
            self.cityDatas = nil;
        }
        if (self.cityDatas.count > 0) {//如果有城市数据
            //取出第一个城市的名字
            NSString *firstCityName = [self.cityDatas objectAtIndex:0];
            //取出区/县的数据 cityDatakey对应的value就是该城市的县/区数据
            self.townDatas = [cityData objectForKey:firstCityName];
        } else {//没有城市数据 说明也就没有下级的县/区数据
            self.townDatas = nil;
        }
    }
    if (component==1){//城市数据的那一列
        if (self.selectedArray.count > 0 && self.cityDatas.count > 0) {
            //取出选中的城市
            NSString *selectCity = [self.cityDatas objectAtIndex:row];
            //取出对应城市的县/区数据
            self.townDatas = [self.selectedArray.firstObject objectForKey:selectCity];
        } else {
            self.townDatas = nil;
        }
    }
    while (component < _numberOfComponents - 1) {//如果不是最后一列 刷新后几列的数据
        [pickerView selectedRowInComponent:component + 1];
        [pickerView reloadComponent:component + 1];
        component++;
    }
}

@end
