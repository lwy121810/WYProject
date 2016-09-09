//
//  DemoVc4.m
//  WYProject
//
//  Created by lwy1218 on 16/9/5.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "DemoVc4.h"

@interface DemoVc4 ()
@property (nonatomic , strong) CAEmitterLayer *layer;
@property (weak, nonatomic) IBOutlet UIButton *startItem;

@end

@implementation DemoVc4
- (IBAction)start:(UIButton *)sender {
    
    //发射器的中心位置 默认为（0， 0 ， 0）
            self.layer.emitterPosition = self.startItem.center;

}
- (IBAction)stop:(UIButton *)sender {
    [self.layer removeFromSuperlayer];
    _layer = nil;
}

- (CAEmitterLayer *)layer
{
    if (!_layer) {
        CAEmitterLayer *layer = [CAEmitterLayer layer];
        //发射器的中心位置 默认为（0， 0 ， 0）
//        layer.emitterPosition = self.startItem.center;
        /**是否开启三维效果 默认为NO*/
        layer.preservesDepth = NO;
        /**粒子运动的速度 默认为1 */
        layer.velocity = 1;
        /**粒子的缩放比例 默认为1 即对象的初始缩放大小*/
        layer.scale = 2;
        /**自旋转速度 默认为1*/
        layer.spin = 1;
        /**默认为1*/
        layer.speed = 1;
        /**发射器的尺寸*/
        layer.emitterSize = self.startItem.size;
        /**发射器的深度*/
        layer.emitterDepth = 300;
        layer.backgroundColor = [UIColor redColor].CGColor;
        /**发射器的形状*/
        /*
         NSString * const kCAEmitterLayerPoint;//点的形状，粒子从一个点发出
         NSString * const kCAEmitterLayerLine;//线的形状，粒子从一条线发出
         NSString * const kCAEmitterLayerRectangle;//矩形形状，粒子从一个矩形中发出
         NSString * const kCAEmitterLayerCuboid;//立方体形状，会影响Z平面的效果
         NSString * const kCAEmitterLayerCircle;//圆形，粒子会在圆形范围发射
         NSString * const kCAEmitterLayerSphere;//球型
         */
        layer.emitterShape = kCAEmitterLayerLine;
        /**发射模式*/
        /*
         NSString * const kCAEmitterLayerPoints;//从发射器中发出
         NSString * const kCAEmitterLayerOutline;//从发射器边缘发出
         NSString * const kCAEmitterLayerSurface;//从发射器表面发出
         NSString * const kCAEmitterLayerVolume;//从发射器中点发出
         */
        layer.emitterMode = kCAEmitterLayerSurface;
        /**渲染模式*/
        /*
         NSString * const kCAEmitterLayerUnordered;//粒子无序出现
         NSString * const kCAEmitterLayerOldestFirst;//声明久的粒子会被渲染在最上层
         NSString * const kCAEmitterLayerOldestLast;//年轻的粒子会被渲染在最上层
         NSString * const kCAEmitterLayerBackToFront;//粒子的渲染按照Z轴的前后顺序进行
         NSString * const kCAEmitterLayerAdditive;//粒子混合
         */
        layer.renderMode = kCAEmitterLayerUnordered;
        
        NSMutableArray *cells = [@[] mutableCopy];
        for (int i = 0; i < 10; i++) {
            CAEmitterCell *cell = [CAEmitterCell emitterCell];
            /**粒子产生的速度*/
            cell.birthRate = 0.6 + 0.5 * i;
            /***/
//            cell.speed = 0.5;
            /**粒子运动速度*/
            cell.velocity = 100;
            /**速度范围 保证每个粒子有一个随机的速度值*/
            cell.velocityRange = 30;
            /**生命周期 即存活时间*/
            cell.lifetime = 0.8;
            /**生命周期增减的范围 比如lifetime = 10s, lifetimeRange = 5s那么实际的每个cell的lifetime = [5s - 15s]。*/
            cell.lifetimeRange = 1;
            /**自旋转速度*/
            cell.spin = 1;
            /**自旋转角度范围*/
//            cell.spinRange = M_PI_2;
            /**初始时的缩放比例*/
            cell.scale = 0.5;
            /**缩放速度*/
            cell.scaleSpeed = 1;
            /**类似上面的range*/
            cell.scaleRange = 0;
            
            /**粒子透明度在生命周期内的改变速度*/
            cell.alphaSpeed = 0.5;
            /**粒子alpha改变的范围*/
            cell.alphaRange = 0;
            /***/
//            cell.contentsRect = CGRectMake(50, self.startItem.y - 300, 300, 200);
            /**x y平面的发射方向 指定cell从什么方向抛洒*/
            cell.emissionLongitude = 0;
            /**周围发射角度 指定抛洒对象能在多大的角度范围扩散*/
            cell.emissionRange = 1;
            /**y方向的加速度*/
            cell.yAcceleration = 10;
            /**x方向的加速度*/
//            cell.xAcceleration = 0;
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30" , i]];
            /**对象的颜色 cell可以重新对图片进行填充 */
            //        cell.color = [UIColor redColor].CGColor;
            /**红色的通道的扰动范围 类似的有greenSpeed blueRange*/
            //        cell.redRange = 0;
            /**变更速度*/
            //        cell.redSpeed = 0;
            cell.contents = (id)[image CGImage];
            cell.name = @"test";
            [cells addObject:cell];
        }
        
//        CAEmitterCell *cell = [CAEmitterCell emitterCell];
//        /**粒子产生的速度 默认0*/
//        cell.birthRate = 0;
//        /***/
//        //            cell.speed = 0.5;
//        /**粒子运动速度*/
//        cell.velocity = 100;
//        /**速度范围 保证每个粒子有一个随机的速度值*/
//        cell.velocityRange = 30;
//        /**生命周期 即存活时间*/
//        cell.lifetime = 0.8;
//        /**生命周期增减的范围 比如lifetime = 10s, lifetimeRange = 5s那么实际的每个cell的lifetime = [5s - 15s]。*/
//        cell.lifetimeRange = 1;
//        /**自旋转速度*/
//        cell.spin = 1;
//        /**自旋转角度范围*/
//        //            cell.spinRange = M_PI_2;
//        /**初始时的缩放比例*/
//        cell.scale = 0.5;
//        /**缩放速度*/
//        cell.scaleSpeed = 1;
//        /**类似上面的range*/
//        cell.scaleRange = 0;
//        
//        /**粒子透明度在生命周期内的改变速度*/
//        cell.alphaSpeed = 0.5;
//        /**粒子alpha改变的范围*/
//        cell.alphaRange = 0;
//        /***/
//        //            cell.contentsRect = CGRectMake(50, self.startItem.y - 300, 300, 200);
//        /**x y平面的发射方向 指定cell从什么方向抛洒*/
//        cell.emissionLongitude = 0;
//        /**周围发射角度 指定抛洒对象能在多大的角度范围扩散*/
//        cell.emissionRange = 1;
//        /**y方向的加速度*/
//        cell.yAcceleration = 10;
//        /**x方向的加速度*/
//        //            cell.xAcceleration = 0;
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good1_30x30"]];
//        /**对象的颜色 cell可以重新对图片进行填充 */
//        //        cell.color = [UIColor redColor].CGColor;
//        /**红色的通道的扰动范围 类似的有greenSpeed blueRange*/
//        //        cell.redRange = 0;
//        /**变更速度*/
//        //        cell.redSpeed = 0;
//        cell.contents = (id)[image CGImage];
//        cell.name = @"test";
//        [cells addObject:cell];
//        
        layer.emitterCells = cells;
        [self.view.layer addSublayer:layer];
        _layer = layer;
        
    }
    return _layer;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
//    self.layer.position = point;
    self.layer.emitterPosition = point;
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
//    self.layer.position = point;
    self.layer.emitterPosition = point;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
//    self.layer.position = point;
    self.layer.emitterPosition = point;
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
