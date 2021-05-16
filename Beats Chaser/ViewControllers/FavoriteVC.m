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

@interface FavoriteVC ()

@end

@implementation FavoriteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *homeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(homeBtnAction)];
    homeTap.numberOfTapsRequired = 1;
    [self.homeBtn addGestureRecognizer:homeTap];
    
    UITapGestureRecognizer *browseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browseBtnAction)];
    browseTap.numberOfTapsRequired = 1;
    [self.browseBtn addGestureRecognizer:browseTap];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Next" object:nil];
}

@end
