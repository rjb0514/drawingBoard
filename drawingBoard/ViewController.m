//
//  ViewController.m
//  drawingBoard
//
//  Created by 茹 on 16/6/10.
//  Copyright © 2016年 rujianbin. All rights reserved.
//

#import "ViewController.h"
#import "DrawingView.h"

@interface ViewController ()<DrawingViewDelegate>
//画板视图
@property (weak,nonatomic) IBOutlet DrawingView *drawingView;
//滑块
@property (weak,nonatomic) IBOutlet UISlider *slider;
//第一个颜色按钮
@property (weak,nonatomic) IBOutlet UIButton *fistBtn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置线宽
    [self sliderChange:self.slider];
    //设置颜色
    [self colorBtnClick:self.fistBtn];
    //设置代理
    self.drawingView.delegate = self;

}
#pragma mark - 上图视图按钮的点击事件
//MARK:清楚按钮的点击事件
- (IBAction)clearBtn:(UIBarButtonItem *)sender {
    
    [self.drawingView clear];
}
//MARK:返回按钮的点击事件
- (IBAction)backBtnClick:(UIBarButtonItem *)sender {
    [self.drawingView back];
}
//MARK:橡皮擦按钮的点击事件
- (IBAction)eraserBtnClidk:(id)sender {
    [self.drawingView eraser];
}
//MARK:保存按钮的点击事件
- (IBAction)saveBtnClick:(id)sender {
    [self.drawingView save];
}

#pragma mark - 保存按钮的代理事件
- (void)saveBtnDidClick:(DrawingView *)drawingView didFish:(UIImage *)clipImage {
    //保存图片
    UIImageWriteToSavedPhotosAlbum(clipImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
   
    


}
//保存到相册后调用的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

    //1.创建alertController
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"照片保存成功" preferredStyle:UIAlertControllerStyleAlert];
    //创建Action
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        nil;
    }];
    
    //添加
    [ac addAction:cancel];
    
    [self presentViewController:ac animated:YES completion:nil];


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
