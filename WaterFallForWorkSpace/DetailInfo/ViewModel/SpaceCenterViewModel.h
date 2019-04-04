//
//  SpaceCenterViewModel.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/28.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFPActivitySpaceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SpaceCenterViewModel : NSObject

// 互动空间
@property (nonatomic, strong) BFPActivitySpaceModel *spaceModel;

- (RACSignal *)signalForModel;

@end

NS_ASSUME_NONNULL_END
