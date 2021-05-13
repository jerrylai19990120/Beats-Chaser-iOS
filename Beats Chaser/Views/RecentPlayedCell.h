//
//  RecentPlayedCell.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecentPlayedCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *songNameTxt;
@property (weak, nonatomic) IBOutlet UILabel *artistNameTxt;
- (void)configureCell;
@end

NS_ASSUME_NONNULL_END
