//
//  HomeVC.h
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-07.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthCons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIView *underline;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIStackView *homeBtn;
@property (weak, nonatomic) IBOutlet UIStackView *artistsBtn;
@property (weak, nonatomic) IBOutlet UIStackView *favoriteBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchTxtField;
@property (assign) CGFloat xPosition;
- (void)configureSegmentedControl:(UISegmentedControl *)segmentedControl;
- (void)moveUnderlineSegmentedControl;
- (void)setupAttributedPlaceholder;
@end

