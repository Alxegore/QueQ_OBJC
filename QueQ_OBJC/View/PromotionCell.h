//
//  PromotionCell.h
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 30/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Promotion;
@interface PromotionCell : UITableViewCell
-(void)updateUI:(nonnull Promotion*)promotion;

@end
