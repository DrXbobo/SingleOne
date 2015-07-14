//
//  ViewController.m
//  SingleOne
//
//  Created by ShanghaiLuluyou-xuwenbo on 15/7/14.
//  Copyright (c) 2015年 ShanghaiLuluyou-xuwenbo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CALayer* rectLayer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //    [self bezierPath];
    //    [self beatAnimation];
    //    [self groupAnimation];
    [self roundAnimation];
}
-(void)bezierPath
{
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    UIView* pview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    pview.backgroundColor = [UIColor orangeColor];
    pview.center = CGPointMake(50, 50);
    [self.view addSubview:pview];
    
    UIView* pview2= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    pview2.center = CGPointMake(100, 50);
    pview2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:pview2];
    
    UIView* pview3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    pview3.center = CGPointMake(150, 50);
    pview3.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:pview3];
    
    [path1 moveToPoint:pview.center];
}
-(void)beatAnimation
{
    CALayer* scaleLayer = [[CALayer alloc]init];
    scaleLayer.backgroundColor = [UIColor orangeColor].CGColor;
    scaleLayer.frame = CGRectMake(60, 30, 50, 50);
    scaleLayer.cornerRadius = 10;
    [self.view.layer addSublayer:scaleLayer];
    
    CABasicAnimation* scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1.0;
    scaleAnimation.toValue =@1.5;
    //是否自动回播，即 toValue -> fromValue
    scaleAnimation.autoreverses = YES;
    //    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    
    [scaleLayer addAnimation:scaleAnimation forKey:@"beat"];
}
-(void)groupAnimation
{
    CALayer* groupLayer = [[CALayer alloc]init];
    groupLayer.frame = CGRectMake(60, 300, 50, 50);
    groupLayer.cornerRadius = 10;
    groupLayer.backgroundColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:groupLayer];
    
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @.5;
    scaleAnimation.toValue = @1.5;
    scaleAnimation.autoreverses = YES;
    //    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    
    CABasicAnimation* moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:groupLayer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(320, groupLayer.position.y)];
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.duration = 2;
    
    CABasicAnimation* rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.fromValue = @0.;
    rotateAnimation.toValue = @(6 * M_PI);
    //    rotateAnimation.autoreverses = YES;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 2;
    
    CAAnimationGroup* groupAnima = [CAAnimationGroup animation];
    groupAnima.duration = 2;
    groupAnima.animations = @[scaleAnimation,moveAnimation,rotateAnimation];
    groupAnima.repeatCount = MAXFLOAT;
    groupAnima.autoreverses = YES;
    [groupLayer addAnimation:groupAnima forKey:@"groupAn"];
    
}
-(void)roundAnimation
{
    rectLayer = [[CALayer alloc]init];
    rectLayer.frame = CGRectMake(100, 200, 30, 30);
    rectLayer.cornerRadius = 15;
    rectLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:rectLayer];
    
    CAKeyframeAnimation *rectRunanimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设定关键帧位置，必须包含起始和终止位置，如果起始==终止，添加两遍，头尾各一次
    rectRunanimation.values = @[[NSValue valueWithCGPoint:rectLayer.frame.origin],[NSValue valueWithCGPoint:CGPointMake(320 - 100, rectLayer.frame.origin.y)],[NSValue valueWithCGPoint:CGPointMake(320 - 100, rectLayer.frame.origin.y +100)],[NSValue valueWithCGPoint:CGPointMake(100, rectLayer.frame.origin.y+100)],[NSValue valueWithCGPoint:rectLayer.frame.origin]];
    //设定每个关键帧的市场，如果没有显示的设置，则默认每个帧的时间=总duration/(values.count - 1)
    rectRunanimation.keyTimes = @[@0,@0.6,@0.7,@0.8,@1.];
    rectRunanimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    rectRunanimation.repeatCount = 1000;
    rectRunanimation.autoreverses = NO;
    rectRunanimation.calculationMode = kCAAnimationLinear;
    rectRunanimation.duration = 4;
    [rectLayer addAnimation:rectRunanimation forKey:@"rectAnimaiton"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
