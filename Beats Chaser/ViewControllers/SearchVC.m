//
//  SearchVC.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-15.
//

#import "SearchVC.h"
#import "ResultCell.h"

@interface SearchVC ()

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    self.searchField.returnKeyType = UIReturnKeySearch;
    self.searchField.enablesReturnKeyAutomatically = true;
    self.searchField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.searchField resignFirstResponder];
    return true;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCell" forIndexPath:indexPath];
    if(cell != nil){
        [cell configureCell];
        return cell;
    }else{
        return [[UITableViewCell alloc]init];
    }
    
}



@end
