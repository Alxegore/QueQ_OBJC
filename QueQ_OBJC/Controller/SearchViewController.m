//
//  SearchViewController.m
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 29/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import "SearchViewController.h"
#import "Restaurant.h"
#import "RestaurantCell.h"
#import "BookingViewController.h"
#import "HTTPService.h"

@interface SearchViewController (){
    BOOL isFiltered;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *restaurantTable;
@property (nonatomic, strong) NSArray *restaurantList;
@property (nonatomic, strong) NSMutableArray *filteredRestaurantList;
@end

@implementation SearchViewController

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.restaurantTable.delegate = self;
    self.restaurantTable.dataSource = self;
    _searchBar.backgroundImage = [[UIImage alloc] init];
    [_searchBar becomeFirstResponder];
    self.restaurantList = [[NSArray alloc] init];
    [[HTTPService instance] getRestaurant:^(NSArray * _Nullable dataArray, NSString * _Nullable errMessage) {
        if (dataArray) {
            
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            
            for (NSDictionary *data in dataArray) {
                Restaurant *res = [[Restaurant alloc]init];
                res.restaurantName = [data objectForKey:@"name"];
                res.restaurantLocation = [data objectForKey:@"location"];
                res.restaurantQueue = [[data objectForKey:@"queue"] integerValue];
                [arr addObject:res];
            }
            
            self.restaurantList = arr;
            [self updateTableData];
            
        } else if (errMessage) {
            
        }
    }];
    isFiltered = false;
    // Do any additional setup after loading the view.
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        isFiltered = false;
        _filteredRestaurantList = [[NSMutableArray alloc] init];
    }
    else{
        isFiltered = true;
        _filteredRestaurantList = [[NSMutableArray alloc] init];
        for(Restaurant *restaurant in _restaurantList){
            NSRange nameRange = [restaurant.restaurantName rangeOfString:searchText];
            NSRange locationRange = [restaurant.restaurantLocation rangeOfString:searchText];
            if(nameRange.location != NSNotFound || locationRange.location != NSNotFound){
                [_filteredRestaurantList addObject:restaurant];
            }
        }
    }
    [self updateTableData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - table
-(void) updateTableData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.restaurantTable reloadData];
    });
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantCell *cell = (RestaurantCell*)[tableView dequeueReusableCellWithIdentifier:@"main"];
    if(!cell){
        cell = [[RestaurantCell alloc] init];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    Restaurant *restaurant = [self.filteredRestaurantList objectAtIndex:indexPath.row];
    RestaurantCell *resCell = (RestaurantCell*)cell;
    [resCell updateUI:restaurant];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filteredRestaurantList.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Restaurant *restaurant = [self.filteredRestaurantList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"restaurantVC" sender:restaurant];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"restaurantVC"]){
        BookingViewController *vc = (BookingViewController*)segue.destinationViewController;
        Restaurant *restaurant = (Restaurant*)sender;
        vc.restaurant = restaurant;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
