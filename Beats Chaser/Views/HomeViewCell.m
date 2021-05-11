//
//  HomeViewCell.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-11.
//

#import "HomeViewCell.h"

@implementation HomeViewCell

- (void)configureCell{
    self.categoryTxt.text = @"R&B Soul";
    self.categoryImg.image = [UIImage imageNamed:@"cover"];
}

@end
