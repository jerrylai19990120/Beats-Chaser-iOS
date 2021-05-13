//
//  RoundedCornerImage.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-13.
//

#import "RoundedCornerImage.h"

@implementation RoundedCornerImage

- (void)setupView{
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = true;
}

- (void)awakeFromNib{
    [self setupView];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setupView];
}

@end
