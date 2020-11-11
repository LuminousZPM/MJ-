# MJ-Simple-package
按照作者的Demo示例用可以，但是个人总觉得不太好。就想着能够封装下(主要是懒，想省点事)。
    [self.tableView addHeaderWithRefreshingBlock:^{
        self.page = 1;
        //requestData...
    }];
    [self.tableView addFooterWithRefreshingBlock:^{
        self.page ++;
        //requestData...
    }];

    [self.tableView beginRefreshing];
