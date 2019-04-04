//
//  BFPActivitySubViewModel.m
//  BFPlus
//
//  Created by hzhy001 on 2018/12/21.
//  Copyright © 2018 hzhy001. All rights reserved.
//

#import "BFPActivitySubViewModel.h"

@implementation BFPActivitySubViewModel

- (NSArray *)spaceModels{
    if (!_spaceModels) {
        
        NSArray *likeArr = @[
                             @{
                                 @"userName":@"asdf",
                                 @"userId":@"10",
                                 }
                             ];
        NSArray *commentArr = @[
                                @{
                                    @"firstUserName":@"若风",
                                    @"firstUserId":@"1",
                                    @"secondUserName":@"",
                                    @"secondUserId":@"",
                                    @"commentString":@"asdfasfljasdl;fkjasdlk;jflasjl;afasfasfasfasjglaksjglkaj",
                                    },
                                @{
                                    @"firstUserName":@"若风",
                                    @"firstUserId":@"1",
                                    @"secondUserName":@"猪猪王",
                                    @"secondUserId":@"2",
                                    @"commentString":@"asdfasdf",
                                    },
                                @{
                                    @"firstUserName":@"若风",
                                    @"firstUserId":@"1",
                                    @"secondUserName":@"猪猪王",
                                    @"secondUserId":@"2",
                                    @"commentString":@"asdfasdf",
                                    },
                                @{
                                    @"firstUserName":@"若风",
                                    @"firstUserId":@"1",
                                    @"secondUserName":@"猪猪王",
                                    @"secondUserId":@"2",
                                    @"commentString":@"asdfasdf",
                                    }
                                ];
        NSDictionary *videoDic = @{
                                   @"cover" : @"http://vimg1.ws.126.net/image/snapshot/2018/3/R/I/VDB9N77RI.jpg",
                                   @"description" : @"",
                                   @"length" : @"15",
                                   @"m3u8Hd_url" : @"<null>",
                                   @"m3u8_url" : @"http://flv.bn.netease.com/tvmrepo/2018/3/P/C/EDB9N6VPC/SD/movie_index.m3u8",
                                   @"mp4Hd_url" : @"<null>",
                                   @"mp4_url" : @"http://flv3.bn.netease.com/tvmrepo/2018/3/P/C/EDB9N6VPC/SD/EDB9N6VPC-mobile.mp4",
                                   @"playCount" : @"0",
                                   @"playersize" : @"0",
                                   @"ptime" : @"2018-06-27 00:00:00",
                                   @"replyBoard" : @"video_bbs",
                                   @"replyCount" : @"0",
                                   @"replyid" : @"DB9N795J008535RB",
                                   @"sectiontitle" : @"",
                                   @"sizeHD" : @"0",
                                   @"sizeSD" : @"652",
                                   @"sizeSHD" : @"0",
                                   @"title" : @"这是标题",
                                   @"topicDesc" : @"这是顶部标题",
                                   @"topicImg" : @"http://vimg3.ws.126.net/image/snapshot/2016/3/M/M/VBH9CQHMM.jpg",
                                   @"topicName" : @"topic名称",
                                   @"topicSid" : @"VBH9CQHMJ",
                                   @"vid" : @"VDB9N795J",
                                   @"videoTopic" :     @{
                                           @"alias" : @"alias名称",
                                           @"ename" : @"T1462517550831",
                                           @"tid" : @"T1462517550831",
                                           @"tname" : @"t名称",
                                           @"topic_icons" : @"http://img2.cache.netease.com/m/newsapp/topic_icons/T1462517550831.png",
                                   },
                                   @"videosource" : @"视频来源",
                                   @"votecount" : @"0"
                                   };
        NSArray *modes = @[@{
                               @"iconNameUrl":@"http://img0.pconline.com.cn/pconline/1506/29/6638168_1754_thumb.jpg",
                               @"nameStr":@"昵称一",
                               @"contentStr":@"百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。",
                               @"pictureArray":@[@"http://pic1.nipic.com/2008-12-30/200812308231244_2.jpg",
                                             @"http://img.daimg.com/uploads/allimg/130902/1-130Z2000247.jpg",
                                             @"http://img.daimg.com/uploads/allimg/120313/3-1203131G45XM.jpg"],
                               @"time":@"12-11 12:45",
                               @"faousNum":@"10000",
                               @"commentNum":@"10000",
                               @"cityName":@"南京市 汇智大厦",
                               @"commentItemsArray": commentArr,
                               @"likeItemsArray": @[]
                               },
                           @{
                               @"iconNameUrl":@"http://img0.pconline.com.cn/pconline/1506/29/6638168_1758_thumb.jpg",
                               @"nameStr":@"昵称二",
                               @"contentStr":@"百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。",
                               @"pictureArray":@[],
                               @"time":@"12-11 12:45",
                               @"faousNum":@"56",
                               @"commentNum":@"120",
                               @"cityName":@"南京市 汇智大厦",
                               @"videoModel":videoDic

                               },
                           @{
                               @"iconNameUrl":@"http://img.mp.itc.cn/upload/20161228/8a7924c41ebe484d8e69b29a3b9d2847_th.png",
                               @"nameStr":@"昵称二",
                               @"contentStr":@"百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。百度图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。",
                               @"pictureArray":@[@"http://img1.imgtn.bdimg.com/it/u=2502073311,3044549660&fm=26&gp=0.jpg"],
                               @"time":@"12-11 12:45",
                               @"faousNum":@"56",
                               @"commentNum":@"120",
                               @"cityName":@"南京市 汇智大厦",
                               }];
        
        _spaceModels = [BFPActivitySpaceModel mj_objectArrayWithKeyValuesArray:modes];
    }
    return _spaceModels;
}

@end
