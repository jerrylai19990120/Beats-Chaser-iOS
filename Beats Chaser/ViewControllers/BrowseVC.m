//
//  BrowseVC.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-13.
//

#import "BrowseVC.h"
#import "HomeVC.h"
#import "FavoriteVC.h"
#import "ArtistCell.h"
#import "RecentPlayedCell.h"
#import "AppDelegate.h"
#import "CurrentSongVC.h"

@interface BrowseVC ()

@end

@implementation BrowseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //set up song view
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self changeCurrentSongUIWithSong:[delegate.songs objectAtIndex:delegate.currentPlaying]];
    if(delegate.isPlaying){
        [self.playBtn setImage:[UIImage systemImageNamed:@"pause.fill"] forState:UIControlStateNormal];
    }else{
        [self.playBtn setImage:[UIImage systemImageNamed:@"play.fill"] forState:UIControlStateNormal];
    }
    
    UITapGestureRecognizer *homeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(homeBtnAction)];
    homeTap.numberOfTapsRequired = 1;
    [self.homeBtn addGestureRecognizer:homeTap];
    
    UITapGestureRecognizer *favoriteTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(favoriteBtnAction)];
    favoriteTap.numberOfTapsRequired = 1;
    [self.favoriteBtn addGestureRecognizer:favoriteTap];
    
    self.artistCollectionView.delegate = self;
    self.artistCollectionView.dataSource = self;
    
    self.recentCollectionView.delegate = self;
    self.recentCollectionView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextSong) name:@"NextSong" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prevSong) name:@"PreviousSong" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playPauseSong) name:@"ChangeSongStatus" object:nil];
    
}

- (void)changeCurrentSongUIWithSong:(Song *)song{
    self.artistName.text = song.artistName;
    self.coverImg.image = song.coverImg;
    self.currSongName.text = song.songName;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(delegate.isPlaying){
        [self.playBtn setImage:[UIImage systemImageNamed:@"pause.fill"] forState:UIControlStateNormal];
    }else{
        [self.playBtn setImage:[UIImage systemImageNamed:@"play.fill"] forState:UIControlStateNormal];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    Song *song = [delegate.songs objectAtIndex:delegate.currentPlaying];
    
    if([segue.identifier isEqualToString:@"SongDetail2"]){
        CurrentSongVC *currVC = segue.destinationViewController;
        currVC.artist = song.artistName;
        currVC.cover = song.coverImg;
        currVC.song = song.songName;
        currVC.isPlaying = delegate.isPlaying;
    }
}


- (void)homeBtnAction{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeVC *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    homeVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:homeVC animated:false completion:nil];
    
}

- (void)favoriteBtnAction{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FavoriteVC *favVC = [storyboard instantiateViewControllerWithIdentifier:@"FavoriteVC"];
    favVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:favVC animated:false completion:nil];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.artistCollectionView){
        ArtistCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArtistCell" forIndexPath:indexPath];
        if(cell!=nil){
            [cell configureCell];
            return cell;
        }else{
            return cell;
        }
    }else if(collectionView == self.recentCollectionView){
        RecentPlayedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecentPlayedCell" forIndexPath:indexPath];
        if(cell!=nil){
            [cell configureCell];
            return cell;
        }else{
            return cell;
        }
    }else{
        return [[UICollectionViewCell alloc]initWithFrame:CGRectZero];
    }
}

- (IBAction)playBtnPressed:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Start" object:nil];
    if([self.playBtn.imageView.image isEqual:[UIImage systemImageNamed:@"play.fill"]]){
        [self.playBtn setImage:[UIImage systemImageNamed:@"pause.fill"] forState:UIControlStateNormal];
    }else{
        [self.playBtn setImage:[UIImage systemImageNamed:@"play.fill"] forState:UIControlStateNormal];
    }
    
}


- (IBAction)nextBtnPressed:(id)sender {
    /*AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Next" object:nil];
    [self changeCurrentSongUIWithSong:[delegate.songs objectAtIndex:delegate.currentPlaying]];*/
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
    
    [self changeCurrentSongUIWithSong:[delegate.songs objectAtIndex:delegate.currentPlaying]];
}

- (void)nextSong{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self changeCurrentSongUIWithSong:[delegate.songs objectAtIndex:delegate.currentPlaying]];
}

- (void)prevSong{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self changeCurrentSongUIWithSong:[delegate.songs objectAtIndex:delegate.currentPlaying]];
}

- (void)playPauseSong{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(delegate.isPlaying){
        [self.playBtn setImage:[UIImage systemImageNamed:@"play.fill"] forState:UIControlStateNormal];
    }else{
        [self.playBtn setImage:[UIImage systemImageNamed:@"pause.fill"] forState:UIControlStateNormal];
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

@end
