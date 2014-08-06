//
//  LoginEvent.h
//  ZpzChinaApp
//
//  Created by Jack on 14-7-16.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoginEvent : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>
{
    
    
    NSString *person_id;

}

@property (nonatomic,strong)NSMutableArray *faceIDArray;


-(void)beginToRegisterFace;
- (UIImage *)fixOrientation:(UIImage *)aImage;
-(void)detectWithImage:(UIImage *)image With:(int)count;
-(void)detectWithImageArray:(NSMutableArray *)faceArray;
@end
