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




#import "SEECDealerInfoViewController.h"
#import "SEECAuditoriaViewController.h"


@interface SEECDealerInfoViewController ()


@end

@implementation SEECDealerInfoViewController

@synthesize datePicker;



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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    
    self.datePicker = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)dealloc
{

    [datePicker release];
    [super dealloc];


}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)SaveDataDealer:(id)sender {
    

    
    //save data and remove screen
    NSLog(@"dismiss on save ...for back");
    [self dismissModalViewControllerAnimated:YES];
    
    
    
}


-(IBAction)button{

    NSDate *choice = [datePicker date];
    
    NSString *words = [[NSString alloc]initWithFormat:@"The date is %@", choice];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"The title" message:words delegate:nil cancelButtonTitle:@"Dissmis" otherButtonTitles:nil, nil];
    
    [alert show];
    
    [alert release];
    
    [words release];
    
    fecha.text = words;
    date.text = words;
       

}






@end