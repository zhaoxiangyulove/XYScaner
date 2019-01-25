//
//  XYSettingsTableViewController.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2019/1/19.
//  Copyright © 2019 xiangyu.zhao. All rights reserved.
//

#import "XYSettingsTableViewController.h"
#import "XYSettingsTableViewCell.h"

@interface XYSettingsTableViewController (){
    NSMutableDictionary<NSIndexPath *,XYSettingsTableViewCell *> *_cellDic;
    NSMutableDictionary *_dataDic;
    NSArray *_sectionList;
    NSString *_filePath;
}



@end

@implementation XYSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellDic = [[NSMutableDictionary alloc] init];
    [self updateDataDic];
    _sectionList = _dataDic[@"SectionList"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)updateDataDic{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *directory = [NSString stringWithFormat:@"%@/Settings/%@", [paths objectAtIndex:0],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:directory]) {
        // Directory does not exist so create it
        [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *myFilePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
        NSData *data = [NSData dataWithContentsOfFile:myFilePath];
        NSString *filePath = [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", [myFilePath lastPathComponent]]];
        BOOL success = [data writeToFile:filePath atomically:NO];
        if (success) {
            _filePath = filePath;
        }
    }else{
        _filePath = [directory stringByAppendingPathComponent:@"Settings.plist"];
    }
    _dataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:_filePath];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = _sectionList[section];
    NSArray *items = _dataDic[key];
    return items.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _sectionList[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    if (_cellDic[indexPath]) {
        return _cellDic[indexPath];
    }
    
    NSDictionary *dataDic = [self getDicWithIndex:indexPath];
    NSString *title = dataDic[@"title"];
    XYSettingsTableViewCell *cell = [XYSettingsTableViewCell cellWithName:title?:@"test"];
    cell.needWatchAdCount = [self getNeedWatchCountWithDic:dataDic];
    cell.imageName = [NSString stringWithFormat:@"settings_%@",dataDic[@"imageName"]];
    _cellDic[indexPath] = cell;
    return cell;
}

- (NSDictionary *)getDicWithIndex:(NSIndexPath *)indexPath{
    NSString *key = _sectionList[indexPath.section];
    NSArray *items = _dataDic[key];
    return items[indexPath.row];
}

- (NSInteger)getNeedWatchCountWithDic:(NSDictionary *)dataDic{
    if ([dataDic[@"needWatchAdCount"] integerValue] > 0) {
        NSString *title = dataDic[@"title"];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:title] == nil) {
            [[NSUserDefaults standardUserDefaults] setObject:dataDic[@"needWatchAdCount"] forKey:title];
            return [dataDic[@"needWatchAdCount"] integerValue];
        }
        return [[[NSUserDefaults standardUserDefaults] objectForKey:title] integerValue];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
