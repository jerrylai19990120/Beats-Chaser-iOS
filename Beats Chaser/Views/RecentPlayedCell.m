//
//  RecentPlayedCell.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-13.
//

#import "RecentPlayedCell.h"

@implementation RecentPlayedCell

- (void)configureCell{
    self.coverImg.image = [UIImage imageNamed:@"cover2"];
    self.artistNameTxt.text = @"Summer Walker";
    self.songNameTxt.text = @"Come Thru";
}

@end
