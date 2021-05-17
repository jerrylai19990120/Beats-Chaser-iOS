//
//  BrowseVC.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-13.
//

#import <UIKit/UIKit.h>
#import "RoundedCornerImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface BrowseVC : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIStackView *homeBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *artistCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *recentCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *currSongName;
@property (weak, nonatomic) IBOutlet UILabel *artistName;
@property (weak, nonatomic) IBOutlet RoundedCornerImage *coverImg;
@property (weak, nonatomic) IBOutlet UIStackView *favoriteBtn;
@end

NS_ASSUME_NONNULL_END
