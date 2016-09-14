//
//  Demo6.m
//  WYProject
//
//  Created by lwy1218 on 16/9/14.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "Demo6.h"

@interface Demo6 ()
{
    WYButton *_button;
    
    
    NSArray *imageArray;
    double r ;
    /**
     *  弹出子按钮的个数
     */
    double numberItems ;
    BOOL isBig;
    double centerX;
    double centerY;
    BOOL isOpen;
    
    UIButton *_button1;
    UIButton *_button2;
    UIButton *_button3;
    UIButton *_button4;
}
@property (weak, nonatomic) IBOutlet UIButton *show;
@property (weak, nonatomic) IBOutlet UIButton *start;
@property (nonatomic,strong)UIView *testView1;
@property (nonatomic,strong)UIBezierPath *path;
@property (nonatomic,strong)NSMutableArray *btnArray;
@end

@implementation Demo6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //雷达，波纹效果
    [self setup];
    
    [self myTest];
    
    [self showProgress:1];
    
    _show.backgroundColor = [UIColor redColor];
    
    _show.wy_title_Normal = @"展开";
    _show.wy_title_Selected = @"收起";
    
    _btnArray=[[NSMutableArray alloc] init];
    [self createBtn:@[@"1",@"2",@"3",@"4",@"5"]];
    
    isBig = NO;
    isOpen = NO;
    numberItems = 4;
    r = 180;
    centerX = self.start.center.x;
    centerY = self.start.center.y;
    
   
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.start.backgroundColor = [UIColor yellowColor];
    UIButton *button = [self createButton:@"button1"];
    _button1 = button;
    
    UIButton *button2 = [self createButton:@"button2"];
    _button2 = button2;
    
    UIButton *button3 = [self createButton:@"button3"];
    _button3 = button3;
    
    UIButton *button4 = [self createButton:@"button4"];
    _button4 = button4;
    
    [self.view bringSubviewToFront:self.start];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (UIButton *)createButton:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:self.start.frame];
    [self.view addSubview:button];

    [button setBackgroundColor:[UIColor redColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)buttonAction:(UIButton *)sender
{
    NSLog(@"点击按钮");
}
//计算扇形坐标
- (NSMutableArray *)getXWithTanAngle:(double)tanAngle {
    double x;
    double y;
    NSMutableArray *locationArray = [[NSMutableArray alloc]init];
    /**
     sqrt:平方根函数
     */
    x = r / (sqrt(1 + tanAngle * tanAngle));
    y = tanAngle * x ;
    [locationArray addObject:[NSString stringWithFormat:@"%f",x]];
    [locationArray addObject:[NSString stringWithFormat:@"%f",y]];
    return locationArray;
}
- (IBAction)show:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self showBtn];
    }else{
        [self hiddenBtn];
    }
    
}

-(void)createBtn:(NSArray *)btnImageName{
    
    for (int i = 0 ; i < btnImageName.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(_show.x, _show.y, 38, 38);
        btn.backgroundColor=[UIColor lightGrayColor];
        btn.layer.cornerRadius=19;
        [btn setTitle:btnImageName[i] forState:UIControlStateNormal];
        btn.tag=i+1;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [_btnArray addObject:btn];
        btn.hidden = YES;
    }
    
}

-(void)clickBtn:(UIButton *)btn{
    NSLog(@"点击了按钮-- %ld", (long)btn.tag);
}


- (IBAction)start:(UIButton *)sender {
    sender.selected = !sender.selected;
 
    double tan0 = tan(0);
    
    double tan1 = tan(M_PI_2 / (numberItems - 1));
    double tan2d = (M_PI_2 / (numberItems - 1) * 2);
    double tan2 = tan(tan2d);
    double tan3 = tan(((M_PI_2 / (numberItems - 1)) * 3));
    double tan5 = tan(M_PI_2 / (numberItems - 1) * 4);
    
    double tan4444 = tan(M_PI_4);
    
    double x0 = [[self getXWithTanAngle:tan0] [0] doubleValue];
    double x1 = [[self getXWithTanAngle:tan1] [0] doubleValue];
    double x2 = [[self getXWithTanAngle:tan2] [0] doubleValue];
    double x3 = [[self getXWithTanAngle:tan3] [0] doubleValue];
    
    double y1 = [[self getXWithTanAngle:tan1] [1] doubleValue];
    double y2 = [[self getXWithTanAngle:tan2] [1] doubleValue];
    double y3 = [[self getXWithTanAngle:tan3] [1] doubleValue];
    //CAAnimation
    if (isOpen) {
        isOpen = NO;
        CGFloat duration = 0.3;
        CGPoint endPoint = self.start.center;
        [WYTool_Animation showSomeView:_button1 fromPoint:CGPointMake(centerX - x0, centerY) toPoint:endPoint duration:duration];
        
        [WYTool_Animation showSomeView:_button2 fromPoint:CGPointMake(centerX - x1, centerY - y1)toPoint:endPoint duration:duration];
        
        [WYTool_Animation showSomeView:_button3 fromPoint:CGPointMake(centerX - x2, centerY - y2) toPoint:endPoint duration:duration];
        
        [WYTool_Animation showSomeView:_button4 fromPoint:CGPointMake(centerX - x2, centerY - y2) toPoint:endPoint duration:duration];
    }
    else {
        isOpen = YES;
        
        CGPoint point1 = CGPointMake(centerX - x0, centerY);
        CGPoint point2 = CGPointMake(centerX - x1, centerY - y1);
        CGPoint point3 = CGPointMake(centerX - x2, centerY - y2);
        CGPoint point4 = CGPointMake(centerX - x3, centerY - y3);
        
        CGPoint fromPoint = self.start.center;
        CGFloat duration = 0.5;
        [WYTool_Animation showSomeView:_button1 fromPoint:fromPoint toPoint:point1 duration:duration];
        [WYTool_Animation showSomeView:_button2 fromPoint:fromPoint toPoint:point2 duration:duration];
        [WYTool_Animation showSomeView:_button3 fromPoint:fromPoint toPoint:point3 duration:duration];
        [WYTool_Animation showSomeView:_button4 fromPoint:fromPoint toPoint:point4 duration:duration];
    }

}


