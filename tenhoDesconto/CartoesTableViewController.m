//
//  CartoesTableViewController.m
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 4/8/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import "CartoesTableViewController.h"
#import "Cartoes.h"


@interface CartoesTableViewController ()

@end

@implementation CartoesTableViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

-(id)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Fazer dois Arrays criando objetos para cada um e armazenando-os - Ver em MapViewController exampelo
    
    self.tableData = [NSArray arrayWithObjects:@"Visa",@"SulAmerica", nil];
    
    self.thumbnails = [NSArray arrayWithObjects:@"visa",@"sulamerica", nil];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    // Configurar a Célula
    static NSString *simpleTableIdentifier = @"CardsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:simpleTableIdentifier];
//        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"CardsCell" owner:self options:nil];
//        cell = [nib objectAtIndex:0];
    }
    

    //Carregar a imagem na célula
    
    cell.imageView.image = [UIImage imageNamed:[self.thumbnails objectAtIndex:indexPath.row]];
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    
    
    //Customizar qual layout da célula
    
    
    
    
    
   
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
