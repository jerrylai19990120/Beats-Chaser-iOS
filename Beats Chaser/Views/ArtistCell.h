//
//  ArtistCell.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArtistCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *genreTxt;
@property (weak, nonatomic) IBOutlet UILabel *artistNameTxt;
- (void)configureCell;
@end

NS_ASSUME_NONNULL_END
