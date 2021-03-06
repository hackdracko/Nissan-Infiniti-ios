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
#import "SEECNSSWViewController.h"
#import "SEECNSSWDetailViewController.h"
#import "AFJSONUtilities.h"
#import "SEECUser.h"



@interface SEECNSSWViewController ()

@end

@implementation SEECNSSWViewController





- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    self.title =@"Estandar";
    self.contentSizeForViewInPopover = CGSizeMake(425.0, 600.0);
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad
{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"seec_standard" withExtension:@"json"];
    NSData *std = [NSData dataWithContentsOfURL:url];
    
    NSError *error = nil;
    
    NSDictionary *response = AFJSONDecode(std, &error);
    
    
    NSPredicate *predicate;
    
    if([[[SEECUser sharedInstance]certificationLevel ] isEqualToString:@"Oro"]){
       
        predicate = [NSPredicate predicateWithFormat:@" phaseNum == %@  AND standardCode.length > 2 AND FK_manualId ==  %@",self.phaseNum, self.manualId ];
    }
    
     
    
    if([[[SEECUser sharedInstance]certificationLevel ] isEqualToString:@"Plata"]){
       
        predicate = [NSPredicate predicateWithFormat:@" phaseNum == %@  AND standardCode.length <= 2 AND FK_manualId ==  %@",self.phaseNum, self.manualId ];
    }
    

   NSLog(@"phaseNum : %@", self.phaseNum);
   NSLog(@"manual id : %@", self.manualId);
   //NSLog(@"standard: %@", response);
    
    
    NSArray *selectedStd =[[[response valueForKey:@"dataroot"] valueForKey:@"seec_standard"] filteredArrayUsingPredicate:predicate];
    
 
    
    _standart = [[NSMutableArray alloc] initWithArray:selectedStd];

         
    
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
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
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
    return [self.standart count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *currentObject = [self.standart objectAtIndex:indexPath.row];
    
    NSString *stdc = [currentObject valueForKey:@"standardCode"];
    NSString *spc = @".- ";
    NSString *stn = [currentObject valueForKey:@"standardName"];
    
    NSString *std = [[stdc stringByAppendingString:spc] stringByAppendingString:stn];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", std];
    // Configure the cell...
    
    return cell;
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SEECNSSWDetailViewController *standardVC = [[SEECNSSWDetailViewController alloc] initWithStyle:UITableViewStylePlain];

    
    //not for now is for recover info with shared instace
    NSDictionary *currentObject = [self.standart objectAtIndex:indexPath.row];
  
    //not for now, to recover
    NSString *recoverInfo = [NSString stringWithFormat:@"%@", [currentObject valueForKey:@"LK_standardId"]];
    
    NSLog(@"+++++++++++++++++++%@",recoverInfo);
    
    
    standardVC.actId = [currentObject valueForKey:@"LK_standardId"];
    
    //setting standard name
    //NSString *stdc = [currentObject valueForKey:@"standardCode"];
    NSString *stn = [currentObject valueForKey:@"standardName"];
    
    //NSString *std = [stdc stringByAppendingString:stn];
    
    [[SEECUser sharedInstance] initStd:stn];

    
    [self.navigationController pushViewController:standardVC animated:YES];
    
    [standardVC release];

}



@end
