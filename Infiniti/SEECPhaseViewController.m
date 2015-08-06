/*
 
 Product is designed by MINDBITS,  trade mark registered in Mexico.
 
 
 For tecnical support:
 
 www.mindbits.com.mx
 info@mindbits.com.mx
 ventas@mindbits.com.mx
 
 All right reserved, Do not edit this file!.
 sotware product delivered and tested under standards  by pwc mexico.
 
 Warning: this product is writting in production enviroment.
 
 This is a copy of original software, administered  by an third part,  so this software its License is distributed on an "AS IS",  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. the trade mark MINDBITS is not resposable for errors or mistakes in PWC / NISSAN production enviroments. Open Sources libraries show its own conditions of distributions.
 
 */ 


#import "SEECPhaseViewController.h"
#import "SEECAuditoriaViewController.h"
#import "SEECUser.h"




@interface SEECPhaseViewController ()

@end




@implementation SEECPhaseViewController

@synthesize phases;
@synthesize LK_PhaseCatalogID;



- (id)initWithStyle:(UITableViewStyle)style
{
    
    //to unable scroll
    self.tableView.scrollEnabled = YES;
    //adjust in popover
    self.contentSizeForViewInPopover = CGSizeMake(250.0, 100.0);
    //Set Title
    self.title = @"Ronda en iPad";
    
    
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
    
}







- (void)viewDidLoad
{
    
    phases = [[NSArray alloc] initWithObjects:
              @"FY13 - 2a Ronda",
              @"FY13 - 1a Ronda",
              @"FY12 - 4a Ronda",
              @"FY12 - 3ra Ronda",
              @"FY12 - 2da Ronda",
              @"FY12 - 1er Ronda",
              @"FY11 - 4a  Ronda",
              @"FY11 - 3ra Ronda",
              @"FY11 - 2da Ronda",
              @"FY11 - 1er Ronda",
              @"FY10 - 2da Ronda",
              @"FY10 - 1er Ronda",
              nil];
    
    LK_PhaseCatalogID = [[NSArray alloc] initWithObjects:
                         @"12",
                         @"11",
                         @"10",
                         @"9",
                         @"8",
                         @"7",
                         @"6",
                         @"5",
                         @"4",
                         @"3",
                         @"2",
                         @"1",
                         nil];
    
    
    
    [super viewDidLoad];
    
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"numero de lementos %d", phases.count);
    return [phases count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Mycell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Mycell"];
    }
    
    cell.textLabel.text = [phases objectAtIndex:indexPath.row];
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //cell.backgroundColor = [UIColor grayColor];
    
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    //build  an object to report in notification
    
    NSArray *objKeys = [NSArray arrayWithObjects: @"label", @"id",  nil];
    
    
    NSArray *branchObjects = [NSArray arrayWithObjects:[phases objectAtIndex:indexPath.row], [LK_PhaseCatalogID objectAtIndex:indexPath.row], nil];
    
    
    NSDictionary *branchDictionary = [NSDictionary dictionaryWithObjects:branchObjects forKeys:objKeys];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"phases" object:branchDictionary];
    
    
}



- (void)dealloc
{
    [phases dealloc];
    [LK_PhaseCatalogID dealloc];
    [super dealloc];
}



@end

