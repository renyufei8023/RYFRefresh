//
//  ViewController.m
//  RYFRefresh
//
//  Created by dujinyue on 15/7/1.
//
//

#import "ViewController.h"
#import "RYFRefresh.h"
#import "TableViewModel.h"
#import "TableViewDataSource.h"
#import "TableViewDelegate.h"
#define HScreen [[UIScreen mainScreen] bounds].size.height
#define WScreen [[UIScreen mainScreen] bounds].size.width
#define iOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    RYFRefreshFooter *refreshFooter;
    RYFRefreshHeader *refreshHeader;
    TableViewModel *tableViewModel;
    UITableView *tableView;
    TableViewDataSource *tableViewDataSource;
    TableViewDelegate *tableViewDelegate;
    NSMutableArray *totalSource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    self.title=@"MVVMDemo With TableView";
    self.view.backgroundColor=[UIColor whiteColor];
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen-64) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableViewDataSource=[[TableViewDataSource alloc] init];
    tableViewDelegate=[[TableViewDelegate alloc] init];
    tableView.dataSource=tableViewDataSource;
    tableView.delegate=tableViewDelegate;
    tableViewModel=[[TableViewModel alloc] init];
    totalSource=0;
    
    
    refreshHeader=[[RYFRefreshHeader alloc] init];
    refreshHeader.scrollView=tableView;
    [refreshHeader header];
    __weak typeof(self) mySelf = self;
    refreshHeader.beginRefreshingBlock=^(){
        
        
        [mySelf headerRefreshAction];
        
    };
    
    //    是否在进入该界面的时候就开始进入刷新状态
    
    [refreshHeader beginRefreshing];
    
    refreshFooter=[[RYFRefreshFooter alloc] init];
    refreshFooter.scrollView=tableView;
    [refreshFooter footer];
    
    refreshFooter.beginRefreshingBlock=^(){
        [mySelf footerRefreshAction];
    };


}

- (void)headerRefreshAction
{
    
    [tableViewModel headerRefreshRequestWithCallback:^(NSArray *array){
        
        totalSource=array;
        tableViewDataSource.array=totalSource;
        tableViewDelegate.array=totalSource;
        
        [refreshHeader endRefreshing];
        [tableView reloadData];
    }];
    
    
    
}

- (void)footerRefreshAction
{
    
    [tableViewModel footerRefreshRequestWithCallback:^(NSArray *array){
        [totalSource addObjectsFromArray:array] ;
        tableViewDataSource.array=totalSource;
        tableViewDelegate.array=totalSource;
        
        [refreshFooter endRefreshing];
        [tableView reloadData];
        
    }];
    
    
    
    
}
@end
