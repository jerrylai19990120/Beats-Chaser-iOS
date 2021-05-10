//
//  RoundedCornerView.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-10.
//

#import "RoundedCornerView.h"

@implementation RoundedCornerView

- (void)awakeFromNib{
    [self setupView];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setupView];
}

- (void)setupView{
    self.layer.cornerRadius = 16;
    self.layer.masksToBounds = true;
}

@end
