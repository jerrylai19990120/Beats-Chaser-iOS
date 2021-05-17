//
//  FavoriteVC.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-13.
//

#import "FavoriteVC.h"
#import "HomeVC.h"
#import "BrowseVC.h"
#import "FavoriteCell.h"
#import "AppDelegate.h"
#import "CurrentSongVC.h"

@interface FavoriteVC ()

@end

@implementation FavoriteVC

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
    
    UITapGestureRecognizer *browseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browseBtnAction)];
    browseTap.numberOfTapsRequired = 1;
    [self.browseBtn addGestureRecognizer:browseTap];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextSong) name:@"NextSong" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prevSong) name:@"PreviousSong" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playPauseSong) name:@"ChangeSongStatus" object:nil];
    
    
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


- (void)changeCurrentSongUIWithSong:(Song *)song{
    self.artistName.text = song.artistName;
    self.coverImg.image = song.coverImg;
    self.currSongName.text = song.songName;
}

- (void)browseBtnAction{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BrowseVC *browseVC = [storyboard instantiateViewControllerWithIdentifier:@"BrowseVC"];
    browseVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:browseVC animated:false completion:nil];
    
}

- (void)homeBtnAction{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeVC *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    homeVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:homeVC animated:false completion:nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteCell"];
    
    if(cell!=nil){
        [cell configureCell];
        return cell;
    }else{
        return cell;
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
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Next" object:nil];
    [self changeCurrentSongUIWithSong:[delegate.songs objectAtIndex:delegate.currentPlaying]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    Song *song = [delegate.songs objectAtIndex:delegate.currentPlaying];
    
    if([segue.identifier isEqualToString:@"SongDetail3"]){
        CurrentSongVC *currVC = segue.destinationViewController;
        currVC.artist = song.artistName;
        currVC.cover = song.coverImg;
        currVC.song = song.songName;
        currVC.isPlaying = delegate.isPlaying;
    }
}


@end
