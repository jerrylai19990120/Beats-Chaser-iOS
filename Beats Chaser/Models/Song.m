//
//  Song.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-16.
//

#import "Song.h"

@implementation Song

- (id)initWithSongName:(NSString *)songName artistName:(NSString *)artistName coverImg:(UIImage *)coverImg{
    self = [super init];
    
    if(self){
        self.songName = songName;
        self.artistName = artistName;
        self.coverImg = coverImg;
    }
    
    return self;
}

@end
