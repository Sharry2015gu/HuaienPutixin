//
//  AppShareViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/10/26.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "AppShareViewController.h"
#import "HeaderFile.h"
#import "RESideMenu.h"
#import "ZBarSDK.h"
#import "QRCodeGenerator.h"
@interface AppShareViewController ()<ZBarReaderDelegate>
@property(nonatomic,strong)NSString  *  downLoadUrlStr;
@property(nonatomic,strong)UIImageView * subImageView;
@property(nonatomic,strong)UILabel *inviteLabel;
@end

@implementation AppShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self loadURL];
    [self createNavBar];
}
-(void)createUI
{
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
    UILabel  * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0,NAVBARHEIGHT + 20,SCREEN_WIDTH,20)];
    label1.text = @"佛说一切法,为度一切心";
    label1.font = [UIFont systemFontOfSize:15];
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    UILabel  * label2 = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(label1.frame) + 10,SCREEN_WIDTH,20)];
    label2.text = @"坐禅  佛珠  读经  聆听  祈福";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label2];
    
    UILabel  * label3 = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(label2.frame) + 10, SCREEN_WIDTH,20)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"平安  幸福  财富  美满  快乐";
    label3.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label3];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30,CGRectGetMaxY(label3.frame)+10,SCREEN_WIDTH - 2 * 30,0.5 *SCREEN_HEIGHT)];
    imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];
    
    UIImageView *  subImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,15,imageView.frame.size.width - 2* 15,imageView.frame.size.height - 2* 15)];
    self.subImageView = subImageView;
    [imageView addSubview:subImageView];
    
    
    UILabel  *inviteLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame)+10,SCREEN_WIDTH,20)];
    self.inviteLabel = inviteLabel;
    inviteLabel.text = @"邀请好友一起修行祈福";
    inviteLabel.font = [UIFont systemFontOfSize:18];
    inviteLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:inviteLabel];
    
}
-(void)loadURL
{
    AppDelegate  *delegate  = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString * huaienId = [delegate.accountBasicDict objectForKey:@"huaienID"];
    NSString  * downLoadUrl = [NSString stringWithFormat:@"http://u.app.huaien.com/AjaxTuiGuang/GetTGUrl.do?Type=1&appID=15&Code=%@",huaienId];
    [delegate.sessionManager GET:downLoadUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber * result  = jsonData[@"Result"];
        NSInteger resultInteger = [result integerValue];
        WS(weakSelf);
        if (resultInteger == 1) {
            self.downLoadUrlStr = jsonData[@"Model"];
            [weakSelf createImage];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
-(void)createImage
{
    UIImage  *image = [QRCodeGenerator qrImageForString:self.downLoadUrlStr imageSize:self.subImageView.frame.size.width];
    self.subImageView.image = image;
    
    UIButton  * btn = [[UIButton alloc] initWithFrame:CGRectMake(30,CGRectGetMaxY(self.inviteLabel.frame)+15,SCREEN_WIDTH - 2 * 30,40)];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    if (fabs(SCREEN_HEIGHT-667) < 1)
    {
        
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
        }
        else
        {
            btn.frame = CGRectMake(30,CGRectGetMaxY(self.inviteLabel.frame)+5,SCREEN_WIDTH -2* 30,30);
        }
    }
    btn.backgroundColor =  majorityColor;
    [btn setTitle:@"复制链接" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
#pragma mark  --------复制链接
-(void)btnClick
{
    UIPasteboard *pasteboard  = [UIPasteboard generalPasteboard];
    pasteboard.string  = self.downLoadUrlStr;
    //提示 链接已经复制到剪贴板
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 200, 50);
    label.text = @" 链接已经复制到剪贴板";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    [self.view addSubview:label];
    [UIView animateWithDuration:1.5 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
 
}
-(void)createNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [navBar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *titleItem = [[UINavigationItem alloc]initWithTitle:@"菩提心分享"];
    NSDictionary *navTitleArr = [NSDictionary dictionaryWithObjectsAndKeys:
                                 
                                 [UIFont boldSystemFontOfSize:20],UITextAttributeFont,
                                 [UIColor whiteColor],UITextAttributeTextColor ,nil];
    [navBar setTitleTextAttributes:navTitleArr];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(20, 20,30, 25)];
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [titleItem setLeftBarButtonItem:leftItem];
    [navBar pushNavigationItem:titleItem animated:NO];
    [self.view addSubview:navBar];
    
}
-(void)backBtnClick
{
    AppDelegate * delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.sideMenuViewController setContentViewController:delegate.mainVc    animated:YES];
    [self.sideMenuViewController hideMenuViewController];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark ---- 实现ZBarReaderDelegate协议
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
}
@end
