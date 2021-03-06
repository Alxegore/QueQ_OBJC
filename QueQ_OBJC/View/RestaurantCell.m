//
//  RestaurantCell.m
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 29/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import "RestaurantCell.h"
#import "Restaurant.h"
@interface RestaurantCell()
@property (weak, nonatomic) IBOutlet UIImageView *restaurantLogo;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLocation;
@property (weak, nonatomic) IBOutlet UILabel *restaurantQueue;
@property (weak, nonatomic) IBOutlet UIView *cellView;

@end

@implementation RestaurantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 2.0;
    self.layer.shadowColor = [UIColor colorWithRed:157.0 / 255.0 green:157.0 / 255.0 blue:157.0 / 255.0 alpha:0.8].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
}

-(void)updateUI:(nonnull Restaurant*)restaurant{
    self.restaurantName.text = restaurant.restaurantName;
    self.restaurantLocation.text = restaurant.restaurantLocation;
    self.restaurantQueue.text = [NSString stringWithFormat: @"รออีก %li คิว", restaurant.restaurantQueue];
    
}

@end
