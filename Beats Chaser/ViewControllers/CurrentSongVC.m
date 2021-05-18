//
//  CurrentSongVC.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-11.
//

#import "CurrentSongVC.h"
#import "Song.h"
#import "AppDelegate.h"

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
    /*Song *song = (Song *)[[notif userInfo] valueForKey:@"song"];
    self.coverImg.image = song.coverImg;
    self.artistName.text = song.artistName;
    self.songName.text = song.songName;*/
}

- (void)changeSongUINext:(NSNotification *)notif{
    /*Song *song = [[notif userInfo] valueForKey:@"song"];
    self.coverImg.image = song.coverImg;
    self.artistName.text = song.artistName;
    self.songName.text = song.songName;*/
}

- (void)nextSong{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(delegate.currentPlaying + 1 == delegate.songs.count){
        delegate.currentPlaying = 0;
        [self restartList];
        delegate.prevItem = nil;
    }else{
        delegate.prevItem = delegate.player.currentItem;
        delegate.currentPlaying++;
        [delegate.player advanceToNextItem];
    }
    Song *song = [delegate.songs objectAtIndex:delegate.currentPlaying];
    self.coverImg.image = song.coverImg;
    self.artistName.text = song.artistName;
    self.songName.text = song.songName;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeSongStatus" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Next" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NextSong" object:nil];
    //[self changeCurrentSongUIWithSong:[delegate.songs objectAtIndex:delegate.currentPlaying]];
}

- (void)previousSong{
    /*AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    delegate.isPlaying = true;*/
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Previous" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PreviousSong" object:nil];
    [self.playBtn setImage:[UIImage systemImageNamed:@"pause.circle.fill"]];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(delegate.prevItem != nil && delegate.currentPlaying != 0){
        
        NSDictionary *songMeta = [NSDictionary dictionaryWithObject:[delegate.songs objectAtIndex:delegate.currentPlaying-1] forKey:@"song"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PreviousItem" object:nil userInfo:songMeta];
        
        delegate.songsList = nil;
        NSString *sound = [[NSBundle mainBundle] pathForResource:@"ComeThru" ofType:@"mp3"];
        NSURL *soundUrl = [NSURL fileURLWithPath:sound];
        NSString *sound2 = [[NSBundle mainBundle] pathForResource:@"ImGonnaLove" ofType:@"mp3"];
        NSURL *sound2Url = [NSURL fileURLWithPath:sound2];
        NSString *sound3 = [[NSBundle mainBundle] pathForResource:@"KissMore" ofType:@"mp3"];
        NSURL *sound3Url = [NSURL fileURLWithPath:sound3];
        NSString *sound4 = [[NSBundle mainBundle] pathForResource:@"ShowMeLove" ofType:@"mp3"];
        NSURL *sound4Url = [NSURL fileURLWithPath:sound4];
        NSString *sound5 = [[NSBundle mainBundle] pathForResource:@"GoCrazy" ofType:@"mp3"];
        NSURL *sound5Url = [NSURL fileURLWithPath:sound5];
        NSString *sound6 = [[NSBundle mainBundle] pathForResource:@"MyType" ofType:@"mp3"];
        NSURL *sound6Url = [NSURL fileURLWithPath:sound6];
        NSString *sound7 = [[NSBundle mainBundle] pathForResource:@"BackToTheStreets" ofType:@"mp3"];
        NSURL *sound7Url = [NSURL fileURLWithPath:sound7];
        NSString *sound8 = [[NSBundle mainBundle] pathForResource:@"TheWeekend" ofType:@"mp3"];
        NSURL *sound8Url = [NSURL fileURLWithPath:sound8];
        
        delegate.songsList = @[
            [[AVPlayerItem alloc]initWithURL:soundUrl],
            [[AVPlayerItem alloc]initWithURL:sound2Url],
            [[AVPlayerItem alloc]initWithURL:sound3Url],
            [[AVPlayerItem alloc]initWithURL:sound4Url],
            [[AVPlayerItem alloc]initWithURL:sound5Url],
            [[AVPlayerItem alloc]initWithURL:sound6Url],
            [[AVPlayerItem alloc]initWithURL:sound7Url],
            [[AVPlayerItem alloc]initWithURL:sound8Url]
        ];
        delegate.songsList = [delegate.songsList subarrayWithRange:NSMakeRange(delegate.currentPlaying-1, delegate.songsList.count-(delegate.currentPlaying-1))];
        delegate.currentPlaying--;
        delegate.player = nil;
        delegate.player = [[AVQueuePlayer alloc]initWithItems:delegate.songsList];
        [delegate.player play];
        
        Song *song = [delegate.songs objectAtIndex:delegate.currentPlaying];
        self.coverImg.image = song.coverImg;
        self.artistName.text = song.artistName;
        self.songName.text = song.songName;
        delegate.isPlaying = true;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Previous" object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PreviousSong" object:nil];
        [self.playBtn setImage:[UIImage systemImageNamed:@"pause.circle.fill"]];
        //[self changeCurrentSongUIWithSong:[delegate.songs objectAtIndex:delegate.currentPlaying]];
    }
}

