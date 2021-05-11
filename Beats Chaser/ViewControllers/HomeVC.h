//
//  HomeVC.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-07.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIStackView *homeBtn;
@property (weak, nonatomic) IBOutlet UIStackView *artistsBtn;
@property (weak, nonatomic) IBOutlet UIStackView *favoriteBtn;
- (void)configureSegmentedControl:(UISegmentedControl *)segmentedControl;
- (void)addUnderlineSegmentedControl:(UISegmentedControl *)segmentedControl;
- (void)moveUnderlineSegmentedControl:(UISegmentedControl *)segmentedControl;
@end

