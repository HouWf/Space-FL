//
//  SpaceCenterFabulousCell.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/28.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "SpaceCenterFabulousCell.h"
#import "SpaceCollectionViewCell.h"
#import "BFPActivitySpaceModel.h"

static NSString *cell_identifier = @"collection_cell_identifier";

@interface SpaceCenterFabulousCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIImageView *fabulousView;

@property (nonatomic, assign) NSInteger cellHeight;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation SpaceCenterFabulousCell

- (void)setLineShow:(BOOL)lineShow{
    self.lineView.hidden = !lineShow;
    self.fabulousView.hidden = !lineShow;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = rgba(242, 242, 242, 1);
        
        self.collectionView.sd_layout
        .leftSpaceToView(self.contentView, 53)
        .rightSpaceToView(self.contentView, 30)
        .topSpaceToView(self.contentView, 10)
        .bottomSpaceToView(self.contentView, 10);
        
        self.fabulousView.sd_layout
        .topSpaceToView(self.contentView, 13)
        .heightIs(16)
        .widthIs(16)
        .leftSpaceToView(self.contentView, 22);
        
        self.lineView.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(1)
        .bottomEqualToView(self.contentView);
    }
    return self;
}

- (void)setSpaceModel:(BFPActivitySpaceModel *)spaceModel{
    _spaceModel = spaceModel;
    if (self.spaceModel.likeItemsArray.count == 0) {
        [self setLineShow:NO];
    }
    else{
        [self setLineShow:YES];
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate, UIPageViewControllerDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.spaceModel.likeItemsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SpaceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_identifier forIndexPath:indexPath];
    cell.likeModel = self.spaceModel.likeItemsArray[indexPath.item];
 
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger newCellHeight = collectionView.contentSize.height;
    if  (newCellHeight != self.cellHeight) {
        self.cellHeight = newCellHeight;
        if ([self.delegate respondsToSelector:@selector(resetCellHeight:)]) {
            [self.delegate resetCellHeight:self.cellHeight+ 20];
        }
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(30, 30);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"SpaceCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cell_identifier];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.scrollEnabled = NO;
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}

- (UIImageView *)fabulousView{
    if(!_fabulousView){
        _fabulousView = [[UIImageView alloc] init];
        _fabulousView.image = GetImage(@"space_falubous_icon");
        [self.contentView addSubview:_fabulousView];
    }
    return _fabulousView;
}

- (UIView *)lineView{
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = rgba(230, 230, 230, 1);
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

@end
