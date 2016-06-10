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
#pragma mark - 上部视图按钮的点击事件
//MARK:清除
- (void)clear {
    [self.pathArray removeAllObjects];
    //重绘
    [self setNeedsDisplay];

}
//返回
- (void) back {
    [self.pathArray removeLastObject];
    //重绘
    [self setNeedsDisplay];
    
}
//橡皮擦
- (void) eraser {
    //让画笔的颜色为视图背景颜色
    self.col = self.backgroundColor;
}
//保存
- (void) save {
    //开启图形图文上下文
    UIGraphicsBeginImageContext(self.bounds.size);
    //获取上下文
    CGContextRef cxtRef = UIGraphicsGetCurrentContext();
    //把视图渲染上去
    [self.layer renderInContext:cxtRef];
    //获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndPDFContext();
    //把图片存到相册  让代理去工作
//    UIImageWriteToSavedPhotosAlbum(clipImage, nil, nil, nil);
    if ([self.delegate respondsToSelector:@selector(saveBtnDidClick:didFish:)]) {
        [self.delegate saveBtnDidClick:self didFish:clipImage];
    }
    

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
