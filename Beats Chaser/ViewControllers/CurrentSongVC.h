//
//  CurrentSongVC.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-11.
//

#import <UIKit/UIKit.h>
#import "CircularImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrentSongVC : UIViewController
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet CircularImage *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *artistName;
@property (weak, nonatomic) NSString *artist;
@property (weak, nonatomic) NSString *song;
@property (weak, nonatomic) UIImage *cover;
@property (assign) BOOL isPlaying;
@property (weak, nonatomic) IBOutlet UIImageView *playBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backwardBtn;
@property (weak, nonatomic) IBOutlet UIImageView *forwardBtn;
- (void)setupBlurOverlayView;
- (void)setupAlbumData;
@end

NS_ASSUME_NONNULL_END
