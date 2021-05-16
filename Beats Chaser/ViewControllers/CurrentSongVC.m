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
    [self setupAlbumData];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playBtnPressed)];
    tap.numberOfTapsRequired = 1;
    [self.playBtn setUserInteractionEnabled:true];
    [self.playBtn addGestureRecognizer:tap];
}

- (void)playBtnPressed{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Start" object:nil];
    if([self.playBtn.image isEqual:[UIImage systemImageNamed:@"play.circle.fill"]]){
        [self.playBtn setImage:[UIImage systemImageNamed:@"pause.circle.fill"]];
    }else{
        [self.playBtn setImage:[UIImage systemImageNamed:@"play.circle.fill"]];
    }
    
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

- (void)setupAlbumData{
    self.artistName.text = self.artist;
    self.coverImg.image = self.cover;
    self.songName.text = self.song;
    if(self.isPlaying){
        [self.playBtn setImage:[UIImage systemImageNamed:@"pause.circle.fill"]];
    }else{
        [self.playBtn setImage:[UIImage systemImageNamed:@"play.circle.fill"]];
    }
}

@end
