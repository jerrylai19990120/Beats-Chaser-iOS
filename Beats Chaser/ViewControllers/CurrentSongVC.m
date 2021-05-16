//
//  CurrentSongVC.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-11.
//

#import "CurrentSongVC.h"
#import "Song.h"

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
    
    UITapGestureRecognizer *nextTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextSong)];
    nextTap.numberOfTapsRequired = 1;
    [self.forwardBtn setUserInteractionEnabled:true];
    [self.forwardBtn addGestureRecognizer:nextTap];
    
    UITapGestureRecognizer *previousTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(previousSong)];
    previousTap.numberOfTapsRequired = 1;
    [self.backwardBtn setUserInteractionEnabled:true];
    [self.backwardBtn addGestureRecognizer:previousTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSongUINext:) name:@"NextItem" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSongUIPrev:) name:@"PreviousItem" object:nil];
}

- (void)changeSongUIPrev:(NSNotification *)notif{
    Song *song = (Song *)[[notif userInfo] valueForKey:@"song"];
    self.coverImg.image = song.coverImg;
    self.artistName.text = song.artistName;
    self.songName.text = song.songName;
}

- (void)changeSongUINext:(NSNotification *)notif{
    Song *song = [[notif userInfo] valueForKey:@"song"];
    self.coverImg.image = song.coverImg;
    self.artistName.text = song.artistName;
    self.songName.text = song.songName;
}

- (void)nextSong{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Next" object:nil];
}

- (void)previousSong{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Previous" object:nil];
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
