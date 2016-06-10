//
//  ViewController.m
//  drawingBoard
//
//  Created by 茹 on 16/6/10.
//  Copyright © 2016年 rujianbin. All rights reserved.
//

#import "ViewController.h"
#import "DrawingView.h"

@interface ViewController ()
//画板视图
@property (weak,nonatomic) IBOutlet DrawingView *drawingView;
//滑块
@property (weak,nonatomic) IBOutlet UISlider *slider;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置线宽
    [self sliderChange:self.slider];
    
   
}
#pragma makr - 颜色按钮的点击事件
- (IBAction)colorBtnClick:(UIButton *)sender {
    self.drawingView.col = sender.backgroundColor;
}

#pragma mark - 滑块滑动事件
- (IBAction)sliderChange:(UISlider *)sender {
    
    self.drawingView.lineWith = sender.value;

}

@end
