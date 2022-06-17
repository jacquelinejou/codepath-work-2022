//
//  MovieViewController.m
//  Flixter
//
//  Created by jacquelinejou on 6/15/22.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "ColorCell.h"

@interface MovieViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movieArray;
@property (nonatomic, strong) UIRefreshControl * refreshControl;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchMovies];
    
    // initialize UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    //
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    
    // add refresh to tableView
//    [self.tableView addSubview:self.refreshControl];
    
    // add refresh with loading sign behind in view hierarchy
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

-(void)fetchMovies {
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=21b8f81cdf1293cabefccd047ba0672a"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Network Error"
                                                  message:@"Movies failed to load. Check your connection."
                                                  preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                      handler:^(UIAlertAction * action) {}];

                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSLog(@"%@", dataDictionary);
               self.movieArray = dataDictionary[@"results"];
               for (NSDictionary *movie in self.movieArray) {
                   NSLog(@"%@", movie[@"title"]);
               }
               
               [self.tableView reloadData];
               // TODO: Get the array of movies
               // TODO: Store the movies in a property to use elsewhere
               // TODO: Reload your table view data
           }
        [self.refreshControl endRefreshing];
       }];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movieArray.count;
    // return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // forIndexPath: indexPath added in
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movieArray[indexPath.row];
    NSLog([NSString stringWithFormat:@"row: %d, section %d", indexPath.row, indexPath.section]);
    // cell.textLabel.text = [NSString stringWithFormat:@"row: %d, section %d", indexPath.row, indexPath.section];
   // cell.textLabel.text = movie[@"title"];
    cell.titleLabel.text = movie[@"title"];
    cell.synposisLabel.text = movie[@"overview"];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    NSLog(@"%@", posterURL);
    [cell.posterImage setImageWithURL:posterURL];
//    if (movies) {
//        // 1. Get the first photo in the photos array
//        NSDictionary *movieDic = movies[0];
//
//        // 2. Get the original size dictionary from the photo
//        NSDictionary *originalSize =  movieDic[@"original_size"];
//
//        // 3. Get the url string from the original size dictionary
//        NSString *urlString = originalSize[@"url"];
//
//        // 4. Create a URL using the urlString
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSLog(@"%@", urlString);
//        [cell.posterView setImageWithURL:posterURL];
//    }
    
    return cell;
}

int totalColors = 100;
- (UIColor*)colorForIndexPath:(NSIndexPath *) indexPath{
    if(indexPath.row >= totalColors){
        return UIColor.blackColor;    // return black if we get an unexpected row index
    }
    
    CGFloat hueValue = (CGFloat)(indexPath.row)/(CGFloat)(totalColors);
    return [UIColor colorWithHue:hueValue saturation:1.0 brightness:1.0 alpha:1.0];
}

#pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
    // what should come before indexPathForCell
    if ([segue.identifier isEqualToString:@"MovieViewSegue"]) {
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:sender];
        //you'll need to have gotten an index with indexPathForCell
        NSDictionary *dataToPass = self.movieArray[myIndexPath.row];
        NSLog(@"%ld", myIndexPath.row);
        DetailsViewController *detailVC = [segue destinationViewController];
        detailVC.detailDict = dataToPass;
//        NSLog(@"%@", dataToPass);
    }
}

@end
