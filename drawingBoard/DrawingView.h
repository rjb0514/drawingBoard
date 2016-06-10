//
//  drawingView.h
//  drawingBoard
//
//  Created by 茹 on 16/6/10.
//  Copyright © 2016年 rujianbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingView : UIView
//线宽
@property (assign,nonatomic) CGFloat lineWith;
//线的颜色
@property (strong,nonatomic) UIColor *col;
@end
