//
//  BookingViewController.m
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 29/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import "BookingViewController.h"
#import "BookingDetailViewController.h"
#import "SearchViewController.h"
#import "Restaurant.h"
#import "Queue.h"

@interface BookingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *restaurantLogo;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLocation;
@property (weak, nonatomic) IBOutlet UILabel *restaurantQueue;
@property (weak, nonatomic) IBOutlet UISegmentedControl *chooseEatingOption;
@property (weak, nonatomic) IBOutlet UILabel *amountSeatLabel;
@property (nonatomic, strong) Queue *queue;
@property (nonatomic, assign) NSInteger amountSeat;
@property (nonatomic, assign) NSInteger selectedEatingOption;
@end

@implementation BookingViewController

- (IBAction)donePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)changeAmountSeat:(UIStepper *)sender {
    _amountSeat = sender.value;
    _amountSeatLabel.text = [NSString stringWithFormat:@"%ld",(long)_amountSeat];
}
- (IBAction)selectEatingOption:(id)sender {
    if([sender selectedSegmentIndex] == 0){
        _selectedEatingOption = 0;
    }
    else if([sender selectedSegmentIndex] == 1){
        _selectedEatingOption = 1;
    }
    else{
        _selectedEatingOption = 2;
    }
}
- (IBAction)gotoBookingDetail:(id)sender {
    _queue.amountSeat = self.amountSeat;
    if(_selectedEatingOption == 0)
        _queue.eatingType = @"Buffet";
    else if(_selectedEatingOption == 1)
        _queue.eatingType = @"A la carte";
    else
        _queue.eatingType = @"Free";
    [self performSegueWithIdentifier:@"bookingDetail" sender:_queue];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"bookingDetail"]){
        BookingDetailViewController *vc = (BookingDetailViewController*)segue.destinationViewController;
        vc.queue = (Queue*)sender;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _queue = [[Queue alloc] init];
    _queue.restaurantLogo = _restaurant.restaurantLogo;
    _queue.restaurantName = _restaurant.restaurantName;
    _queue.restaurantLocation = _restaurant.restaurantLocation;
    _queue.restaurantQueue = _restaurant.restaurantQueue;
    self.amountSeat = 1;
    _restaurantName.text = _queue.restaurantName;
    _restaurantLocation.text = _queue.restaurantLocation;
    _restaurantQueue.text = [NSString stringWithFormat:@"รออีก %ld คิว",(long)_queue.restaurantQueue];
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
