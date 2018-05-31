//
//  Queue.h
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 30/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject
@property (nonatomic, strong) NSString *restaurantLogo;
@property (nonatomic, strong) NSString *restaurantName;
@property (nonatomic, strong) NSString *restaurantLocation;
@property (nonatomic, strong) NSString *eatingType;
@property (nonatomic, assign) NSInteger restaurantQueue;
@property (nonatomic, assign) NSInteger amountSeat;
@end
