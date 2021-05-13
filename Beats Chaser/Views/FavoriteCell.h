//
//  FavoriteCell.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-13.
//

#import <UIKit/UIKit.h>
#import "CircularImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteCell : UITableViewCell
- (void)configureCell;
@property (weak, nonatomic) IBOutlet CircularImage *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *songNameTxt;
@property (weak, nonatomic) IBOutlet UILabel *artistTxt;
@property (weak, nonatomic) IBOutlet UIImageView *playBtn;
@property (weak, nonatomic) IBOutlet UIImageView *likeBtn;

@end

NS_ASSUME_NONNULL_END
