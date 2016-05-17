//
//  CheckLocation.h
//  DBSC4
//
//  Created by Tan Chun Yew on 1/18/16.
//  Copyright © 2016 ncs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckLocation : NSObject

+ (instancetype)sharedManager;
- (void)startGetLocation;

@end
