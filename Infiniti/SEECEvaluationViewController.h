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


#import <UIKit/UIKit.h>

#import "FGalleryViewController.h"

@class SEECPhotoGallerySource;

@interface SEECEvaluationViewController : UIViewController <FGalleryActionsDelegate>



@property (retain, nonatomic) IBOutlet UIImageView *certificationLevelImg;


@property (retain, nonatomic) IBOutlet UIImageView *evaluationStatus;


@property (retain, nonatomic) IBOutlet UILabel *DealerLabel;









@property (retain) UIPopoverController *popOverController1;
@property (retain) UIPopoverController *popOverController2;
@property (retain) UIPopoverController *popOverController3;
@property (retain) UIPopoverController *popOverController4;
@property (retain) UIPopoverController *popOverController5;
@property (retain) UIPopoverController *popOverController6;
@property (retain) UIPopoverController *popOverController7;
@property (retain) UIPopoverController *popOverController8;
@property (retain) UIPopoverController *popOverController9;


//manual
- (IBAction)NSSW:(UIButton *)sender;
- (IBAction)NSOS:(UIButton *)sender;
- (IBAction)ASDOS:(UIButton *)sender;
- (IBAction)NSGP:(UIButton *)sender;
- (IBAction)NREDI:(UIButton *)sender;
- (IBAction)NMOS:(UIButton *)sender;
- (IBAction)BPDOS:(UIButton *)sender;
- (IBAction)NAOS:(UIButton *)sender;
- (IBAction)NSRC:(UIButton *)sender;



//notifications for manual
- (void)manualNotification:(NSNotification *)notification;




///new button for evaluation and text

- (IBAction)applyEvaluation:(id)sender;


@property (retain, nonatomic) IBOutlet UITextView *objetive;

@property (retain, nonatomic) IBOutlet UITextView *activity;

@property (retain, nonatomic) IBOutlet UITextView *method;

@property (retain, nonatomic) IBOutlet UITextView *evidence;

@property (retain, nonatomic) IBOutlet UILabel *specialStandard;



//code of standard

@property (retain, nonatomic) IBOutlet UILabel *codeLabel;

// standard example nssw1.1

@property (retain, nonatomic) IBOutlet UILabel *standardName;

/// level unreached

@property (retain, nonatomic) IBOutlet UILabel *TypeOfBreachLabel;


// departament responsable

@property (retain, nonatomic) IBOutlet UILabel *DepartmentLabel;

////name responsable

@property (retain, nonatomic) IBOutlet UILabel *NameOfResponsibleLabel;


/////phase evaluation

@property (retain, nonatomic) IBOutlet UILabel *PhaseLabel;

@property (retain, nonatomic) SEECPhotoGallerySource *photoGalleryForEvaluation;
@property (retain, nonatomic) NSDictionary *dictionaryForImage;

- (IBAction)camera:(UIButton *)sender;





@property (retain, nonatomic) IBOutlet UIButton *evidence1but;

@property (retain, nonatomic) IBOutlet UIButton *evidence2but;

@property (retain, nonatomic) IBOutlet UIButton *evidence3but;




- (IBAction)evidence1Action:(UIButton *)sender;



- (IBAction)evidence2Action:(UIButton *)sender;



- (IBAction)evidence3Action:(UIButton *)sender;




@end
