//
//  DemanDetailViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import "ChatBaseViewController.h"
#import "RKDemandDetailController.h"
#import "RKDemandChatController.h"
@interface DemanDetailViewController : ChatBaseViewController{
@protected
    RKDemandDetailController* _detailController;
    RKDemandChatController* _chatController;
}
@end
