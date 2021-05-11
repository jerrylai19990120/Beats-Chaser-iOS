//
//  TopHitsCell.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-11.
//

#import "TopHitsCell.h"

@implementation TopHitsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell{
    self.artistNameTxt.text = @"Tyler the Creator";
    self.coverImg.image = [UIImage imageNamed:@"cover"];
    self.songNameTxt.text = @"EARFQUAKE";
}

@end
