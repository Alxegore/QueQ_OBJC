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
#import "Promotion.h"
#import "PromotionCell.h"

@interface RestaurantListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *restaurantTable;
@property (nonatomic, strong) NSArray *restaurantList;
@property (nonatomic, strong) NSArray *promotionList;
@property (nonatomic, strong) NSMutableArray *boolList;
@end

@implementation RestaurantListViewController

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.restaurantTable.dataSource = self;
    self.restaurantTable.delegate = self;
    // Do any additional setup after loading the view.
    _boolList = [[NSMutableArray alloc] init];
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
                [_boolList addObject:[NSNumber numberWithBool:NO]];
                NSLog(@"eq %@ %@",[_boolList objectAtIndex:0],[NSNumber numberWithBool:NO]);
            }
            
            self.restaurantList = arr;
            [self updateTableData];
            
        } else if (errMessage) {
            
        }
    }];
    self.promotionList = [[NSArray alloc] init];
    [[HTTPService instance] getPromotion:^(NSArray * _Nullable dataArray, NSString * _Nullable errMessage) {
        if (dataArray) {
            
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            
            for (NSDictionary *data in dataArray) {
                Promotion *pro = [[Promotion alloc]init];
                pro.promotionName = [data objectForKey:@"name"];
                pro.promotionPlace = [data objectForKey:@"location"];
                pro.promotionDetail = [data objectForKey:@"detail"];
                [arr addObject:pro];
            }
            
            self.promotionList = arr;
            [self updateTableData];
            
        } else if (errMessage) {
            
        }
    }];
//    self.restaurantTable.userInteractionEnabled = YES;
    [self.view bringSubviewToFront:self.restaurantTable];
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
    if(indexPath.row == 0)
    {
        RestaurantCell *cell = (RestaurantCell*)[tableView dequeueReusableCellWithIdentifier:@"main"];
        if(!cell){
            cell = [[RestaurantCell alloc] init];
        }
        return cell;
    }
    else
    {
        PromotionCell *cell = (PromotionCell*)[tableView dequeueReusableCellWithIdentifier:@"mainPromotion"];
        if(!cell){
            cell = [[PromotionCell alloc] init];
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        Restaurant *restaurant = [self.restaurantList objectAtIndex:indexPath.section];
        RestaurantCell *resCell = (RestaurantCell*)cell;
        [resCell updateUI:restaurant];
    }
    else{
        Promotion *promotion = [self.promotionList objectAtIndex:indexPath.row];
        PromotionCell *proCell = (PromotionCell*)cell;
        [proCell updateUI:promotion];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _restaurantList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_restaurantList.count != 0 && [[_boolList objectAtIndex:section] boolValue] == NO){
        return 1;
    }
    else if(_restaurantList.count != 0){
        NSLog(@"eq");
        return _promotionList.count;
    }
    else
        return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0 && [[_boolList objectAtIndex:indexPath.section] boolValue] == NO){
        NSLog(@"%@ %@",[_boolList objectAtIndex:indexPath.section],[NSNumber numberWithBool:YES]);
        [_boolList replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:YES]];
        NSLog(@"%@ %@",[_boolList objectAtIndex:indexPath.section],[NSNumber numberWithBool:YES]);
        NSLog(@"%d %d",[[_boolList objectAtIndex:indexPath.section] boolValue],[[NSNumber numberWithBool:YES] boolValue]);
    }
    else if(indexPath.row == 0 && [[_boolList objectAtIndex:indexPath.section] boolValue] == YES){
        [_boolList replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:NO]];
    }
    [_restaurantTable reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
//    Restaurant *restaurant = [self.restaurantList objectAtIndex:indexPath.row];
//    [self performSegueWithIdentifier:@"restaurantVC" sender:restaurant];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"restaurantVC"]){
        BookingViewController *vc = (BookingViewController*)segue.destinationViewController;
        Restaurant *restaurant = (Restaurant*)sender;
        vc.restaurant = restaurant;
    }
}


@end
