//
//  WYTool_Animation.m
//  DaDaImage-iPhone2.0
//
//  Created by lwy1218 on 16/6/23.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "WYTool_Animation.h"

@implementation WYTool_Animation

//打开菜单
+(void)showSomeView:(UIView *)view fromPoint:(CGPoint)from toPoint:(CGPoint)to duration:(CFTimeInterval)duration
{
    
    [view.layer addAnimation:[self animationPoint:from toPoint:to duration:duration] forKey:nil];
    view.center = to;
    [UIView animateWithDuration:duration animations:^{
        view.alpha = 1;
    }completion:^(BOOL finished) {
    }];
}

//打开菜单
+ (CAAnimationGroup *)animationPoint:(CGPoint)from toPoint:(CGPoint)to duration:(CFTimeInterval)duration
{
    
    /**
     *  CABasicAnimation和CAKeyframeAnimation是对图层中的不同属性进行动画的。
     */
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    //设置曲线的圆点
    [movePath moveToPoint:from];
    //绘制曲线 绘制二次贝塞尔曲线
    [movePath addQuadCurveToPoint:to controlPoint:CGPointMake( to.x - 10, to.y - 10)];
    //绘制两个曲线可以实现在目标位置晃动一下的效果
    [movePath addQuadCurveToPoint:to controlPoint:CGPointMake( to.x + 10, to.y + 10)];
    //关键帧 关键帧动画是描述动画的路径 基础动画是动画的效果
    /**
     * CAKeyframeAnimation的属性介绍
     1. path
     这是一个 CGPathRef  对象，默认是空的，当我们创建好CAKeyframeAnimation的实例的时候，可以通过制定一个自己定义的path来让某一个物体按照这个路径进行动画。这个值默认是nil  当其被设定的时候  values  这个属性就被覆盖
     2. values
     一个数组，提供了一组关键帧的值，  当使用path的 时候 values的值自动被忽略。
     */
    /**
     *
     CALayer有2个非常重要的属性：position和anchorPoint
     
     @property CGPoint position;
     
     用来设置CALayer在父层中的位置
     
     以父层的左上角为原点(0, 0)
     
     
     
     @property CGPoint anchorPoint;
     
     称为“定位点”、“锚点”
     
     决定着CALayer身上的哪个点会在position属性所指的位置
     
     以自己的左上角为原点(0, 0)
     
     它的x、y取值范围都是0~1，默认值为（0.5, 0.5）
     http://www.cnblogs.com/wendingding/p/3800736.html
     */
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //填充路径
    moveAnim.path = movePath.CGPath;
    //设置样式 这里为渐出样式
    moveAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    moveAnim.removedOnCompletion = YES;
    //创建基础动画
    /**
     *  当你创建一个 CABasicAnimation 时,你需要通过-setFromValue 和-setToValue 来指定一个开始值和结束值。 当你增加基础动画到层中的时候,它开始运行
     Autoreverses
     当你设定这个属性为 YES 时,在它到达目的地之后,动画的返回到开始的值,代替了直接跳转到 开始的值。
     
     Duration
     Duration 这个参数你已经相当熟悉了。它设定开始值到结束值花费的时间。期间会被速度的属性所影响
     
     RemovedOnCompletion
     这个属性默认为 YES,那意味着,在指定的时间段完成后,动画就自动的从层上移除了。这个一般不用。
     假如你想要再次用这个动画时,你需要设定这个属性为 NO。这样的话,下次你在通过-set 方法设定动画的属 性时,它将再次使用你的动画,而非默认的动画
     
     BeginTime
     这个属性在组动画中很有用。它根据父动画组的持续时间,指定了开始播放动画的时间。默认的是 0.0.组 动画在下个段落中讨论“Animation Grouping”。
     
     TimeOffset
     如果一个时间偏移量是被设定,动画不会真正的可见,直到根据父动画组中的执行时间得到的时间都流逝 了。
     RepeatCount
     默认的是 0,意味着动画只会播放一次。如果指定一个无限大的重复次数,使用 1e100f。这个不应该和 repeatDration 属性一块使用。
     RepeatDuration
     这个属性指定了动画应该被重复多久。动画会一直重复,直到设定的时间流逝完。它不应该和 repeatCount 一起使用。
     */
    //设置旋转动画
    CABasicAnimation *TransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    //设置
    TransformAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //沿Z轴旋转
    /**
     *  angle：旋转的弧度，所以要把角度转换成弧度：角度* M_PI / 180。
     
     x：向X轴方向旋转。值范围-1--- 1之间
     
     y：向Y轴方向旋转。值范围-1 ---1之间
     
     z：向Z轴方向旋转。值范围-1 ---1之间
     */
    TransformAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,0,0,1)];
    TransformAnim.cumulative = YES;
    //它设定开始值到结束值花费的时间。期间会被速度的属性所影响
    TransformAnim.duration = duration / 4;
    //旋转1遍，360度 RepeatCount 默认的是 0,意味着动画只会播放一次。如果指定一个无限大的重复次数,使用 1e100f。这个不应该和 repeatDration 属性一块使用。
    TransformAnim.repeatCount = 4;
    //设置动画执行完毕之后删除动画 那意味着,在指定的时间段完成后,动画就自动的从层上移除了。这个一般不用
    TransformAnim.removedOnCompletion = YES;
    //Speed    默认的值为 1.0.这意味着动画播放按照默认的速度。如果你改变这个值为 2.0,动画会用 2 倍的速度播放。 这样的影响就是使持续时间减半。如果你指定的持续时间为 6 秒,速度为 2.0,动画就会播放 3 秒钟---一半的 持续时间。
    TransformAnim.speed = 1.0;
    /**
     可以通过改变animationWithKeyPath来改变动画：
     transform.scale = 比例轉換 transform.scale.x = 闊的比例轉換 transform.scale.y = 高的比例轉換
     transform.rotation.z = 平面圖的旋轉 opacity = 透明度 margin zPosition  backgroundColor 背景颜色
     cornerRadius 圆角 borderWidth  bounds contents contentsRect cornerRadius frame hidden mask masksToBounds   opacity position shadowColor shadowOffset shadowOpacity shadowRadius
     */
    CABasicAnimation *backgroundColorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColorAnimation.fromValue = [UIColor lightGrayColor];
    backgroundColorAnimation.toValue = [UIColor lightGrayColor];
    backgroundColorAnimation.removedOnCompletion = YES;
    
    
    //缩放变化 transform不能随便写
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    //    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnimation.toValue =[NSValue valueWithCATransform3D:CATransform3DIdentity];
    /**
     *  sx：X轴缩放，代表一个缩放比例，一般都是0 --- 1 之间的数字。
     
     sy：Y轴缩放。
     
     sz：整体比例变换时，也就是m11（sx）==m22（sy）时，若m33（sz）>1，图形整体缩小，若0<1，图形整体放大，若m33（sz）<0，发生关于原点的对称等比变换。
     
     文／lucifrom_（简书作者）
     原文链接：http://www.jianshu.com/p/44080eec7a1c
     */
    scaleAnimation.removedOnCompletion = YES;
    
    //    //透明度变化
    CABasicAnimation * opacityAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnimation.removedOnCompletion = YES;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects: opacityAnimation ,  scaleAnimation  , backgroundColorAnimation, moveAnim,nil];
    animGroup.duration = duration;
    //移动之后应该把控件移到指定的位置
