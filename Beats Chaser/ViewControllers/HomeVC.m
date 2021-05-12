//
//  HomeVC.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-07.
//

#import "HomeVC.h"
#import "HomeViewCell.h"
#import "TopHitsCell.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self configureSegmentedControl:self.segmentedControl];
    
    [self.segmentedControl addTarget:self action:@selector(moveUnderlineSegmentedControl) forControlEvents:UIControlEventValueChanged];
    [self.collectionView setHidden:false];
    [self.tableView setHidden:true];
    self.xPosition = self.segmentedControl.layer.frame.origin.x;
    self.widthCons.constant = [UIScreen mainScreen].bounds.size.width/2 - 28;
    [self.underline layoutIfNeeded];
    
    [self setupAttributedPlaceholder];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    tap.numberOfTapsRequired = 1;
    [self.homeView addGestureRecognizer:tap];
    
    //tab bar logic
    self.selection = 0;
    
    UITapGestureRecognizer *homeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(homeBtnAction)];
    homeTap.numberOfTapsRequired = 1;
    [self.homeBtn addGestureRecognizer:homeTap];
    
    UITapGestureRecognizer *browseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browseBtnAction)];
    browseTap.numberOfTapsRequired = 1;
    [self.browseBtn addGestureRecognizer:browseTap];
    
    UITapGestureRecognizer *favoriteTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(favoriteBtnAction)];
    favoriteTap.numberOfTapsRequired = 1;
    [self.favoriteBtn addGestureRecognizer:favoriteTap];

}

- (void)browseBtnAction{
    self.selection = 1;
    [self.homeView setHidden:true];
    [self.favoriteView setHidden:true];
    [self.browseView setHidden:false];
    self.browseBtnTxt.textColor = [UIColor colorNamed:@"mainColor"];
    self.browseBtnImg.tintColor = [UIColor colorNamed:@"mainColor"];
    self.favoriteBtnTxt.textColor = [UIColor darkGrayColor];
    self.favoriteBtnImg.tintColor = [UIColor darkGrayColor];
    self.homeBtnTxt.textColor = [UIColor darkGrayColor];
    self.homeBtnImg.tintColor = [UIColor darkGrayColor];
}


- (void)favoriteBtnAction{
    self.selection = 2;
    [self.homeView setHidden:true];
    [self.browseView setHidden:true];
    [self.favoriteView setHidden:false];
    self.favoriteBtnTxt.textColor = [UIColor colorNamed:@"mainColor"];
    self.favoriteBtnImg.tintColor = [UIColor colorNamed:@"mainColor"];
    self.homeBtnTxt.textColor = [UIColor darkGrayColor];
    self.homeBtnImg.tintColor = [UIColor darkGrayColor];
    self.browseBtnTxt.textColor = [UIColor darkGrayColor];
    self.browseBtnImg.tintColor = [UIColor darkGrayColor];
}

- (void)homeBtnAction{
    self.selection = 0;
    [self.browseView setHidden:true];
    [self.favoriteView setHidden:true];
    [self.homeView setHidden:false];
    self.homeBtnTxt.textColor = [UIColor colorNamed:@"mainColor"];
    self.homeBtnImg.tintColor = [UIColor colorNamed:@"mainColor"];
    self.browseBtnTxt.textColor = [UIColor darkGrayColor];
    self.browseBtnImg.tintColor = [UIColor darkGrayColor];
    self.favoriteBtnTxt.textColor = [UIColor darkGrayColor];
    self.favoriteBtnImg.tintColor = [UIColor darkGrayColor];
}

- (void)dismissKeyboard{
    [self.searchTxtField resignFirstResponder];
}


//collection view delegate methods
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
    [segmentedControl setBackgroundColor:[UIColor blackColor]];
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    [segmentedControl setSelectedSegmentTintColor:[[UIColor alloc]initWithRed:244/255 green:145/255 blue:60/255 alpha:1]];
    
}


- (void)moveUnderlineSegmentedControl{
    
    if(self.segmentedControl.selectedSegmentIndex == 0){
        [UIView animateWithDuration:0.18 animations:^{
            CGRect rect = self.underline.layer.frame;
            rect.origin.x = self.xPosition;
            [self.underline setFrame:rect];
        }];
        [self.collectionView setHidden:false];
        [self.tableView setHidden:true];
    }else if(self.segmentedControl.selectedSegmentIndex == 1){
        [UIView animateWithDuration:0.18 animations:^{
            CGRect rect = self.underline.layer.frame;
            rect.origin.x = self.xPosition + rect.size.width;
            [self.underline setFrame:rect];
        }];
        [self.collectionView setHidden:true];
        [self.tableView setHidden:false];
    }
    
}

//table view delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopHitsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopHitsCell" forIndexPath:indexPath];
    
    if(cell!=nil){
        [cell configureCell];
        return cell;
    }else{
        return cell;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)setupAttributedPlaceholder{
    self.searchTxtField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
}

@end
