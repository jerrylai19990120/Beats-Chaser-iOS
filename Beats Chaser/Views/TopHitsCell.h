//
//  TopHitsCell.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-11.
//

#import <UIKit/UIKit.h>
#import "CircularImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopHitsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet CircularImage *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *songNameTxt;
@property (weak, nonatomic) IBOutlet UILabel *artistNameTxt;
@property (weak, nonatomic) IBOutlet UIImageView *playBtn;
@property (weak, nonatomic) IBOutlet UIImageView *downloadBtn;
- (void)configureCell;
@end

NS_ASSUME_NONNULL_END
