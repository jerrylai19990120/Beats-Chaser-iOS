//
//  HomeVC.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-07.
//

#import "HomeVC.h"
#import "HomeViewCell.h"
#import "TopHitsCell.h"
#import "FavoriteCell.h"
#import "BrowseVC.h"
#import "FavoriteVC.h"
#import "DataService.h"
#import "Song.h"
#import "CurrentSongVC.h"
#import "AppDelegate.h"

@import AVFoundation;

@interface HomeVC ()

@end

@implementation HomeVC

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
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self configureSegmentedControl:self.segmentedControl];
    
    [self.segmentedControl addTarget:self action:@selector(moveUnderlineSegmentedControl) forControlEvents:UIControlEventValueChanged];
    [self.collectionView setHidden:false];
    [self.tableView setHidden:true];
    self.xPosition = self.segmentedControl.layer.frame.origin.x;
    self.widthCons.constant = [UIScreen mainScreen].bounds.size.width/2 - 28;
    [self.underline layoutIfNeeded];
    
    [self setupAttributedPlaceholder];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    tap.numberOfTapsRequired = 1;
    [self.homeView addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *browseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browseBtnAction)];
    browseTap.numberOfTapsRequired = 1;
    [self.browseBtn addGestureRecognizer:browseTap];
    
    UITapGestureRecognizer *favoriteTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(favoriteBtnAction)];
    favoriteTap.numberOfTapsRequired = 1;
    [self.favoriteBtn addGestureRecognizer:favoriteTap];
    
    self.searchTxtField.returnKeyType = UIReturnKeySearch;
    self.searchTxtField.enablesReturnKeyAutomatically = true;
    self.searchTxtField.delegate = self;
    
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
    
    
    self.songsList = @[
        [[AVPlayerItem alloc]initWithURL:soundUrl],
        [[AVPlayerItem alloc]initWithURL:sound2Url],
        [[AVPlayerItem alloc]initWithURL:sound3Url],
        [[AVPlayerItem alloc]initWithURL:sound4Url],
        [[AVPlayerItem alloc]initWithURL:sound5Url],
        [[AVPlayerItem alloc]initWithURL:sound6Url],
        [[AVPlayerItem alloc]initWithURL:sound7Url],
        [[AVPlayerItem alloc]initWithURL:sound8Url]
    ];
    
    [self refillPlayList];
    
    self.player = [[AVQueuePlayer alloc]initWithItems:self.songsList];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:true error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    self.isPlaying = false;
    self.currentPlaying = 0;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startSong) name:@"Start" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nextSong) name:@"Next" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(previousSong) name:@"Previous" object:nil];
    
    self.prevItem = nil;
    
}

- (void)previousSong{
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
        [self changeCurrentSongUIWithSong:[delegate.songs objectAtIndex:delegate.currentPlaying]];
    }
}

- (void)nextSong{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(delegate.currentPlaying + 1 == delegate.songs.count){
        delegate.currentPlaying = 0;
        NSDictionary *songMeta = [NSDictionary dictionaryWithObject:[delegate.songs objectAtIndex:delegate.currentPlaying] forKey:@"song"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NextItem" object:nil userInfo:songMeta];
        [self restartList];
        delegate.prevItem = nil;
    }else{
        NSDictionary *songMeta = [NSDictionary dictionaryWithObject:[delegate.songs objectAtIndex:delegate.currentPlaying+1] forKey:@"song"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NextItem" object:nil userInfo:songMeta];
        delegate.prevItem = delegate.player.currentItem;
        delegate.currentPlaying++;
        [delegate.player advanceToNextItem];
    }
    [self changeCurrentSongUIWithSong:[delegate.songs objectAtIndex:delegate.currentPlaying]];
}

- (void)startSong{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(delegate.isPlaying){
        delegate.isPlaying = false;
        [self.playBtn setImage:[UIImage systemImageNamed:@"play.fill"] forState:UIControlStateNormal];
        [delegate.player pause];
    }else{
        delegate.isPlaying = true;
        [self.playBtn setImage:[UIImage systemImageNamed:@"pause.fill"] forState:UIControlStateNormal];
        [delegate.player play];
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self dismissKeyboard];
    [self performSegueWithIdentifier:@"SearchResults" sender:nil];
    return true;
}

- (void)browseBtnAction{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BrowseVC *browseVC = [storyboard instantiateViewControllerWithIdentifier:@"BrowseVC"];
    browseVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:browseVC animated:false completion:nil];
}


- (void)favoriteBtnAction{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FavoriteVC *favVC = [storyboard instantiateViewControllerWithIdentifier:@"FavoriteVC"];
    favVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:favVC animated:false completion:nil];
}


