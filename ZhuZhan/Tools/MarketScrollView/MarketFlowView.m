//
//  MarketFlowView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import "MarketFlowView.h"

@interface MarketFlowView ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic)CGSize pageSize;
@property(nonatomic)NSInteger pageCount;
@property(nonatomic)NSInteger currentPageIndex;
@property(nonatomic)NSRange visibleRange;
@property(nonatomic,strong)NSMutableArray *inUseCells;
@property(nonatomic,strong)NSMutableArray *reusableCells;
@property(nonatomic)BOOL needsReload;
@end

@implementation MarketFlowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void)reloadData
{
    self.needsReload = YES;
    [self setNeedsLayout];
}

- (UIView *)dequeueReusableCell
{
    //return nil;
    
    UIView *cell = [self.reusableCells lastObject];
    if (cell)
    {
        [self.reusableCells removeLastObject];
    }
    
    return cell;
}

- (void)initialize{
    self.clipsToBounds = YES;
    self.pageCount = 0;
    self.currentPageIndex = 0;
    self.padding = 1;
    self.inUseCells = [[NSMutableArray alloc] init];
    self.reusableCells = [[NSMutableArray alloc] init];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    UIView *superViewOfScrollView = [[UIView alloc] initWithFrame:self.bounds];
    [superViewOfScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [superViewOfScrollView setBackgroundColor:[UIColor clearColor]];
    [superViewOfScrollView addSubview:self.scrollView];
    [self addSubview:superViewOfScrollView];
    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [_scrollView addGestureRecognizer:tap];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.needsReload) {
        //如果需要重新加载数据，则需要清空相关数据全部重新加载
        [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        if ([self.dataSource respondsToSelector:@selector(sizeForPageInFlowView:)]) {
            self.pageSize = [self.dataSource sizeForPageInFlowView:self];
        }
        
        //重置pageCount
        if ([self.dataSource respondsToSelector:@selector(numberOfPagesInFlowView:)]) {
            self.pageCount = [self.dataSource numberOfPagesInFlowView:self];
        }
        
        if (self.pageCount == 0 && self.defaultImageView) {
            self.defaultImageView.frame = CGRectMake(0, 0, self.pageSize.width, self.pageSize.height);
            self.defaultImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.scrollView addSubview:self.defaultImageView];
        }
        
        self.visibleRange = NSMakeRange(0, 0);
        [self.reusableCells removeAllObjects];
        [self.inUseCells removeAllObjects];
        
        // 重置_scrollView的contentSize
        NSInteger  offset = 1;
        self.scrollView.scrollEnabled = YES;
        if (self.pageCount <= 1) {
            offset = 0;
            self.scrollView.scrollEnabled = NO;
        }
        
        self.scrollView.frame = CGRectMake(0, 0, self.pageSize.width, self.pageSize.height);
        self.scrollView.contentSize = CGSizeMake(self.pageSize.width *3,self.pageSize.height);
        CGPoint theCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        self.scrollView.center = theCenter;
        self.scrollView.contentOffset = CGPointMake(self.pageSize.width*offset, 0);
    }
    [self loadRequiredItems];
    [self refreshVisibleCellAppearance];
}

- (void)loadRequiredItems
{
    if (self.pageCount <= 0){
        return;
    }
    
    if (self.pageCount == 1) {
        UIView  *cell = [self.dataSource flowView:self cellForPageAtIndex:0];
        cell.tag = 0;
        cell.frame = CGRectMake(0, 0, self.pageSize.width, self.pageSize.height);
        if (cell){
            [self.inUseCells addObject:cell];
            [self.scrollView addSubview:cell];
        }
        return;
    }
    
    [self initVisibleCellAppearance];
    [self initReuseCell];
}

