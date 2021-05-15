//
//  ResultCell.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-15.
//

#import "ResultCell.h"

@implementation ResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell{
    self.coverImg.image = [UIImage imageNamed:@"cover4"];
    self.artistTxt.text = @"Doja Cat Ft. Sza";
    self.nameTxt.text = @"Kiss More";
}
@end
