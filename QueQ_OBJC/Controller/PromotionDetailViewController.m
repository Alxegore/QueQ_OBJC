//
//  PromotionDetailViewController.m
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 29/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import "PromotionDetailViewController.h"
#import "Promotion.h"

@interface PromotionDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *promotionImage;
@property (weak, nonatomic) IBOutlet UILabel *promotionTitle;
@property (weak, nonatomic) IBOutlet UILabel *promotionInfo;

@end

@implementation PromotionDetailViewController
@synthesize promotion;

- (IBAction)donePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _promotionTitle.text = promotion.promotionName;
    _promotionInfo.text = promotion.promotionDetail;
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
