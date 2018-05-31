//
//  Restaurant.h
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 29/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject
@property (nonatomic, strong) NSString *restaurantName;
@property (nonatomic, strong) NSString *restaurantLocation;
@property (nonatomic, assign) NSInteger restaurantQueue;
@property (nonatomic, strong) NSString *restaurantLogo;
@end
