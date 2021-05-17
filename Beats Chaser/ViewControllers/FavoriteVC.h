//
//  FavoriteVC.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-13.
//

#import <UIKit/UIKit.h>
#import "RoundedCornerImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIStackView *homeBtn;
@property (weak, nonatomic) IBOutlet UIStackView *browseBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet RoundedCornerImage *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *currSongName;
@property (weak, nonatomic) IBOutlet UILabel *artistName;

@end

NS_ASSUME_NONNULL_END