- (void)initVisibleCellAppearance
{
    self.visibleRange = NSMakeRange(0, 3);
    NSInteger  index = 0;
    index = (self.currentPageIndex == 0)?self.pageCount-1:self.currentPageIndex-1;
    UIView  *cell = [self.dataSource flowView:self cellForPageAtIndex:index];
    cell.tag = index;
    cell.frame = CGRectMake(0, 0, self.pageSize.width, self.pageSize.height);
    if (cell){
        [self.inUseCells addObject:cell];
        [self.scrollView addSubview:cell];
    }
    
    index = self.currentPageIndex;
    UIView  *cell1 = [self.dataSource flowView:self cellForPageAtIndex:index];
    cell1.tag = index;
    cell1.frame = CGRectMake(self.pageSize.width, 0, self.pageSize.width, self.pageSize.height);
    if (cell1){
        [self.inUseCells addObject:cell1];
        [self.scrollView addSubview:cell1];
    }
    
    index = (self.currentPageIndex == self.pageCount-1)?0:self.currentPageIndex+1;
    UIView  *cell2 = [_dataSource flowView:self cellForPageAtIndex:index];
    cell2.tag = index;
    cell2.frame = CGRectMake(self.pageSize.width*2, 0, self.pageSize.width, self.pageSize.height);
    if (cell2){
        [self.inUseCells addObject:cell2];
        [self.scrollView addSubview:cell2];
    }
    
}

- (void)initReuseCell
{
    if (self.pageCount == 2) {
        NSInteger  index = (self.currentPageIndex==0)?0:1;
        UIView  *cell1 = [self.dataSource flowView:self cellForPageAtIndex:index];
        cell1.tag = index;
        cell1.frame = CGRectMake(0, 0, _pageSize.width, _pageSize.height);
        if (cell1){
            [self.reusableCells addObject:cell1];
        }
        
        index = (self.currentPageIndex==0)?0:1;
        UIView  *cell2 =  [self.dataSource flowView:self cellForPageAtIndex:index];
        cell2.tag = index;
        cell2.frame = CGRectMake(self.pageSize.width*2, 0, self.pageSize.width, self.pageSize.height);
        if (cell2){
            [self.reusableCells addObject:cell2];
        }
    }else if (self.pageCount >2){
        NSInteger  i = 0;
        if (self.currentPageIndex == 0) {
            i  = self.pageCount-2;
        }else if ((self.currentPageIndex-1 == 0)) {
            i  = self.pageCount-1;
        }else{
            i = self.currentPageIndex-2;
        }
        
        UIView  *cell1 = [self.dataSource flowView:self cellForPageAtIndex:i];
        cell1.tag = i;
        cell1.frame = CGRectMake(0, 0, self.pageSize.width, self.pageSize.height);
        if (cell1){
            [self.reusableCells insertObject:cell1 atIndex:0];
        }
        
        NSInteger  index = 0;
        if (self.currentPageIndex == self.pageCount-1) {
            index = 1;
        }else if ((self.currentPageIndex+1 == self.pageCount-1)) {
            index = 0;
        }else{
            index = self.currentPageIndex +2;
        }
        
        UIView  *cell2 = [self.dataSource flowView:self cellForPageAtIndex:index];
        cell2.tag = index;
        cell2.frame = CGRectMake(self.pageSize.width*2, 0, self.pageSize.width, self.pageSize.height);
        if (cell2){
            [self.reusableCells addObject:cell2];
        }
    }
}

- (void)refreshVisibleCellAppearance
{
    if (self.padding == 1) {
        return;//无需更新
    }
    
    CGFloat offset = self.scrollView.contentOffset.x;
    
    for (int i = (int)self.visibleRange.location; i < self.visibleRange.location + self.visibleRange.length; i++) {
        UIView *cell = [self.inUseCells objectAtIndex:i];
//        if(i == 0){
//            cell.frame = CGRectMake(self.pageSize.width*i-self.padding, 0, self.pageSize.width, self.pageSize.height);
//        }else if (i == 2){
//            cell.frame = CGRectMake(self.pageSize.width*i+self.padding, 0, self.pageSize.width, self.pageSize.height);
//        }
        CGFloat origin = cell.frame.origin.x;
        CGFloat delta = fabs(origin - offset);
        CGRect originCellFrame = CGRectMake(self.pageSize.width * i, 0, self.pageSize.width, self.pageSize.height);//如果没有缩小效果的情况下的本该的Frame
        
        if (delta < self.pageSize.width) {
            CGFloat inset = (self.pageSize.width * (1 - self.padding)) * (delta / self.pageSize.width)/2.0;
            cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(0, inset, 0, inset));
        } else {
            CGFloat inset = self.pageSize.width * (1 - self.padding) / 2.0 ;
            cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(0, inset, 0, inset));
        }
    }
}

