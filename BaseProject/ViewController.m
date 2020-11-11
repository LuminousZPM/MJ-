//
//  ViewController.m
//  BaseProject
//
//  Created by Luminous on 2020/10/26.
//

#import "ViewController.h"
#import "UIScrollView+MJ.h"

#define WeakSelf __weak typeof(self) weakSelf = self;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) int page;
@property (assign, nonatomic) NSInteger dataCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    // Do any additional setup after loading the view.
}

- (void)configTableView
{
    WeakSelf;
    [self.tableView addHeaderWithRefreshingBlock:^{
        self.page = 1;
        [weakSelf requestData:^(NSInteger count) {
            weakSelf.dataCount = count;
            [weakSelf.tableView reloadData];
            [weakSelf hzxEndRefreshing];


        } failCallBack:^{
            [weakSelf.tableView headerEndRefreshing];
        }];
    }];
    [self.tableView addFooterWithRefreshingBlock:^{
        self.page ++;
        [weakSelf requestData:^(NSInteger count) {
            if (count>0) {
                weakSelf.dataCount += count;
                [weakSelf hzxEndRefreshing];
            }else{
                [weakSelf.tableView noticeNoMoreData];
            }
            [weakSelf.tableView reloadData];

        } failCallBack:^{
            [weakSelf.tableView footerEndRefreshing];
        }];
    }];

    [self.tableView beginRefreshing];
}

- (void)requestData:(void(^)(NSInteger count))successCallBack failCallBack:(void(^)(void))failCallBack
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        if (self.page > 3) {
            successCallBack(0);
        }else{
            successCallBack(10);
        }
    });
}
-(void)hzxEndRefreshing{
    if (self.page==1) {
        [self.tableView headerEndRefreshing];
    }else{

        [self.tableView footerEndRefreshing];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *indetifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indetifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat: @"这是%ld",(long)indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataCount;
}


@end
