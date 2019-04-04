//
//  SpaceCenterViewModel.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/28.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "SpaceCenterViewModel.h"

@implementation SpaceCenterViewModel

- (RACSignal *)signalForModel{
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    NSArray *likeArr = @[
                         @{
                             @"userName":@"asdf",
                             @"userId":@"10",
                             @"picture":@"http://img0.pconline.com.cn/pconline/1506/29/6638168_1754_thumb.jpg"
                             },
                         @{
                             @"userName":@"asdf",
                             @"userId":@"10",
                             @"picture":@"http://img0.pconline.com.cn/pconline/1506/29/6638168_1754_thumb.jpg"
                             },
                         @{
                             @"userName":@"asdf",
                             @"userId":@"10",
                             @"picture":@"http://img0.pconline.com.cn/pconline/1506/29/6638168_1754_thumb.jpg"
                             },
                         @{
                             @"userName":@"asdf",
                             @"userId":@"10",
                             @"picture":@"http://img0.pconline.com.cn/pconline/1506/29/6638168_1754_thumb.jpg"
                             }
                         ];
    NSArray *commentArr = @[
                            @{
                                @"firstPicure":@"http://img0.pconline.com.cn/pconline/1506/29/6638168_1754_thumb.jpg",
                                @"time":@"12-11 12:45",
                                @"firstUserName":@"若风",
                                @"firstUserId":@"1",
                                @"secondUserName":@"",
                                @"secondUserId":@"",
                                @"commentString":@"asdfasfljasdl;fkjasdlk;jflasjl;afasfasfasfasjglaksjglkaj",
                                },
                            @{
                                @"firstPicure":@"http://img0.pconline.com.cn/pconline/1506/29/6638168_1754_thumb.jpg",
                                @"time":@"12-11 12:45",
                                @"firstUserName":@"若风",
                                @"firstUserId":@"1",
                                @"secondUserName":@"猪猪王",
                                @"secondUserId":@"2",
                                @"commentString":@"asdfasdf",
                                },
                            @{
                                @"firstPicure":@"http://img0.pconline.com.cn/pconline/1506/29/6638168_1754_thumb.jpg",
                                @"time":@"12-11 12:45",
                                @"firstUserName":@"若风",
                                @"firstUserId":@"1",
                                @"secondUserName":@"猪猪王",
                                @"secondUserId":@"2",
                                @"commentString":@"asdfasdf",
                                },
                            @{
                                @"firstPicure":@"http://img0.pconline.com.cn/pconline/1506/29/6638168_1754_thumb.jpg",
                                @"time":@"12-11 12:45",
                                @"firstUserName":@"若风",
                                @"firstUserId":@"1",
                                @"secondUserName":@"猪猪王",
                                @"secondUserId":@"2",
                                @"commentString":@"asdfasdf",
                                }
                            ];
    NSDictionary *modes = @{
                            @"iconNameUrl":@"http://img0.pconline.com.cn/pconline/1506/29/6638168_1754_thumb.jpg",
                            @"nameStr":@"昵称一",
                            @"contentStr":@"百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。",
                            @"pictureArray":@[@"http://pic1.nipic.com/2008-12-30/200812308231244_2.jpg",
                                              @"http://img.daimg.com/uploads/allimg/130902/1-130Z2000247.jpg",
                                              @"http://img.daimg.com/uploads/allimg/120313/3-1203131G45XM.jpg"],
                            @"time":@"12-11 12:45",
                            @"faousNum":@"10000",
                            @"commentNum":@"10000",
                            @"cityName":@"南京市 汇智大厦",
                            @"commentItemsArray": commentArr,
                            @"likeItemsArray": likeArr
                            };
    
    self.spaceModel = [BFPActivitySpaceModel mj_objectWithKeyValues:modes];
    
    [subject sendNext:_spaceModel];
    [subject sendCompleted];
    [subject sendError:nil];
    
    return subject;
    
}

@end
