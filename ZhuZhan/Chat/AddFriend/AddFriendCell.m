//
//  AddFriendCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import "AddFriendCell.h"
@interface AddFriendCell()
@property(nonatomic,strong)UILabel* userNameLabel;
@property(nonatomic,strong)UILabel* userBussniessLabel;
@property(nonatomic,strong)UIView* separatorLine;
@property(nonatomic)BOOL needRightBtn;
@end

@implementation AddFriendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.needRightBtn=needRightBtn;
        
        self.headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headBtn.layer.cornerRadius=3;
        self.headBtn.layer.masksToBounds=YES;
        self.headBtn.frame=CGRectMake(15, 12.5, 35, 35);
        [self.headBtn addTarget:self action:@selector(headAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.headBtn];
        
        self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(65, 10.5, 200, 20)];
        self.userNameLabel.font=[UIFont boldSystemFontOfSize:15];
        self.userNameLabel.textColor=RGBCOLOR(89, 89, 89);
        [self addSubview:self.userNameLabel];
        
        self.userBussniessLabel=[[UILabel alloc]initWithFrame:CGRectMake(65, 33, 200, 14)];
        self.userBussniessLabel.font=[UIFont systemFontOfSize:13];
        self.userBussniessLabel.textColor=RGBCOLOR(149, 149, 149);
        [self addSubview:self.userBussniessLabel];
        
        if (self.needRightBtn) {
            self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(250, 19, 60, 26)];
            [self addSubview:self.rightBtn];
        }
        
        self.separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 59, 320, 1)];
        self.separatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
        [self addSubview:self.separatorLine];
    }
    return self;
}

-(void)setUserName:(NSString*)userName time:(NSString*)time userImageUrl:(NSString*)userImageUrl isFinished:(BOOL)isFinished indexPathRow:(NSInteger)indexPathRow status:(NSString *)status{
    [self.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:userImageUrl] forState:UIControlStateNormal placeholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    self.userNameLabel.text=userName;
    self.userBussniessLabel.text=time;
    [self.rightBtn setBackgroundImage:[GetImagePath getImagePath:isFinished?@"added":@"add_green_button"] forState:UIControlStateNormal];
    self.rightBtn.tag=indexPathRow;
    self.headBtn.tag=indexPathRow;
}

-(void)headAction:(UIButton *)button{
    NSLog(@"headAction");
    if([self.delegate respondsToSelector:@selector(headClick:)]){
        [self.delegate headClick:(int)button.tag];
    }
}
@end