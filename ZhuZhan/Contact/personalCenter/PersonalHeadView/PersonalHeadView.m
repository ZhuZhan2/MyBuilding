//
//  PersonalHeadView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/17.
//
//

#import "PersonalHeadView.h"
#import "PersonalBlockView.h"
#import "RKShadowView.h"
#define kImgWH 60
#define kInitCount 6
@interface PersonalHeadView()<PersonalBlockViewDelegate>
@property(nonatomic,strong)NSMutableArray *titlesArr;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UIView *cutLine;
@property(nonatomic,strong)UIImageView *bottomImageView;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@end
@implementation PersonalHeadView
-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        //[self addSubview:self.bgImageView];
        [self addSubview:self.cutLine];
        [self addSubview:self.bottomImageView];
//        [self addSubview:self.headImageView];
//        [self addSubview:self.nameLabel];
        [self adjustImagePosWithColumns:3];
    }
    return self;
}

-(UIImageView *)bgImageView{
    if(!_bgImageView){
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 85)];
        _bgImageView.backgroundColor = [UIColor yellowColor];
    }
    return _bgImageView;
}

-(UIView *)cutLine{
    if(!_cutLine){
        _cutLine = [RKShadowView seperatorLine];
        _cutLine.center = CGPointMake(160, 149.5);
    }
    return _cutLine;
}

-(UIImageView *)bottomImageView{
    if(!_bottomImageView){
        _bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, 320, 10)];
        _bottomImageView.backgroundColor = RGBCOLOR(239, 237, 237);
    }
    return _bottomImageView;
}

-(UIImageView *)headImageView{
    if(!_headImageView){
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, 63, 63)];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 31.5;
    }
    return _headImageView;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 32.5, 250, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

-(NSMutableArray *)titlesArr{
    if(!_titlesArr){
        _titlesArr = [[NSMutableArray alloc] initWithObjects:@"我的询价",@"我的报价",@"我的合同",@"我的需求",@"我的关注",@"我的项目", nil];
    }
    return _titlesArr;
}

#pragma mark 调整图片的位置
- (void)adjustImagePosWithColumns:(int)columns
{
    // 1.定义列数、间距
    // 每行3列
    //#warning 不一样
    //    int columns = 3;
    // 每个表情之间的间距 = (控制器view的宽度 - 列数 * 表情的宽度) / (列数 + 1)
    CGFloat margin = (self.frame.size.width - columns * kImgWH) / (columns + 1);
    
    // 2.定义第一个表情的位置
    // 第一个表情的Y值
    CGFloat oneY = 12;
    // 第一个表情的x值
    CGFloat oneX = margin;
    
    // 3.创建所有的表情
    for (int i = 0; i<kInitCount; i++) {
        // i这个位置对应的列数
        int col = i % columns;
        // i这个位置对应的行数
        int row = i / columns;
        
        // 列数（col）决定了x
        CGFloat x = oneX + col * (kImgWH + margin);
        // 行数（row）决定了y
        CGFloat y = oneY + row * (kImgWH + margin-23);
        
        int no = i % 9; // no == [0, 8]
        NSString *imgName = [NSString stringWithFormat:@"personal_center_01%d.png", no];
        [self addImg:imgName title:self.titlesArr[no] x:x y:y index:no];
    }
}

#pragma mark 添加表情 icon:表情图片名
- (void)addImg:(NSString *)icon title:(NSString *)title x:(CGFloat)x y:(CGFloat)y index:(int)index
{
    PersonalBlockView *one = [[PersonalBlockView alloc] init];
    one.image = [UIImage imageNamed:icon];
    one.title = title;
    one.frame = CGRectMake(x, y, kImgWH, kImgWH);
    one.index = index;
    one.delegate = self;
    [self addSubview:one];
}

-(void)setAvatarUrl:(NSString *)avatarUrl{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[GetImagePath getImagePath:@"默认图_需求详情_人头像126"]];
}

-(void)setUserName:(NSString *)userName{
    self.nameLabel.text = userName;
}

-(void)clickButton:(int)index{
    if([self.delegate respondsToSelector:@selector(selectBlock:)]){
        [self.delegate selectBlock:index];
    }
}
@end
