//
//  ProgramSelectViewCell.m
//  programDetail
//
//  Created by 孙元侃 on 14-8-9.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import "ProgramSelectViewCell.h"

@implementation ProgramSelectViewCell

+(ProgramSelectViewCell*)dequeueReusableCellWithTabelView:(UITableView*)tableView identifier:(NSString*)identifier indexPath:(NSIndexPath*)indexPath firstIcon:(BOOL)firstIcon secondIcon:(BOOL)secondIcon{
    
    ProgramSelectViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    cell.backgroundColor=[UIColor clearColor];
    
    if (indexPath.section!=3) {
        
        //被点击的底色back
        UIView* selectedBack=[[UIView alloc]initWithFrame:CGRectMake( 0, 0, 320, 34)];
        selectedBack.backgroundColor=RGBCOLOR(234, 234, 234);
        cell.selectedBackgroundView=selectedBack;

        //被点击后左边的蓝色图
        UIView* selectedIcon=[[UIView alloc]initWithFrame:CGRectMake( 0, 0, 2.5, 34+1)];//被选中后蓝的图片会稍微短1个坐标点，不知道原因
        selectedIcon.backgroundColor=RGBCOLOR(82, 125, 237);
        [selectedBack addSubview:selectedIcon];
        
        
        NSArray* ary0=@[@"土地规划/拍卖",@"项目立项"];
        NSArray* ary1=@[@"地勘阶段",@"设计阶段",@"出图阶段"];
        NSArray* ary2=@[@"地平",@"桩基基坑",@"主体施工",@"消防/景观绿化"];
        NSArray* arrayTotal=@[ary0,ary1,ary2];
        
        //小阶段名称label
        cell.stageLabel=[[UILabel alloc]initWithFrame:CGRectMake(47, 4, 150, 20)];
        cell.stageLabel.text=arrayTotal[indexPath.section][indexPath.row];
        cell.stageLabel.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:cell.stageLabel];
        
//        //右边三个小icon的最右边那个，必显示，但是图不同
//        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(270, 4, 20, 20)];
//        imageView.image=[UIImage imageNamed:thirdIcon?@"XiangMuXiangQing_ShaiXuan/right@2x.png":@"XiangMuXiangQing_ShaiXuan/right@2x.png"];//1则是勾的图，0则是没勾的图
//        [cell.contentView addSubview:imageView];
        
        //右边三个小icon的左边2个，选择性显示，图同
        CGFloat tempX=270;
        if (secondIcon) {
            UIImageView* tempImageView=[[UIImageView alloc]initWithFrame:CGRectMake(tempX, 4, 20, 20)];
            tempImageView.image=[UIImage imageNamed:@"XiangMuXiangQing_ShaiXuan/Gallery@2x.png"];
            [cell.contentView addSubview:tempImageView];
            tempX-=30;
        }
        if (firstIcon) {
            UIImageView* tempImageView=[[UIImageView alloc]initWithFrame:CGRectMake(tempX, 4, 20, 20)];
            tempImageView.image=[UIImage imageNamed:@"XiangMuXiangQing_ShaiXuan/use@2x.png"];
            [cell.contentView addSubview:tempImageView];
        }
        
    }else{
        //secton==3 装修阶段的cell
        
        //上拉取消tableView的箭头
        UIButton* cancel=[[UIButton alloc]initWithFrame:CGRectMake(145, 20, 24.5, 15.5)];
        [cancel setBackgroundImage:[UIImage imageNamed:@"XiangMuXiangQing_ShaiXuan/more_15@2x.png"] forState:UIControlStateNormal];
        [cancel addTarget:cell.delegate action:@selector(selectCancel) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cancel];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
