//
//  Song.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Song : NSObject
@property (strong, nonatomic) NSString *songName;
@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) UIImage *coverImg;
- (id)initWithSongName:(NSString *)songName artistName:(NSString *)artistName coverImg:(UIImage *)coverImg;
@end

NS_ASSUME_NONNULL_END
