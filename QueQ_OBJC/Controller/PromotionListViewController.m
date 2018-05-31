//
//  PromotionListViewController.m
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 29/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import "PromotionListViewController.h"
#import "PromotionCell.h"
#import "Promotion.h"
#import "PromotionDetailViewController.h"
#import "HTTPService.h"

@interface PromotionListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *promotionTable;
@property (nonatomic, strong) NSArray *promotionList;
@end

@implementation PromotionListViewController

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.promotionTable.dataSource = self;
    self.promotionTable.delegate = self;
    // Do any additional setup after loading the view.
    
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
#pragma mark - table
-(void) updateTableData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.promotionTable reloadData];
    });
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PromotionCell *cell = (PromotionCell*)[tableView dequeueReusableCellWithIdentifier:@"mainPromotion"];
    if(!cell){
        cell = [[PromotionCell alloc] init];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    Promotion *promotion = [self.promotionList objectAtIndex:indexPath.row];
    PromotionCell *proCell = (PromotionCell*)cell;
    [proCell updateUI:promotion];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Promotion *promotion = [self.promotionList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"promotionVC" sender:promotion];
}

-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _promotionList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"promotionVC"]){
        PromotionDetailViewController *vc = (PromotionDetailViewController*)segue.destinationViewController;
        Promotion *promotion = (Promotion*)sender;
        vc.promotion = promotion;
    }
}


@end
