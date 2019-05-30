//
//  ADFlutterRouter.h
//  ADFLiOS
//
//  Created by Andy on 2019/5/30.
//  Copyright © 2019 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <flutter_boost/FLBPlatform.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADFlutterRouter : NSObject<FLBPlatform>

+ (ADFlutterRouter *)sharedRouter;

@end

NS_ASSUME_NONNULL_END
