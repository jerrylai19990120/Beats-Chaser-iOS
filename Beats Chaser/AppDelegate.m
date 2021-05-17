//
//  AppDelegate.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-07.
//

#import "AppDelegate.h"
#import "Song.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *sound = [[NSBundle mainBundle] pathForResource:@"ComeThru" ofType:@"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:sound];
    NSString *sound2 = [[NSBundle mainBundle] pathForResource:@"ImGonnaLove" ofType:@"mp3"];
    NSURL *sound2Url = [NSURL fileURLWithPath:sound2];
    NSString *sound3 = [[NSBundle mainBundle] pathForResource:@"KissMore" ofType:@"mp3"];
    NSURL *sound3Url = [NSURL fileURLWithPath:sound3];
    NSString *sound4 = [[NSBundle mainBundle] pathForResource:@"ShowMeLove" ofType:@"mp3"];
    NSURL *sound4Url = [NSURL fileURLWithPath:sound4];
    NSString *sound5 = [[NSBundle mainBundle] pathForResource:@"GoCrazy" ofType:@"mp3"];
    NSURL *sound5Url = [NSURL fileURLWithPath:sound5];
    NSString *sound6 = [[NSBundle mainBundle] pathForResource:@"MyType" ofType:@"mp3"];
    NSURL *sound6Url = [NSURL fileURLWithPath:sound6];
    NSString *sound7 = [[NSBundle mainBundle] pathForResource:@"BackToTheStreets" ofType:@"mp3"];
    NSURL *sound7Url = [NSURL fileURLWithPath:sound7];
    NSString *sound8 = [[NSBundle mainBundle] pathForResource:@"TheWeekend" ofType:@"mp3"];
    NSURL *sound8Url = [NSURL fileURLWithPath:sound8];
    
    
    self.songsList = @[
        [[AVPlayerItem alloc]initWithURL:soundUrl],
        [[AVPlayerItem alloc]initWithURL:sound2Url],
        [[AVPlayerItem alloc]initWithURL:sound3Url],
        [[AVPlayerItem alloc]initWithURL:sound4Url],
        [[AVPlayerItem alloc]initWithURL:sound5Url],
        [[AVPlayerItem alloc]initWithURL:sound6Url],
        [[AVPlayerItem alloc]initWithURL:sound7Url],
        [[AVPlayerItem alloc]initWithURL:sound8Url]
    ];
    
    self.songs = @[
        [[Song alloc]initWithSongName:@"Come Thru" artistName:@"Summer Walker" coverImg:[UIImage imageNamed:@"cover2"]],
        [[Song alloc]initWithSongName:@"I Am Gonna Love You Just A Little More" artistName:@"Summer Walker" coverImg:[UIImage imageNamed:@"cover5"]],
        [[Song alloc]initWithSongName:@"Kiss More" artistName:@"Doja Cat Ft. SZA" coverImg:[UIImage imageNamed:@"cover4"]],
        [[Song alloc]initWithSongName:@"Show Me Love" artistName:@"Alicia Keys Ft. 21 Savage" coverImg:[UIImage imageNamed:@"cover8"]],
        [[Song alloc]initWithSongName:@"Go Crazy" artistName:@"Chris Brown" coverImg:[UIImage imageNamed:@"cover6"]],
        [[Song alloc]initWithSongName:@"My Type" artistName:@"Saweetie" coverImg:[UIImage imageNamed:@"cover9"]],
        [[Song alloc]initWithSongName:@"Back To The Streets" artistName:@"Saweetie" coverImg:[UIImage imageNamed:@"cover7"]],
        [[Song alloc]initWithSongName:@"The Weekend" artistName:@"SZA" coverImg:[UIImage imageNamed:@"cover3"]]
    ];
    
    self.player = [[AVQueuePlayer alloc]initWithItems:self.songsList];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:true error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    self.isPlaying = false;
    self.currentPlaying = 0;
    self.prevItem = nil;
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
