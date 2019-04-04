//
//  PublishLocationView.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/3/2.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishLocationView : UIView

@property (nonatomic, copy) dispatch_block_t publishLocationViewBlock;

@property (nonatomic, copy) NSString *locationStr;

@end

NS_ASSUME_NONNULL_END
