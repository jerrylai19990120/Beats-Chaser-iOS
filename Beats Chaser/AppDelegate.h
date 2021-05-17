//
//  AppDelegate.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-07.
//

#import <UIKit/UIKit.h>
@import AVFoundation;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (assign) BOOL isPlaying;
@property (assign) int currentPlaying;
@property (strong, nonatomic) NSArray* songsList;
@property (strong, nonatomic) NSArray* songs;
@property (strong, nonatomic) AVPlayerItem *prevItem;
@property (strong, nonatomic) AVQueuePlayer *player;
@end

