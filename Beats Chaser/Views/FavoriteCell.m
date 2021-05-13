//
//  FavoriteCell.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-13.
//

#import "FavoriteCell.h"

@implementation FavoriteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell{
    self.artistTxt.text = @"Sza";
    self.songNameTxt.text = @"The Weekend";
    self.coverImg.image = [UIImage imageNamed:@"cover3"];
}

@end
