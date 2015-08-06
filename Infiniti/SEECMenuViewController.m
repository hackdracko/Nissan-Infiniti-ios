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


#import "SEECMenuViewController.h"
#import "SEECUser.h"
#import "AFJSONUtilities.h"


@interface SEECMenuViewController ()

@end

@implementation SEECMenuViewController
@synthesize MenuUserLabel;
@synthesize MenuDealerSelected;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Menu";
    
    
    NSString *logId = [[SEECUser sharedInstance]userId];
    
    MenuDealerSelected.text =[SEECUser sharedInstance].bName;
    
    NSLog(@" %@", logId);
    
    
    
   
 NSDictionary *recoverInfo  =  [self recoverInfo:                                                                @"seec_user" : @"id == %@": logId: @"diffgram" : @"NewDataSet" ];
    
 NSLog( @" fname  = %@", [NSString stringWithFormat:@"%@", [recoverInfo valueForKey:@"firstName"]]  );
 NSLog( @" lname  = %@", [NSString stringWithFormat:@"%@", [recoverInfo valueForKey:@"lastName"]]  );

    
 NSString *fname =  [NSString stringWithFormat:@"%@", [recoverInfo valueForKey:@"firstName"]];
 NSString *lname =  [NSString stringWithFormat:@"%@", [recoverInfo valueForKey:@"lastName"]];
        
 MenuUserLabel.text = [  [fname stringByAppendingString:@" " ] stringByAppendingString:lname ];
    
    
}



- (void)viewDidUnload
{
    
    
    [self setMenuUserLabel:nil];
    [self setMenuDealerSelected:nil];
    [super viewDidUnload];
    
    

}



-(void)viewDidDisappear:(BOOL)animated{
 
    NSLog(@"view disapppear...");
    
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
     return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}








-(NSDictionary *) recoverInfo: (NSString *) fileJson
                             : (NSString *) query
                             : (NSString *) queryValues
                             : (NSString *) dataRoot
                             : (NSString *) setValue{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileJson withExtension:@"json"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *error = nil;
    
    NSDictionary *response = AFJSONDecode(data, &error);
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: query,queryValues];
    
    
    NSArray *items =[[[response valueForKey:dataRoot] valueForKey:setValue] filteredArrayUsingPredicate:predicate];
    
    
    NSDictionary *currentObject = [ items objectAtIndex:0];
    
    
    return currentObject;
    
}




- (void)dealloc {
   
    
    [MenuUserLabel release];
    [MenuDealerSelected release];
    [super dealloc];
}






@end
