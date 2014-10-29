//
//  CommentView.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import "CommentView.h"
#import "EGOImageView.h"
#import "ContactCommentModel.h"
#import "ContactCommentTableViewCell.h"
#import "NBLabel.h"
@implementation CommentView
@synthesize indexpath = _indexpath;
@synthesize showArr;

+(CommentView *)setFram:(ActivesModel *)model{
    CommentView *commentView = [[CommentView alloc] init];
    
    UIView* forCornerView=[[UIView alloc]initWithFrame:CGRectZero];
    [commentView addSubview:forCornerView];
    forCornerView.layer.cornerRadius=2;
    forCornerView.layer.masksToBounds=YES;
    
    CGFloat height=0;
    
    EGOImageView *imageView;
    BOOL imageUrlExist=![model.a_imageUrl isEqualToString:@""];
    //动态图像
    if(imageUrlExist){
        imageView = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"bg001"]];
        imageView.frame = CGRectMake(0, 0, 310,[model.a_imageHeight floatValue]/[model.a_imageWidth floatValue]*310);
        imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_imageUrl]];
        [forCornerView addSubview:imageView];
        height+=imageView.frame.size.height;
    }
    
    UIView* contentTotalView;
    //动态描述
    if (![model.a_content isEqualToString:@""]) {
        UIFont * tfont = [UIFont systemFontOfSize:15];
        //用户名颜色
        NSString * text = [NSString stringWithFormat:@"%@:%@",model.a_userName,model.a_content];
        NSMutableAttributedString* attributedText=[[NSMutableAttributedString alloc]initWithString:text];
        NSRange range=NSMakeRange(0, model.a_userName.length+1);
        [attributedText addAttributes:@{NSForegroundColorAttributeName:BlueColor} range:range];
        [attributedText addAttributes:@{NSFontAttributeName:tfont} range:NSMakeRange(0, text.length)];
        
        //动态文字内容
        UIView* contentTextView;
        if (imageUrlExist) {
            UILabel* contentLabel = [[UILabel alloc] init];
            contentLabel.numberOfLines =0;
            contentLabel.font = tfont;
            contentLabel.textColor = [UIColor blackColor];
            contentLabel.attributedText=attributedText;
            
            CGSize size =CGSizeMake(290,CGFLOAT_MAX);
            CGSize actualsize =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tfont} context:nil].size;
            actualsize.height=actualsize.height>=60?60:actualsize.height;
            contentLabel.frame =CGRectMake(10,10, actualsize.width, actualsize.height);
            
            contentTextView=contentLabel;
        }else{
            NBLabel* contentLabel=[NBLabel labelWithLabelWidth:250 imageSize:CGSizeMake(40, 40) font:tfont lineHeight:17];
            contentLabel.attributedText=attributedText;
            contentLabel.frame=CGRectMake(55, 10, contentLabel.frame.size.width, contentLabel.frame.size.height);
            
            contentTextView=contentLabel;
        }
        contentTotalView=[[UIView alloc]initWithFrame:CGRectMake(0, height, 310, contentTextView.frame.size.height+20)];
        contentTotalView.backgroundColor=[UIColor whiteColor];
        [contentTotalView addSubview:contentTextView];
        [forCornerView addSubview:contentTotalView];
        height+=contentTotalView.frame.size.height;
    }
    
    //评论图标
    CGFloat tempHeight=imageView?imageView.frame.origin.y+imageView.frame.size.height-3:height-6;
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(267, tempHeight-40, 37, 37);
    [commentBtn setImage:[GetImagePath getImagePath:@"人脉_66a"] forState:UIControlStateNormal];
    [commentBtn addTarget:commentView action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    [forCornerView addSubview:commentBtn];

    //用户头像
    tempHeight=imageView?imageView.frame.origin.y+5:contentTotalView.frame.origin.y+10;
    EGOImageView* userImageView = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"公司认证员工_05a"]];
    userImageView.layer.masksToBounds = YES;
    userImageView.layer.cornerRadius = 3;
    userImageView.frame=CGRectMake(5,tempHeight,37,37);
    userImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_avatarUrl]];
    [forCornerView addSubview:userImageView];
    
    UIButton *uesrImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uesrImageBtn.frame = CGRectMake(5,tempHeight,37,37);
    [uesrImageBtn addTarget:commentView action:@selector(gotoShowViewClick) forControlEvents:UIControlEventTouchUpInside];
    [forCornerView addSubview:uesrImageBtn];
    
    forCornerView.frame=CGRectMake(5, 5, 310, height-5);
    
    //评论tableView
    if(model.a_commentsArr.count !=0){
        int count = 0;
        if(model.a_commentsArr.count>=3){
            count = 4;
        }else{
            count = model.a_commentsArr.count;
        }
        //评论内容上箭头图片
        UIImageView* upImageView=[[UIImageView alloc]initWithFrame:CGRectMake(320-251, height, 251, 11)];
        upImageView.image=[GetImagePath getImagePath:@"+人脉2_03a"];
        [commentView addSubview:upImageView];
        
        
        UITableView *_tableView = [[UITableView alloc] initWithFrame:CGRectMake(320-251+5, height+11, 242, 50*count)];
        _tableView.delegate = commentView;
        _tableView.dataSource = commentView;
        _tableView.separatorStyle = NO;
        _tableView.scrollEnabled = NO;
        [commentView addSubview:_tableView];
        
        UIImageView* downImageView=[[UIImageView alloc]initWithFrame:CGRectMake(320-251, height+50*count+11, 251, 9)];
        downImageView.image=[GetImagePath getImagePath:@"+人脉2_05a"];
        [commentView addSubview:downImageView];
        
        height += 50*count+11+9;//11为上箭头线,9为下方圆角及空的地方
    }
    
    //上分割线
    UIImageView *topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(67, 0, 2, height)];
    [topLineImage setBackgroundColor:[UIColor blackColor]];
        [commentView insertSubview:topLineImage atIndex:0];
    topLineImage.alpha =0.2;
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, height-1, 320, 1)];
    [lineImage setBackgroundColor:[UIColor blackColor]];
    [commentView addSubview:lineImage];
    lineImage.alpha = 0.1;

    //设置总的frame
    commentView.frame = CGRectMake(0, 0, 320, height);
    [commentView setBackgroundColor:RGBCOLOR(242, 242, 242)];
    return commentView;
}

