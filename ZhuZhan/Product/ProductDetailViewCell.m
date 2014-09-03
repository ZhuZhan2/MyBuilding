//
//  ProductDetailViewCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import "ProductDetailViewCell.h"
#import "EGOImageView.h"
@interface ProductDetailViewCell()
@property(nonatomic,strong)EGOImageView* userImageView;
@property(nonatomic,strong)UILabel* userNameLabel;
@property(nonatomic,strong)UILabel* userCommentContent;
@property(nonatomic,strong)UILabel* publishTime;
@end

@implementation ProductDetailViewCell



+(ProductDetailViewCell*)dequeueReusableCellWithTableView:(UITableView*)tableView identifier:(NSString*)identifier comment:(CommentModel*)commentModel{
    ProductDetailViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell=[[ProductDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.backgroundColor=[UIColor greenColor];
    int a=1;
    cell.textLabel.text=commentModel.name;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}



//=========================================================================
//=========================================================================
//=========================================================================

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
