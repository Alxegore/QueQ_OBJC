//
//  PromotionCell.m
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 30/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import "PromotionCell.h"
#import "Promotion.h"

@interface PromotionCell()
@property (weak, nonatomic) IBOutlet UIImageView *promotionImage;
@property (weak, nonatomic) IBOutlet UILabel *promotionName;
@property (weak, nonatomic) IBOutlet UILabel *promotionPlace;
@property (weak, nonatomic) IBOutlet UIView *cellView;

@end

@implementation PromotionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 2.0;
    self.layer.shadowColor = [UIColor colorWithRed:157.0 / 255.0 green:157.0 / 255.0 blue:157.0 / 255.0 alpha:0.8].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
}

-(void)updateUI:(nonnull Promotion*)promotion{
    self.promotionName.text = promotion.promotionName;
    self.promotionPlace.text = promotion.promotionPlace;
    NSLog(@"%@",self.promotionName.text);
}


@end
