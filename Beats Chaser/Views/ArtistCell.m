//
//  ArtistCell.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-13.
//

#import "ArtistCell.h"

@implementation ArtistCell

- (void)configureCell{
    self.coverImg.image = [UIImage imageNamed:@"cover4"];
    self.artistNameTxt.text = @"Doja Cat Ft. Sza";
    self.genreTxt.text = @"R&B";
}

@end