- (void)reloadDataForScrollView:(PageDirectionE)direction
{
    if (direction == PageDirectionPrevious) {
        UIView  *oldItem = [self.inUseCells objectAtIndex:0];
        [self.inUseCells removeObjectIdenticalTo:oldItem];
        
        for (NSInteger  i=0; i<[self.inUseCells count]; i++) {
            UIView  *v = [self.inUseCells objectAtIndex:i];
            v.frame = CGRectMake(self.pageSize.width*i, 0, self.pageSize.width, self.pageSize.height);
        }
        
        UIView *newItem = [self.reusableCells lastObject];
        [self.reusableCells removeObjectIdenticalTo:newItem];
        [self.scrollView addSubview:newItem];
        [self.inUseCells addObject:newItem];
        
        oldItem.frame = CGRectMake(0, 0, self.pageSize.width, self.pageSize.height);
        [self.reusableCells insertObject:oldItem atIndex:0];
        [oldItem removeFromSuperview];
        
        UIView  *reuseCell = [self.reusableCells lastObject];
        
        NSInteger  index = 0;
        if (self.currentPageIndex == self.pageCount-1) {
            index = 1;
        }else if ((self.currentPageIndex+1 == self.pageCount-1)) {
            index = 0;
        }else{
            index = self.currentPageIndex +2;
        }
        reuseCell.tag = index;
        reuseCell.frame = CGRectMake(self.pageSize.width*2, 0, self.pageSize.width, self.pageSize.height);
        [self.delegate didReloadData:reuseCell cellForPageAtIndex:index];
        
    }else if(direction == PageDirectionDown){
        
        UIView  *oldItem = [self.inUseCells lastObject];
        [self.inUseCells removeObjectIdenticalTo:oldItem];
        
        for (NSInteger  i=0; i<[self.inUseCells count]; i++) {
            UIView  *v = [self.inUseCells objectAtIndex:i];
            v.frame = CGRectMake(self.pageSize.width*(i+1), 0, self.pageSize.width, self.pageSize.height);
        }
        
        UIView *newItem = [self.reusableCells objectAtIndex:0];
        [self.reusableCells removeObjectIdenticalTo:newItem];
        [self.scrollView addSubview:newItem];
        [self.inUseCells insertObject:newItem atIndex:0];
        
        oldItem.frame = CGRectMake(self.pageSize.width*2, 0, self.pageSize.width, self.pageSize.height);
        [self.reusableCells addObject:oldItem];
        [oldItem removeFromSuperview];
        
        UIView  *reuseCell = [self.reusableCells objectAtIndex:0];
        NSInteger  i = 0;
        if (self.currentPageIndex == 0) {
            i  = self.pageCount-2;
        }else if ((self.currentPageIndex-1 == 0)) {
            i  = self.pageCount-1;
        }else{
            i = self.currentPageIndex-2;
        }
        reuseCell.tag = i;
        reuseCell.frame = CGRectMake(0, 0, self.pageSize.width, self.pageSize.height);
        [self.delegate didReloadData:reuseCell cellForPageAtIndex:i];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.pageCount <= 1)
        return;
    
    [self refreshVisibleCellAppearance];
}

- (NSInteger)validPageValue:(NSInteger)value {
    
    if(value < 0) value = self.pageCount-1;                   // value＝1为第一张，value = 0为前面一张
    if(value >= self.pageCount) value = 0;
    
    return value;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    int x = aScrollView.contentOffset.x;
    
    // 往下翻一张
    if(x >= (2*self.scrollView.bounds.size.width)) {
        self.currentPageIndex = [self validPageValue:self.currentPageIndex+1];
        [self reloadDataForScrollView:PageDirectionPrevious];
    }
    if(x <= 0) {
        self.currentPageIndex = [self validPageValue:self.currentPageIndex-1];
        [self reloadDataForScrollView:PageDirectionDown];
    }
    
    if ([self.delegate respondsToSelector:@selector(didScrollToPage:inFlowView:)]) {
        [self.delegate didScrollToPage:self.currentPageIndex inFlowView:self];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0) animated:NO];
    
}


- (void)handleTapGesture:(UITapGestureRecognizer *)gestureRecognizer{
    if ([self.delegate respondsToSelector:@selector(didSelectItemAtIndex:inFlowView:)]) {
        [self.delegate didSelectItemAtIndex:self.currentPageIndex inFlowView:self];
    }
}

@end
