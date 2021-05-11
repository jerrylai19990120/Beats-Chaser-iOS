//
//  RoundedCornerOutlinedBtn.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-11.
//

#import "RoundedCornerOutlinedBtn.h"

@implementation RoundedCornerOutlinedBtn

- (void)setupView{
    self.layer.cornerRadius = 16;
    self.layer.masksToBounds = true;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)awakeFromNib{
    [self setupView];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setupView];
}

@end
