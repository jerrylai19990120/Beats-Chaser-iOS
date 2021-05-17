//
//  HomeVC.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-07.
//

#import <UIKit/UIKit.h>
#import "Song.h"
@import AVFoundation;

@interface HomeVC : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthCons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *homeView;
@property (weak, nonatomic) IBOutlet UIStackView *browseBtn;

@property (weak, nonatomic) IBOutlet UIView *underline;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIStackView *favoriteBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchTxtField;
@property (assign) CGFloat xPosition;
@property (weak, nonatomic) IBOutlet UIImageView *homeBtnImg;
@property (weak, nonatomic) IBOutlet UILabel *homeBtnTxt;
@property (weak, nonatomic) IBOutlet UIImageView *browseBtnImg;
@property (weak, nonatomic) IBOutlet UILabel *browseBtnTxt;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteBtnImg;
@property (weak, nonatomic) IBOutlet UILabel *favoriteBtnTxt;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *currSongName;
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *artistName;
- (void)configureSegmentedControl:(UISegmentedControl *)segmentedControl;
- (void)moveUnderlineSegmentedControl;
- (void)setupAttributedPlaceholder;
- (void)changeCurrentSongUIWithSong:(Song *)song;
@end

