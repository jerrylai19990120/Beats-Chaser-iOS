//
//  CurrentSongVC.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CurrentSongVC : UIViewController
@property (strong, nonatomic) IBOutlet UIView *bgView;
- (void)setupBlurOverlayView;
@end

NS_ASSUME_NONNULL_END
