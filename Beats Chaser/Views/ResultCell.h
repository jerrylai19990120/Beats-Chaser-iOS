//
//  ResultCell.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameTxt;
@property (weak, nonatomic) IBOutlet UILabel *artistTxt;
- (void)configureCell;
@end

NS_ASSUME_NONNULL_END
