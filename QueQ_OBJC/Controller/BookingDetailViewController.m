//
//  BookingDetailViewController.m
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 29/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import "BookingDetailViewController.h"
#import "Queue.h"

@interface BookingDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *restaurantLogo;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLocation;
@property (weak, nonatomic) IBOutlet UILabel *restaurantQueue;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *eatingOption;
@property (weak, nonatomic) IBOutlet UILabel *amountSeat;

@end

@implementation BookingDetailViewController
@synthesize queue;

- (IBAction)donePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _restaurantName.text = queue.restaurantName;
    _restaurantLocation.text = queue.restaurantLocation;
    _restaurantQueue.text = [NSString stringWithFormat:@"%ld",(long)queue.restaurantQueue];
    _eatingOption.text = queue.eatingType;
    _amountSeat.text =[NSString stringWithFormat:@"%ld",(long)queue.amountSeat];
    NSDate *time = [NSDate date];
    NSDateFormatter *outputDate = [[NSDateFormatter alloc] init];
    [outputDate setDateFormat:@"dd/MM/yyyy"];
    _dateLabel.text = [outputDate stringFromDate:time];
    NSDateFormatter *outputTime = [[NSDateFormatter alloc] init];
    [outputTime setDateFormat:@"HH:mm:ss"];
    _timeLabel.text = [outputTime stringFromDate:time];
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

@end
