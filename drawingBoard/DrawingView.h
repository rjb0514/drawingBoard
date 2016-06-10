//
//  drawingView.h
//  drawingBoard
//
//  Created by 茹 on 16/6/10.
//  Copyright © 2016年 rujianbin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DrawingView;
@protocol DrawingViewDelegate <NSObject>

@optional
- (void) saveBtnDidClick:(DrawingView *)drawingView didFish:(UIImage *)clipImage;

@end

@interface DrawingView : UIView
//线宽
@property (assign,nonatomic) CGFloat lineWith;
//线的颜色
@property (strong,nonatomic) UIColor *col;
//代理属性
@property (weak,nonatomic) id <DrawingViewDelegate> delegate;
//清除
- (void) clear;
//返回
- (void) back;
//橡皮擦
- (void) eraser;
//保存
- (void) save;
@end
