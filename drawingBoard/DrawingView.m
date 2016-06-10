//
//  drawingView.m
//  drawingBoard
//
//  Created by 茹 on 16/6/10.
//  Copyright © 2016年 rujianbin. All rights reserved.
//

#import "DrawingView.h"
#import "HMBezierPath.h"

@interface DrawingView ()
//路径
@property (strong,nonatomic) HMBezierPath  *path;
//路径数组
@property (strong,nonatomic) NSMutableArray <HMBezierPath *> *pathArray;

@end

@implementation DrawingView
#pragma mark - 触摸事件
//MARK:开始触摸
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //1.获取触摸对象
    UITouch *touch = touches.anyObject;
    //2.获取点
    CGPoint loc = [touch locationInView:self];
    //创建路径
    self.path = [HMBezierPath bezierPath];
    //设置线宽
    self.path.lineWidth =self.lineWith;
    //添加颜色属性
    self.path.color = self.col;
    //设置接头
    self.path.lineJoinStyle = kCGLineJoinRound;
    self.path.lineCapStyle = kCGLineCapRound;
    //3.设置路径的起点为当前点
    [self.path moveToPoint:loc];
}
//MARK:移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //1.获取触摸对象
    UITouch *touch = touches.anyObject;
    //2.获取触摸点
    CGPoint moveLoc = [touch locationInView:self];
    //3.路径连接点
    [self.path addLineToPoint:moveLoc];
    
    
    //添加到路径
    [self.pathArray addObject:self.path];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    //遍历
    [self.pathArray enumerateObjectsUsingBlock:^(HMBezierPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //设置颜色
        [obj.color setStroke];
        //渲染
        [obj stroke];
    }];
 
}
#pragma makr - 懒加载
//- (UIBezierPath *)path {
//    if (_path == nil) {
//        _path = [UIBezierPath bezierPath];
//    }
//    return _path;
//}

- (NSMutableArray *)pathArray {
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

@end
