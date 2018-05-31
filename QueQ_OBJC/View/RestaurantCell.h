//
//  RestaurantCell.h
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 29/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;
@interface RestaurantCell : UITableViewCell
-(void)updateUI:(nonnull Restaurant*)restaurant;
@end
