//
//  AddressBookFriendViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import "AddressBookFriendViewController.h"
#import "AddressBookFriendCell.h"
#import "GetAddressBook.h"
#import "AddressBookApi.h"
#import "ValidatePlatformContactModel.h"
#import "AddressBookFriendSearchController.h"
@interface AddressBookFriendViewController()<AddressBookFriendCellDelegate>
@property (nonatomic, strong)NSMutableArray* phones;
@property (nonatomic, strong)NSMutableArray* models;
@property(nonatomic,strong)AddressBookFriendSearchController* searchBarTableViewController;
@end

@implementation AddressBookFriendViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self initTableView];
    [self getAddressBookWithFinishBlock:^{
        [self postPhones];
    }];
}

-(void)getAddressBookWithFinishBlock:(void(^)())block{
    GetAddressBook *addressBook = [[GetAddressBook alloc] init];
    [addressBook registerAddressBook:^(bool granted, NSError *error) {
        [addressBook.phones enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary* baseInformationDics=obj[@"baseInformation"];
            
            NSArray* phoneDics=obj[@"cellPhones"];
            NSMutableArray* singleContactTels=[NSMutableArray array];
            [phoneDics enumerateObjectsUsingBlock:^(id tObj, NSUInteger tIdx, BOOL *tStop) {
                NSString* phoneNumber=tObj[@"phoneNumber"];
                if ([singleContactTels containsObject:phoneNumber]) {
                    return;
                }
                NSString* userPhoneName=[baseInformationDics[@"lastName"] stringByAppendingString:baseInformationDics[@"firstName"]];
                
                ValidatePlatformContactModel* model=[[ValidatePlatformContactModel alloc]init];

                model.a_loginTel=phoneNumber;
                model.a_userPhoneName=userPhoneName;
                /*
                 [phoneDic setValue:str forKey:@"phoneNumber"];
                 [phoneDic setValue:personPhoneLabel forKey:@"tagName"];
                 */
                [self.phones addObject:model];
                
                [singleContactTels addObject:phoneNumber];
            }];
        }];

        if (block) {
            block();
        }
    }];
}

-(void)postPhones{
    __block NSString* tels=@"";
    [self.phones enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ValidatePlatformContactModel* model=obj;
        tels=[tels stringByAppendingString:model.a_loginTel];
        if (idx==self.phones.count-1) {
            return ;
        }
        tels=[tels stringByAppendingString:@","];
    }];
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setObject:tels forKey:@"tels"];
    [AddressBookApi ValidatePlatformContactsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self.phones enumerateObjectsUsingBlock:^(ValidatePlatformContactModel* localModel, NSUInteger idx, BOOL *stop) {
                for (ValidatePlatformContactModel* serverModel in posts) {
                    if ([serverModel.a_loginTel isEqualToString:localModel.a_loginTel]) {
                        localModel.dict=serverModel.dict;
                        [self.models addObject:localModel];
                        NSLog(@"%@,%@",localModel.a_userPhoneName,localModel.dict);
                    }
                }
            }];
            
            [self.tableView reloadData];
        }
    } dic:dic noNetWork:nil];
}

-(void)initNavi{
    self.title=@"通讯录好友";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressBookFriendCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AddressBookFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" delegate:self];
    }
    ValidatePlatformContactModel* dataModel=self.models[indexPath.row];
    AddressBookFriendCellModel* model=[[AddressBookFriendCellModel alloc]init];
    model.mainLabelText=dataModel.a_userPhoneName;
    model.assistStyle=dataModel.a_isFriend;
    [cell setModel:model indexPath:indexPath];
    
    return cell;
}

-(void)chooseAssistBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath{
    ValidatePlatformContactModel* dataModel=self.models[indexPath.row];
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:dataModel.a_loginId forKey:@"userId"];
    [AddressBookApi PostSendFriendRequestWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            dataModel.a_isFriend=YES;
            [self.tableView reloadData];
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } dic:dic noNetWork:nil];
}

-(void)setUpSearchBarTableView{
    self.searchBarTableViewController=[[AddressBookFriendSearchController alloc]initWithTableViewBounds:CGRectMake(0, 0, kScreenWidth, kScreenHeight-CGRectGetMinY(self.searchBar.frame))];
    self.searchBarTableViewController.delegate=self;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [super searchBarSearchButtonClicked:searchBar];
    self.searchBarTableViewController.sqliteModels=self.models;
    [self.searchBarTableViewController loadListWithKeyWords:searchBar.text];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [super searchBarCancelButtonClicked:searchBar];
    [self.tableView reloadData];
}

-(NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
    }
    return _models;
}

-(NSMutableArray *)phones{
    if (!_phones) {
        _phones=[NSMutableArray array];
    }
    return _phones;
}
@end