//    view.center = to;
//    [UIView animateWithDuration:duration animations:^{
//        view.alpha = 1;
//    }completion:^(BOOL finished) {
//    }];
    return animGroup;
}
/**
 *  收回菜单
 *
 *  @param view     要收回的view
 *  @param from     开始的位置
 *  @param to       到某个位置
 *  @param duration 时间
 */
+ (void)takeBackSomeView:(UIView *)view fromPoint:(CGPoint)from toOriginPoint:(CGPoint)to duration:(CFTimeInterval)duration;
{
    [view.layer addAnimation:[self takeBackFromEndPoint:from toOriginPoint:to duration:duration] forKey:nil];
    view.center = to;
    
    [UIView animateWithDuration:duration animations:^{
        view.alpha = 0;
    }completion:^(BOOL finished) {
    }];
}

//收回菜单
+ (CAAnimationGroup *)takeBackFromEndPoint:(CGPoint)from toOriginPoint:(CGPoint)to duration:(CFTimeInterval)duration
{
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    //设置路线 收回时直接是直线路线
    [movePath moveToPoint:from];
    [movePath addLineToPoint:to];
    
    //关键帧
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    //设置样式
    moveAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    moveAnim.removedOnCompletion = YES;
    //设置基础动画
    CABasicAnimation *TransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    TransformAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //沿Z轴旋转
    TransformAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,0,0,1)];
    TransformAnim.cumulative = YES;
    //设置开始值到结束值的时间
    TransformAnim.duration = duration / 3;
    //旋转1遍，360度
    TransformAnim.repeatCount = 3;
    TransformAnim.removedOnCompletion = YES;
    
    //缩放变化 "transform"不能随便写
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    //    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)];
    //    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    //    scaleAnimation.toValue =[NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    scaleAnimation.fromValue =[NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    
    /**
     *  sx：X轴缩放，代表一个缩放比例，一般都是0 --- 1 之间的数字。
     
     sy：Y轴缩放。
     
     sz：整体比例变换时，也就是m11（sx）==m22（sy）时，若m33（sz）>1，图形整体缩小，若0<1，图形整体放大，若m33（sz）<0，发生关于原点的对称等比变换。
     
     文／lucifrom_（简书作者）
     原文链接：http://www.jianshu.com/p/44080eec7a1c
     */
    scaleAnimation.removedOnCompletion = YES;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, TransformAnim ,scaleAnimation,nil];
    animGroup.duration = duration;
//    view.center = to;
//    
//    [UIView animateWithDuration:duration animations:^{
//        view.alpha = 0;
//    }completion:^(BOOL finished) {
//    }];
    return animGroup;
}


/**加载动画 范围0-1 可用于显示下载进度*/
+ (void)showProgress:(CGFloat)toValue animationFrame:(CGRect)frame superView:(UIView *)superView
{
    toValue = toValue < 0 ? 0 : toValue;
    toValue = toValue > 1 ? 1 : toValue;
    UIBezierPath *beizPath=[UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:frame.size.height * 0.5];
    //先画一个圆
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.path=beizPath.CGPath;
    layer.fillColor=[UIColor clearColor].CGColor;//填充色
    layer.strokeColor=[UIColor redColor].CGColor;//边框颜色
    layer.lineWidth=6.0f;
    layer.lineCap=kCALineCapRound;//线框类型
    [superView.layer addSublayer:layer];
    
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue=[NSNumber numberWithFloat:0.0f];
    animation.toValue=[NSNumber numberWithFloat:toValue];
    animation.duration=2.0;
    //animation.repeatCount=HUGE;//永久重复动画
    //animation.delegate=self;
    //removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
    //fillMode：决定当前对象在非active时间段的行为.比如动画开始之前,动画结束之后
    //autoreverses:动画结束时是否执行逆动画
    //timingFunction:设定动画的速度变化
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:@"animation"];

}





@end