- (void)restartList{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *sound = [[NSBundle mainBundle] pathForResource:@"ComeThru" ofType:@"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:sound];
    NSString *sound2 = [[NSBundle mainBundle] pathForResource:@"ImGonnaLove" ofType:@"mp3"];
    NSURL *sound2Url = [NSURL fileURLWithPath:sound2];
    NSString *sound3 = [[NSBundle mainBundle] pathForResource:@"KissMore" ofType:@"mp3"];
    NSURL *sound3Url = [NSURL fileURLWithPath:sound3];
    NSString *sound4 = [[NSBundle mainBundle] pathForResource:@"ShowMeLove" ofType:@"mp3"];
    NSURL *sound4Url = [NSURL fileURLWithPath:sound4];
    NSString *sound5 = [[NSBundle mainBundle] pathForResource:@"GoCrazy" ofType:@"mp3"];
    NSURL *sound5Url = [NSURL fileURLWithPath:sound5];
    NSString *sound6 = [[NSBundle mainBundle] pathForResource:@"MyType" ofType:@"mp3"];
    NSURL *sound6Url = [NSURL fileURLWithPath:sound6];
    NSString *sound7 = [[NSBundle mainBundle] pathForResource:@"BackToTheStreets" ofType:@"mp3"];
    NSURL *sound7Url = [NSURL fileURLWithPath:sound7];
    NSString *sound8 = [[NSBundle mainBundle] pathForResource:@"TheWeekend" ofType:@"mp3"];
    NSURL *sound8Url = [NSURL fileURLWithPath:sound8];
    
    delegate.songsList = nil;
    delegate.songsList = @[
        [[AVPlayerItem alloc]initWithURL:soundUrl],
        [[AVPlayerItem alloc]initWithURL:sound2Url],
        [[AVPlayerItem alloc]initWithURL:sound3Url],
        [[AVPlayerItem alloc]initWithURL:sound4Url],
        [[AVPlayerItem alloc]initWithURL:sound5Url],
        [[AVPlayerItem alloc]initWithURL:sound6Url],
        [[AVPlayerItem alloc]initWithURL:sound7Url],
        [[AVPlayerItem alloc]initWithURL:sound8Url]
    ];
    
    delegate.player = nil;
    delegate.player = [[AVQueuePlayer alloc]initWithItems:delegate.songsList];
    [delegate.player play];
}

- (void)playBtnPressed{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeSongStatus" object:nil];
    if(delegate.isPlaying){
        delegate.isPlaying = false;
        [self.playBtn setImage:[UIImage systemImageNamed:@"play.circle.fill"]];
        [delegate.player pause];
    }else{
        delegate.isPlaying = true;
        [self.playBtn setImage:[UIImage systemImageNamed:@"pause.circle.fill"]];
        [delegate.player play];
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
