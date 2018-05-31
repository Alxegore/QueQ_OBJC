//
//  RestaurantListViewController.m
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 29/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import "RestaurantListViewController.h"
#import "Restaurant.h"
#import "RestaurantCell.h"
#import "BookingViewController.h"
#import "HTTPService.h"

@interface RestaurantListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *restaurantTable;
@property (nonatomic, strong) NSArray *restaurantList;

@end

@implementation RestaurantListViewController

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.restaurantTable.dataSource = self;
    self.restaurantTable.delegate = self;
    // Do any additional setup after loading the view.
    
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
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)donePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    Restaurant *restaurant = [self.restaurantList objectAtIndex:indexPath.row];
    RestaurantCell *resCell = (RestaurantCell*)cell;
    [resCell updateUI:restaurant];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.restaurantList.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Restaurant *restaurant = [self.restaurantList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"restaurantVC" sender:restaurant];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"restaurantVC"]){
        BookingViewController *vc = (BookingViewController*)segue.destinationViewController;
        Restaurant *restaurant = (Restaurant*)sender;
        vc.restaurant = restaurant;
    }
}


@end
