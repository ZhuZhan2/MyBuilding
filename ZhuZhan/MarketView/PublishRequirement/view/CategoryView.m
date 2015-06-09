//
//  CategoryView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/4.
//
//

#import "CategoryView.h"
#import "SingleCategoryView.h"
@interface CategoryView ()<SingleCategoryViewDelegate>
@property (nonatomic, strong)NSArray* categoryArr;
@property (nonatomic, strong)NSMutableArray* categoryViewArr;
@end

#define kSingleCategoryViewWidth 90
#define kSingleCategoryViewHeight 45

@implementation CategoryView
+ (CategoryView *)categoryViewWithCategoryArr:(NSArray *)categoryArr{
    CategoryView* categoryView = [[CategoryView alloc] init];
    categoryView.categoryArr= categoryArr;
    [categoryView setUp];
    return categoryView;
}

- (void)setUp{
    [self.categoryArr enumerateObjectsUsingBlock:^(NSString* category, NSUInteger idx, BOOL *stop) {
        SingleCategoryView* singleCategoryView = [SingleCategoryView singleCategoryViewWithCategory:category width:kSingleCategoryViewWidth height:kSingleCategoryViewHeight];
        singleCategoryView.delegate = self;
        singleCategoryView.tag = idx;
        CGRect frame = singleCategoryView.frame;
        frame.origin.x = 17+(kSingleCategoryViewWidth+8)*(idx%3);
        frame.origin.y = 10+(kSingleCategoryViewHeight+6)*(idx/3);
        singleCategoryView.frame = frame;
        
        [self addSubview:singleCategoryView];
        [self.categoryViewArr addObject:singleCategoryView];
    }];
    NSInteger lineCount = self.categoryArr.count/3+1;
    self.frame = CGRectMake(0, 0, kScreenWidth, 20+lineCount*45+(lineCount-1)*6);
}

- (void)singleCategoryViewClicked:(SingleCategoryView *)clickedCategoryView{
    NSLog(@"index = %d",(int)clickedCategoryView.tag);
    [self singleCategoryViewClickedWithIndex:clickedCategoryView.tag];
}

- (void)singleCategoryViewClickedWithIndex:(NSInteger)index{
    [self.categoryViewArr enumerateObjectsUsingBlock:^(SingleCategoryView* singleCategoryView, NSUInteger idx, BOOL *stop) {
        singleCategoryView.isSelected = idx == index;
        if (singleCategoryView.isSelected) {
            if ([self.delegate respondsToSelector:@selector(categoryViewClickedWithCategory:index:)]) {
                [self.delegate categoryViewClickedWithCategory:singleCategoryView.text index:idx];
            }
        }
    }];

}

- (NSMutableArray *)categoryViewArr{
    if (!_categoryViewArr) {
        _categoryViewArr = [NSMutableArray array];
    }
    return _categoryViewArr;
}

- (void)setBottomView:(UIView *)bottomView{
    _bottomView = bottomView;
    
    CGRect frame = bottomView.frame;
    frame.origin.y = CGRectGetHeight(self.frame);
    bottomView.frame = frame;
    
    [self addSubview:bottomView];
    
    frame = self.frame;
    frame.size.height += CGRectGetHeight(bottomView.frame);
    self.frame = frame;
}
@end
