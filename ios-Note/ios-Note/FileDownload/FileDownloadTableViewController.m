//
//  FileDownloadTableViewController.m
//  Note
//
//  Created by SL on 28/03/2017.
//  Copyright © 2017 Sam. All rights reserved.
//

#import "FileDownloadTableViewController.h"

static NSString * const cellIdentifier = @"cell";

@interface FileDownloadTableViewController ()
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation FileDownloadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Accessors
- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSArray arrayWithObjects:@"使用AFNetworking断点下载（支持离线）", @"使用NSURLSession断点下载（支持离线）", nil];
    }
    return _dataArray;
}

#pragma mark- Methods
- (IBAction)redoSender:(id)sender {
    //清理下载文件
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.mp4"];
    NSFileManager *FM = [NSFileManager defaultManager];
    BOOL b_exist = [FM fileExistsAtPath:path];
    if (b_exist) {
        NSError *error = nil;
        BOOL b_remove = [FM removeItemAtPath:path error:&error];
        if (!b_remove) {
            NSLog(@"%@",error.userInfo);
        } else {
            NSLog(@"Remove File at: %@",path);
        }
    }
    
    //清理下载图片
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *imagePath = [documentsPath stringByAppendingPathComponent:@"image.jpg"];
    b_exist = [FM fileExistsAtPath:imagePath];
    if (b_exist) {
        NSError *error = nil;
        BOOL b_remove = [FM removeItemAtPath:imagePath error:&error];
        if (!b_remove) {
            NSLog(@"%@",error.userInfo);
        } else {
            NSLog(@"Remove File at: %@",imagePath);
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.dataArray.count;
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            [self performSegueWithIdentifier:@"GotoAFNetworkingOfflineResumeDownloadFileViewController" sender:@"AFNetworking断点下载（支持离线）"];
            break;
        case 1:
            [self performSegueWithIdentifier:@"GotoNSURLSessionOfflineResumeDownloadFileViewController" sender:@"NSURLSession断点下载（支持离线）"];
            break;
        case 2:
            [self performSegueWithIdentifier:@"GotoNSURLSessionBlockDownloadFileViewController" sender:@"使用NSURLSession的block方法下载文件"];
            break;
        case 3:
            [self performSegueWithIdentifier:@"GotoNSURLSessionDelegateDownloadFileViewController" sender:@"使用NSURLSession的delegate方法下载文件"];
            break;
            
        default:
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/**/
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
#if 1
    /*
     此处属于固定业务流程，不需要判断
    if ([segue.identifier  isEqual: @"GotoAFNetworkingOfflineResumeDownloadFileViewController"]) {
        // 需要执行的代码
    }
     */
    
    id viewcontroller = [segue destinationViewController];
    [viewcontroller setValue:sender forKey:@"title"];
    
#else
    if ([segue.destinationViewController isKindOfClass:[IndexTableViewController class]]) {
        //  执行代码
        //方法一,使用KVC给B 也就是目标场景传值
        UIViewController *destinationController=[segue destinationViewController];
        [destinationController setValue:@"119" forKey:@"number"];
        
        //方法2,使用属性传值,需导入相关的类.h
        BViewController *bController=[segue destinationViewController];
        bController.number=@188;
        
    }
#endif
}


@end
