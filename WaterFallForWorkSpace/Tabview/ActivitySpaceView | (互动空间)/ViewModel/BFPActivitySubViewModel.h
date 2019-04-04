//
//  BFPActivitySubViewModel.h
//  BFPlus
//
//  Created by hzhy001 on 2018/12/21.
//  Copyright © 2018 hzhy001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFPActivitySpaceModel.h"

@class BFPActivityModel;
@class BFPReleatedActivityModel;

NS_ASSUME_NONNULL_BEGIN

@interface BFPActivitySubViewModel : NSObject
// 互动空间
@property (nonatomic, strong) NSArray <BFPActivitySpaceModel*> *spaceModels;

@end

NS_ASSUME_NONNULL_END
