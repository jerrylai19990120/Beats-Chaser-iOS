//
//  HomeVC.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-07.
//

#import "HomeVC.h"
#import "HomeViewCell.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self configureSegmentedControl:self.segmentedControl];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeViewCell" forIndexPath:indexPath];
    if(cell!=nil){
        [cell configureCell];
        return cell;
    }else{
        return cell;
    }
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)configureSegmentedControl:(UISegmentedControl *)segmentedControl{
    [segmentedControl setBackgroundColor:[[UIColor alloc]initWithRed:244/255 green:145/255 blue:60/255 alpha:1]];
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    [segmentedControl setSelectedSegmentTintColor:[[UIColor alloc]initWithRed:244/255 green:145/255 blue:60/255 alpha:1]];
}

- (void)addUnderlineSegmentedControl:(UISegmentedControl *)segmentedControl{
    
}

- (void)moveUnderlineSegmentedControl:(UISegmentedControl *)segmentedControl{
    
}

@end
