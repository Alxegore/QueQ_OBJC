//
//  HTTPService.h
//  QueQ_OBJC
//
//  Created by Nattaphon Thammarcheep on 31/5/2561 BE.
//  Copyright © 2561 Nattaphon Thammarcheep. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^onComplete)(NSArray * __nullable dataArray, NSString * __nullable errMessage);

@interface HTTPService : NSObject

+ (id) instance;
- (void) getRestaurant:(nullable onComplete)completionHandler;
- (void) getPromotion:(nullable onComplete)completionHandler;

@end
