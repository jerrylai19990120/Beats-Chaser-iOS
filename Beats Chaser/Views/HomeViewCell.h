//
//  HomeViewCell.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-11.
//

#import <UIKit/UIKit.h>
#import "CircularImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet CircularImage *categoryImg;
@property (weak, nonatomic) IBOutlet UILabel *categoryTxt;
- (void)configureCell;
@end

NS_ASSUME_NONNULL_END
