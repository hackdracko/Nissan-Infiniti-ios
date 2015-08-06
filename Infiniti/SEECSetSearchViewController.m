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


#import "SEECSetSearchViewController.h"
#import "AFJSONUtilities.h"
#import "SEECReportesViewController.h"
#import "SEECUser.h"
#import "SEECAuditoriaViewController.h"
#import "SEECReportesViewController.h"






@interface SEECSetSearchViewController ()
@end



NSDictionary *currentObject;



@implementation SEECSetSearchViewController

@synthesize selectedBranches;


UITableViewCell *cell;

- (id)initWithStyle:(UITableViewStyle)style
{
    
    //to unable scroll
    self.tableView.scrollEnabled = YES;
    self.title = @"Busqueda";
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
    
}





- (void)viewDidLoad
{
    
    
    [super viewDidLoad];

        
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"seec_branch" withExtension:@"json"];
    NSData *branches = [NSData dataWithContentsOfURL:url];
    
    NSError *error = nil;
    
    NSDictionary *response = AFJSONDecode(branches, &error);
    

    
    NSPredicate *predicate = nil;
    
    //there are the types
    
    
    NSLog(@" +++++++++++++++  %@",  [[SEECUser sharedInstance ]searchType ]  );
    NSLog(@" ===============  %@",   [[SEECUser sharedInstance ]searchValue] );
    
    
    if([[[SEECUser sharedInstance ]searchType ] isEqual:@"Por Tipo" ]){
       predicate = [NSPredicate predicateWithFormat:@"saleType CONTAINS %@", [[SEECUser sharedInstance ]searchValue] ];
    }

    
    if([[[SEECUser sharedInstance ]searchType ] isEqual:@"Por Palabra"]){
     //uppercase and lower case
     predicate = [NSPredicate predicateWithFormat:@" branchName CONTAINS[c] %@  OR  branchName CONTAINS [cd] %@ ", [[SEECUser sharedInstance ]searchValue], [[SEECUser sharedInstance ]searchValue]];
    }
    
    
    
    if([[[SEECUser sharedInstance ]searchType ] isEqual:@"Por Número"]){
      predicate = [NSPredicate predicateWithFormat:@" isvNumber == %@", [[SEECUser sharedInstance ]searchValue] ];
    }
    
    
        //global var
        NSArray *branchesSearched =[[[response valueForKey:@"dataroot"] valueForKey:@"seec_branch"] filteredArrayUsingPredicate:predicate];
        
        NSLog(@"Selected Branches: %@", branchesSearched);
    
        
        selectedBranches = [[NSMutableArray alloc] initWithArray:branchesSearched];
        
        
        
    
}



-(void) viewDidDisappear:(BOOL)animated{
   
  
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}






- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
     return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"numero de elementos %d", selectedBranches.count);
    return [self.selectedBranches count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Mycell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Mycell"];
    }
    
    //NSLog(@"  cell index %d", indexPath.row);
    

    currentObject = [ selectedBranches objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [currentObject valueForKey:@"branchName"]];
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
}







#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    //updating current object with index
    currentObject = [ selectedBranches objectAtIndex:indexPath.row];
    
  
    
    
    NSLog(@"Branch navigation branch name %@", [currentObject valueForKey:@"LK_branchId"]  );
    NSLog(@"indexPath  %d", indexPath.row );
    
    
    
    
    [[SEECUser sharedInstance]initPhone:[NSString stringWithFormat:@"%@", [currentObject valueForKey:@"phone"]]];
    
    
    [[SEECUser sharedInstance]initAdress:[NSString stringWithFormat:@"%@", [currentObject valueForKey:@"adress"]]];
    
    
    [[SEECUser sharedInstance]initbName:[NSString stringWithFormat:@"%@", [currentObject valueForKey:@"branchName"]]];
    
    
    
    
    //----
    NSString *bname = [NSString stringWithFormat:@"%@", [currentObject valueForKey:@"branchName"]];
    
    NSString *isvNumber= [NSString stringWithFormat:@"%@", [currentObject valueForKey:@"isvNumber"]];
    
    NSString *saleType= [NSString stringWithFormat:@"%@", [currentObject valueForKey:@"saleType"]];
    
    NSString *FK_zoneId= [NSString stringWithFormat:@"%@", [currentObject valueForKey:@"FK_zoneId"]];
    
    NSString *state= [NSString stringWithFormat:@"%@", [currentObject valueForKey:@"FK_stateId"]];
    
    NSString *city = [NSString stringWithFormat:@"%@", [currentObject valueForKey:@"FK_cityId"]];
    
    NSString *branchId = [NSString stringWithFormat:@"%@", [currentObject valueForKey:@"LK_branchId"]];
    
    //----
    
    
    
    NSArray *branchKeys = [NSArray arrayWithObjects:@"isvNumber",
                                                    @"saleType",
                                                    @"FK_zoneId",
                                                    @"branchName",
                                                    @"FK_stateId",
                                                    @"FK_cityId",
                                                    @"LK_branchId",
                                                    nil];
    
    
    NSArray *branchObjects = [NSArray arrayWithObjects:isvNumber, saleType, FK_zoneId, bname, state , city, branchId,  nil];
    
    
    NSDictionary *branchDictionary = [NSDictionary dictionaryWithObjects:branchObjects
                                                                 forKeys:branchKeys];
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"searchResult" object:branchDictionary];
        
    
    
  
        
    
}

@end






