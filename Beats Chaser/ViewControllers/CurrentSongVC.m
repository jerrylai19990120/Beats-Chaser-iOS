//
//  CurrentSongVC.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-11.
//

#import "CurrentSongVC.h"

@interface CurrentSongVC ()

@end

@implementation CurrentSongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupBlurOverlayView];
}

- (void)setupBlurOverlayView{
    if(!UIAccessibilityIsReduceTransparencyEnabled()){
        self.bgView.backgroundColor = [UIColor clearColor];
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        
        blurEffectView.frame = self.bgView.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.bgView insertSubview:blurEffectView atIndex:0];
        
    }else{
        self.bgView.backgroundColor = [UIColor grayColor];
    }
}

@end