-(void)showBtn{
    for (int  i = 0; i<_btnArray.count; i++) {
        UIButton *btn=_btnArray[i];
        btn.hidden = NO;
        //        btn.transform=CGAffineTransformIdentity;
        CGPoint startPoint = _show.center;
        //        CGPoint startPoint = CGPointFromString([NSString stringWithFormat:@"%@",[_homeBtn.layer valueForKeyPath:@"position"]]);
        CGPoint endPoint =CGPointMake(_show.center.x, _show.y - 60 * (_btnArray.count-i));
        //position animation
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.duration=.3;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
        positionAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
        positionAnimation.beginTime = CACurrentMediaTime() + (0.3/(float)_btnArray.count * (float)i);
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        
        [btn.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        
        btn.layer.position=endPoint;
        
        //scale animation
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration=.3;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.fromValue = @(0);
        scaleAnimation.toValue = @(1);
        scaleAnimation.beginTime = CACurrentMediaTime() + (0.3/(float)_btnArray.count * (float)i);
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        
        [btn.layer addAnimation:scaleAnimation forKey:@"transformscale"];
        btn.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    }
}

-(void)hiddenBtn{
    int index = 0;
    for (int  i = (int)_btnArray.count-1; i>=0; i--) {
        UIButton *btn=_btnArray[i];
        //        btn.transform=CGAffineTransformIdentity;
        //CGPoint startPoint = CGPointMake(49, 419);
        CGPoint startPoint = CGPointFromString([NSString stringWithFormat:@"%@",[btn.layer valueForKeyPath:@"position"]]);
        CGPoint endPoint = _show.center;
        //position animation
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.duration=.3;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
        positionAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
        positionAnimation.beginTime = CACurrentMediaTime() + (.3/(float)_btnArray.count * (float)index);
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        
        [btn.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        //btn.layer.position=startPoint;
        
        //scale animation
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration=.3;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.fromValue = @(1);
        scaleAnimation.toValue = @(0);
        scaleAnimation.beginTime = CACurrentMediaTime() + (0.3/(float)_btnArray.count * (float)index);
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        
        [btn.layer addAnimation:scaleAnimation forKey:@"transformscale"];
        btn.transform = CGAffineTransformMakeScale(1.f, 1.f);
        index++;
    }
}

- (void)showProgress:(CGFloat)toValue
{
    CGRect rect = CGRectMake(150, 350, 100, 100);
    [WYTool_Animation showProgress:toValue animationFrame:rect superView:self.view];
}
- (void)setup
{
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(30, 300, 100, 100)];
    [self.view addSubview:testView];
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = testView.bounds;
    pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:testView.bounds].CGPath;
    pulseLayer.fillColor = [UIColor redColor].CGColor;
    pulseLayer.opacity = 0.0;
    
    CAReplicatorLayer *replocatorLayer = [CAReplicatorLayer layer];
    replocatorLayer.frame = testView.bounds;
    //创建读本的个数 包括原来的
    replocatorLayer.instanceCount = 4;
    //设置每个副本创建的延时
    replocatorLayer.instanceDelay = 1;
    
    [replocatorLayer addSublayer:pulseLayer];
    [testView.layer addSublayer:replocatorLayer];
    
    
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.0);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 4.0;
    groupAnima.autoreverses = NO;
    groupAnima.repeatCount = HUGE;
    [pulseLayer addAnimation:groupAnima forKey:@"groupAnimation"];
}

-(void)myTest{
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 100, 400, 1)];
    line.backgroundColor=[UIColor grayColor];
    [self.view addSubview:line];
    
    _testView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 300, 200)];
    _testView1.userInteractionEnabled=YES;
    [self.view addSubview:_testView1];
    
    
    //贝塞尔曲线,以下是4个角的位置，相对于_testView1
    CGPoint point1= CGPointMake(10, 80);
    CGPoint point2= CGPointMake(10, 200);
    CGPoint point3= CGPointMake(300, 200);
    CGPoint point4= CGPointMake(300, 80);
    
    _path=[UIBezierPath bezierPath];
    [_path moveToPoint:point1];//移动到某个点，也就是起始点
    [_path addLineToPoint:point2];
    [_path addLineToPoint:point3];
    [_path addLineToPoint:point4];
    //controlPoint控制点，不等于曲线顶点
    [_path addQuadCurveToPoint:point1 controlPoint:CGPointMake(150, -30)];
    
    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
    shapeLayer.path=_path.CGPath;
    shapeLayer.fillColor=[UIColor clearColor].CGColor;//填充颜色
    shapeLayer.strokeColor=[UIColor orangeColor].CGColor;//边框颜色
    [_testView1.layer addSublayer:shapeLayer];
    
    //动画
    CABasicAnimation *pathAniamtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAniamtion.duration = 3;
    pathAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAniamtion.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAniamtion.toValue = [NSNumber numberWithFloat:1.0];
    pathAniamtion.autoreverses = NO;
    [shapeLayer addAnimation:pathAniamtion forKey:nil];
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickk:)];
    [_testView1 addGestureRecognizer:tap];
    
}

-(void)clickk:(UITapGestureRecognizer *)tap{
    CGPoint point=[tap locationInView:_testView1];
    if ([_path containsPoint:point]) {//判断是不是在不规则图形内部
        NSLog(@"点击不规则图形");
    }
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