-(void)commentClick{
    if([self.delegate respondsToSelector:@selector(addCommentView:)]){
        [self.delegate addCommentView:_indexpath];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(showArr.count>=3){
        return 4;
    }else{
        return showArr.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCommentModel *model = showArr[indexPath.row];
    if(showArr.count>=3){
        if(indexPath.row == 2){
            NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(!cell){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.selectionStyle = NO;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 230, 30)];
            label.text = @"查看全部评论";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            [cell.contentView addSubview:label];
            
            UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 242, 1)];
            [lineImage setBackgroundColor:[UIColor blackColor]];
            [cell.contentView addSubview:lineImage];
            lineImage.alpha = 0.1;
            return cell;
        }else{
            NSString *CellIdentifier = [NSString stringWithFormat:@"ContactCommentTableViewCell"];
            ContactCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(!cell){
                cell = [[ContactCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.selectionStyle = NO;
            cell.model = model;
            return cell;
        }
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"ContactCommentTableViewCell"];
        ContactCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[ContactCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = NO;
        cell.model = model;
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(gotoDetailView:)]){
        [self.delegate gotoDetailView:_indexpath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)gotoShowViewClick{
    if([self.headImageDelegate respondsToSelector:@selector(HeadImageAction:)]){
        [self.headImageDelegate HeadImageAction:_indexpath];
    }
}
@end
