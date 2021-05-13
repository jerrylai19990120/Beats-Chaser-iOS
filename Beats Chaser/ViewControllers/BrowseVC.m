//
//  BrowseVC.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-13.
//

#import "BrowseVC.h"
#import "HomeVC.h"
#import "FavoriteVC.h"

@interface BrowseVC ()

@end

@implementation BrowseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *homeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(homeBtnAction)];
    homeTap.numberOfTapsRequired = 1;
    [self.homeBtn addGestureRecognizer:homeTap];
    
    UITapGestureRecognizer *favoriteTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(favoriteBtnAction)];
    favoriteTap.numberOfTapsRequired = 1;
    [self.favoriteBtn addGestureRecognizer:favoriteTap];
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

@end
