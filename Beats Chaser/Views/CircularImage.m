//
//  CircularImage.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-11.
//

#import "CircularImage.h"

@implementation CircularImage

- (void)setupView{
    self.layer.cornerRadius = self.layer.bounds.size.width / 2;
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