- (void)dismissKeyboard{
    [self.searchTxtField resignFirstResponder];
}


//collection view delegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeViewCell" forIndexPath:indexPath];
    if(cell!=nil){
        [cell configureCell];
        return cell;
    }else{
        return cell;
    }
    
}



- (void)configureSegmentedControl:(UISegmentedControl *)segmentedControl{
    [segmentedControl setBackgroundColor:[UIColor blackColor]];
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    [segmentedControl setSelectedSegmentTintColor:[[UIColor alloc]initWithRed:244/255 green:145/255 blue:60/255 alpha:1]];
    
}


- (void)moveUnderlineSegmentedControl{
    
    if(self.segmentedControl.selectedSegmentIndex == 0){
        [UIView animateWithDuration:0.18 animations:^{
            CGRect rect = self.underline.layer.frame;
            rect.origin.x = self.xPosition;
            [self.underline setFrame:rect];
        }];
        [self.collectionView setHidden:false];
        [self.tableView setHidden:true];
    }else if(self.segmentedControl.selectedSegmentIndex == 1){
        [UIView animateWithDuration:0.18 animations:^{
            CGRect rect = self.underline.layer.frame;
            rect.origin.x = self.xPosition + rect.size.width;
            [self.underline setFrame:rect];
        }];
        [self.collectionView setHidden:true];
        [self.tableView setHidden:false];
    }
    
}

//table view delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopHitsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopHitsCell" forIndexPath:indexPath];
       
    
    if(cell!=nil){
        [cell configureCell];
        return cell;
    }else{
        return cell;
    }
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)setupAttributedPlaceholder{
    self.searchTxtField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
}


- (IBAction)playBtnPressed:(id)sender {

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(delegate.isPlaying){
        delegate.isPlaying = false;
        [self.playBtn setImage:[UIImage systemImageNamed:@"play.fill"] forState:UIControlStateNormal];
        [delegate.player pause];
    }else{
        delegate.isPlaying = true;
        [self.playBtn setImage:[UIImage systemImageNamed:@"pause.fill"] forState:UIControlStateNormal];
        [delegate.player play];
    }
    
}

- (IBAction)nextBtnPressed:(id)sender {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(delegate.currentPlaying + 1 == delegate.songs.count){
        delegate.currentPlaying = 0;
        [self restartList];
    }else{
        delegate.currentPlaying++;
        [delegate.player advanceToNextItem];
    }
    
    [self changeCurrentSongUIWithSong:[delegate.songs objectAtIndex:delegate.currentPlaying]];
}

- (void)changeCurrentSongUIWithSong:(Song *)song{
    self.artistName.text = song.artistName;
    self.coverImg.image = song.coverImg;
    self.currSongName.text = song.songName;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    Song *song = [delegate.songs objectAtIndex:delegate.currentPlaying];
    
    if([segue.identifier isEqualToString:@"SongDetail"]){
        CurrentSongVC *currVC = segue.destinationViewController;
        currVC.artist = song.artistName;
        currVC.cover = song.coverImg;
        currVC.song = song.songName;
        currVC.isPlaying = delegate.isPlaying;
    }
}

- (void)refillPlayList{
    
    self.songs = @[
        [[Song alloc]initWithSongName:@"Come Thru" artistName:@"Summer Walker" coverImg:[UIImage imageNamed:@"cover2"]],
        [[Song alloc]initWithSongName:@"I Am Gonna Love You Just A Little More" artistName:@"Summer Walker" coverImg:[UIImage imageNamed:@"cover5"]],
        [[Song alloc]initWithSongName:@"Kiss More" artistName:@"Doja Cat Ft. SZA" coverImg:[UIImage imageNamed:@"cover4"]],
        [[Song alloc]initWithSongName:@"Show Me Love" artistName:@"Alicia Keys Ft. 21 Savage" coverImg:[UIImage imageNamed:@"cover8"]],
        [[Song alloc]initWithSongName:@"Go Crazy" artistName:@"Chris Brown" coverImg:[UIImage imageNamed:@"cover6"]],
        [[Song alloc]initWithSongName:@"My Type" artistName:@"Saweetie" coverImg:[UIImage imageNamed:@"cover9"]],
        [[Song alloc]initWithSongName:@"Back To The Streets" artistName:@"Saweetie" coverImg:[UIImage imageNamed:@"cover7"]],
        [[Song alloc]initWithSongName:@"The Weekend" artistName:@"SZA" coverImg:[UIImage imageNamed:@"cover3"]]
    ];
    
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
