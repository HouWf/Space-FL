//
//  BFPSpaceDetailViewController.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/28.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "BFPSpaceDetailViewController.h"
#import "SpaceCenterTableViewCell.h"
#import "SpaceCenterViewModel.h"
#import "SpaceCenterFabulousCell.h"
#import "SpaceCenterCommentCell.h"
#import "SpaceKeyboardView.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

static NSString *activityspace_cell_identifier = @"activityspace_cell_identifier";
static NSString *like_cell_identifier = @"like_cell_identifier";
static NSString *acomment_cell_identifier_to = @"acomment_cell_identifier_to";

@interface BFPSpaceDetailViewController ()<UITableViewDelegate, UITableViewDataSource, SpaceCenterTableViewCellDelegate, SpaceCenterFabulousCellDelegate, SpaceCenterCommentCellDelegate, KeyboardViewDelegate>

@property (nonatomic, strong) UITableView *main_tableView;

@property (nonatomic, strong) SpaceKeyboardView *keyboardView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) SpaceCenterViewModel *viewModel;

@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation BFPSpaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"详情";
    
    self.viewModel = [[SpaceCenterViewModel alloc] init];
    
    self.main_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[self.viewModel signalForModel] subscribeNext:^(id  _Nullable x) {
            [self.main_tableView reloadData];
            [self.main_tableView.mj_header endRefreshing];
        }];
    }];
    [self.main_tableView.mj_header beginRefreshing];
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.keyboardView];
}

#pragma mark - SpaceCenterFabulousCellDelegate
-(void)keyboardInputViewSendTextMessage:(NSString *)message;
{
    NSLog(@"keyboard message %@",message);
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BFPActivitySpaceModel *spaceModel = self.viewModel.spaceModel;
//    if (spaceModel.likeItemsArray.count != 0) {
//        return 2 + spaceModel.commentItemsArray.count;
//    }
    return  2 + spaceModel.commentItemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cusCell ;
    BFPActivitySpaceModel *spaceModel = self.viewModel.spaceModel;
    if (indexPath.row == 0) {
        SpaceCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:activityspace_cell_identifier];
        if (!cell) {
            cell = [[SpaceCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityspace_cell_identifier];
        }
        cell.spaceModel = spaceModel;
        cell.delegate = self;
        cusCell = cell;
    }
    else if (indexPath.row == 1) {
        SpaceCenterFabulousCell *cell = [tableView dequeueReusableCellWithIdentifier:like_cell_identifier];
        if (!cell) {
            cell = [[SpaceCenterFabulousCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:like_cell_identifier];
        }
        cell.delegate = self;
        cell.spaceModel = spaceModel;
        cusCell = cell;
    }
    else{
        SpaceCenterCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:acomment_cell_identifier_to];
        if (!cell) {
            cell = [[SpaceCenterCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:acomment_cell_identifier_to];
        }
        SDTimeLineCellCommentItemModel *commentModel = spaceModel.commentItemsArray[indexPath.row-2];
        cell.commentModel = commentModel;
        cell.delegate = self;
        [cell showCommentLogo:indexPath.row == 2];
        cusCell = cell;
    }
    cusCell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cusCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row  == 0) {
        BFPActivitySpaceModel *spaceModel = self.viewModel.spaceModel;
        CGFloat height = [self.main_tableView cellHeightForIndexPath:indexPath model:spaceModel keyPath:@"spaceModel" cellClass:[SpaceCenterTableViewCell class] contentViewWidth:Main_Screen_Width];
        return height;
    }
    else if (indexPath.row == 1){
        return self.cellHeight;
    }
    else{
        BFPActivitySpaceModel *spaceModel = self.viewModel.spaceModel;
        SDTimeLineCellCommentItemModel *commentModel = spaceModel.commentItemsArray[indexPath.row-2];
        CGFloat height = [self.main_tableView cellHeightForIndexPath:indexPath model:commentModel keyPath:@"commentModel" cellClass:[SpaceCenterCommentCell class] contentViewWidth:Main_Screen_Width];
        return height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 2) {
        return;
    }
    else{
        BFPActivitySpaceModel *spaceModel = self.viewModel.spaceModel;
        SDTimeLineCellCommentItemModel *commentModel = spaceModel.commentItemsArray[indexPath.row-2];
        NSString *name = commentModel.firstUserName;
        [self callKeyboardView:name];
    }
}

- (void)callKeyboardView:(NSString *)placeholder{
    [self.keyboardView setReplyPlaceholderString:placeholder];
    [self.keyboardView.textView becomeFirstResponder];
}

#pragma mark - SpaceCenterTableViewCellDelegate
- (void)spaceCenterCallHandel:(kSpaceBottomButtonType)type model:(BFPActivitySpaceModel *)model
{
    if (type == kSpaceBottomButtonTypeComment) {
        [self callKeyboardView:@""];
    }
}

#pragma mark - SpaceCenterFabulousCellDelegate
- (void)resetCellHeight:(CGFloat)cellHeight
{
    self.cellHeight = cellHeight;
    [self.main_tableView reloadData];
}

#pragma mark - SpaceCenterCommentCellDelegate
- (void)commentCellReply:(SDTimeLineCellCommentItemModel *)commentModel
{
    [self callKeyboardView:commentModel.firstUserName];
}

#pragma mark - Lazy
- (UITableView *)main_tableView{
    if (!_main_tableView) {
        
        _main_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - k_Height_NavBar - k_Height_TabBar) style:UITableViewStylePlain];
        _main_tableView.delegate = self;
        _main_tableView.dataSource= self;
        _main_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _main_tableView.tableFooterView = [UIView new];
        [self.view addSubview:_main_tableView];
    }
    return _main_tableView;
}

- (SpaceKeyboardView *)keyboardView{
    if (!_keyboardView) {
        
        _keyboardView = [[SpaceKeyboardView alloc] init];
        _keyboardView.delegate = self;

    }
    return _keyboardView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
