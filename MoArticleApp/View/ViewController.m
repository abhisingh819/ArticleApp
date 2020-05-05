//
//  ViewController.m
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/2/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import "ViewController.h"
#import "ArticleTableViewCell.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *articleTableView;
@property (weak, nonatomic) IBOutlet UIButton *sortBtn;

@end

@implementation ViewController
@synthesize viewPresenter;

NSMutableArray<Article *> *articleDatasource;
NSCache* imageFromCache;
bool sortedAscending = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    articleDatasource = [NSMutableArray new];
    self.viewPresenter = [[ArticlePresenter alloc] init: self];
    imageFromCache = [[NSCache alloc] init];
    [self.viewPresenter getAPIData];
    
    // Do any additional setup after loading the view.
}


// Article View Methods

- (void)update:(NSArray<NSManagedObject*>*)article {
    NSLog(@"entered update");
    dispatch_async(dispatch_get_main_queue(), ^{
        articleDatasource = [NSMutableArray arrayWithArray:(NSMutableArray<Article*>*)article];
        [self.articleTableView reloadData];
    });
}


// UITableView Datasource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [articleDatasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell* cell = [self.articleTableView dequeueReusableCellWithIdentifier:@"articleCell"];
    
    if(cell == nil) {
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"articleCell"];
        
    } else {
        cell.saveLtrBtn.tag = indexPath.row;
        cell.tag = indexPath.row;
        cell.dataTask = nil;
        cell.delegate = self;
        [cell configure:[articleDatasource objectAtIndex:indexPath.row] andImageCache:imageFromCache];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Article* article = (Article*)[articleDatasource objectAtIndex:indexPath.row];
    if([article.webArchiveUrl isEqualToString:@""]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:article.url] options:
                                 [NSDictionary new] completionHandler:nil];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WebViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
        controller.urlToLoad = article.webArchiveUrl;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

//Article Cell Delegate Methods

- (void)saveArchiveUrl:(NSUInteger)tag{
    Article* article = [articleDatasource objectAtIndex:tag];
    NSString* webString = [viewPresenter getStringFromUrl:article.url];
    if(![webString isEqualToString:@""]){
        [self.viewPresenter updateRecord: article.url :webString];
        [self showAlert:@"You can now view the page online" :@"Saved Successfully"];
    }
}

- (void)showAlert:(NSString*)message :(NSString*)title {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];

    //Add Buttons

    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    [alert addAction:okButton];

    [self presentViewController:alert animated:YES completion:nil];
    
}



// Action Methods

- (IBAction)deleteAll:(UIButton *)sender {
    [viewPresenter deleteAllRecords];
}

- (IBAction)toggleSort:(UIButton *)sender {
    if (!sortedAscending) {
        [viewPresenter fetchAscending:YES];
        [sender setTitle:@"Sort New" forState:UIControlStateNormal];
    } else {
        [viewPresenter fetchAscending:NO];
        [sender setTitle:@"Sort Old" forState:UIControlStateNormal];
    }
    sortedAscending = !sortedAscending;
}

- (IBAction)filterreset:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Type Author" message:@"You can type the author to search or reset filter" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Author Name";
        if(![self.viewPresenter.filter isEqualToString:@""]){
            [textField setText:self.viewPresenter.filter];
        }
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Filter" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.viewPresenter addFilter:[[alertController textFields][0] text]];
        sortedAscending = NO;
        [self.sortBtn setTitle:@"Sort Old" forState:UIControlStateNormal];

    }];
    [alertController addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Reset" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.viewPresenter resetFilter];
        sortedAscending = NO;
        [self.sortBtn setTitle:@"Sort Old" forState:UIControlStateNormal];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}



@end
