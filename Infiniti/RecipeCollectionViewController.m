

#import "RecipeCollectionViewController.h"
#import "RecipeViewCell.h"

#import "AFHTTPClient.h"

#import "SEECUser.h"
#import "NSArray+Persistence.h"
#import "JSONKit.h"
#import "SEECReplicaViewController.h"



/*add libraries 31 05 2013*/

#import "SEECServerRequest.h"


#import "SEECReplicaViewController.h"
#import "AFJSONRequestOperation.h"
#import "NSDictionary+Persistence.h"

#import "SEECServerRequest.h"
#import "AFJSONUtilities.h"
#import "SEECPhaseViewController.h"
#import "SEECPhaseWebViewController.h"
#import "SEECSearchByPhaseViewController.h"
#import "SEECSetSearchViewController.h"
#import "SEECUser.h"
#import "NSData+Persistence.h"
#import "SEECTypeViewController.h"
#import "SEECAlertViewController.h"
#import "SEECBranchFromWebViewController.h"

#import "SEECEvaluationWebViewController.h"
#import "UIImage+Persistence.h"

//DND is for production https://seec.bestoption.com.mx/
#define kIMAGE_SERVICE_BASE @"https://seec.bestoption.com.mx/"

//#define kIMAGE_SERVICE_BASE @"http://192.168.1.12:85/"

@interface RecipeCollectionViewController()

@end

@implementation RecipeCollectionViewController

NSArray *recipeImages;
NSMutableArray *files_;
BOOL *shareEnabled;
NSMutableArray *selectedRecipes;

@synthesize evaluationsWeb;
@synthesize upload_file;


UIAlertView *alert;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    if(files_!=nil){[files_ release];}
    if(recipeImages!=nil){[recipeImages release];}
    if(selectedRecipes!=nil){[selectedRecipes release];}
    
   
    [self loadImages];
    [super viewDidLoad];
    
    

}
- (void)viewDidUnload
{
    
        [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void) dealloc {
    //este método es llamado automáticamente cuando retain=0
    //no debe ser llamado manualmente
    [super dealloc];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   return [evaluationsWeb count];
    
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    
    RecipeViewCell *cell = (RecipeViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    [recipeImageView release];
    
    NSDictionary *currentObject = [self.evaluationsWeb objectAtIndex:indexPath.row];
    [currentObject release];
   
    recipeImageView.image = [UIImage imageFromFileName:[NSString stringWithFormat:@"%@",[currentObject valueForKey:@"fileName"]]];
    //recipeImageView.image = [UIImage imageFromFileName:[recipeImages[indexPath.section] objectAtIndex:indexPath.row]];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame-2.png"]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame-selected.jpg"]];
    
    
   
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (shareEnabled) {        
        NSString *selectedRecipe = [recipeImages[indexPath.section] objectAtIndex:indexPath.row];
        [selectedRecipes addObject:selectedRecipe];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
       if (shareEnabled) {
        NSString *deSelectedRecipe = [recipeImages[indexPath.section] objectAtIndex:indexPath.row];
        [selectedRecipes removeObject:deSelectedRecipe];
    }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (shareEnabled) {
        return NO;
    } else {
        return YES;
    }
}

- (IBAction)upload_touched:(id)sender {
    
    if (shareEnabled) {
        
        
        // Publicar Fotos
        if ([selectedRecipes count] > 0) {
            NSLog(@"%d",[selectedRecipes count]);
      
            alert=[[UIAlertView alloc]initWithTitle:@"Publicando fotos" message:@"\n" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
             
            UIActivityIndicatorView *spinner =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            spinner.center=CGPointMake(140, 76);
            [alert addSubview:spinner];
            [spinner startAnimating];
           [alert show];
            [self performSelector:@selector(dosomthing) withObject:nil afterDelay:0];
            //enviar las fotos 1x1 ciclo  
            
        }
              
           
        
        // Change the sharing mode to NO
        shareEnabled = NO;
        //self.collectionView.allowsMultipleSelection = NO;
        self.upload_file.title=@"Seleccionar";
        [self.upload_file setStyle:UIBarButtonItemStylePlain];
       
        
    } else {
        
        // Change shareEnabled to YES and change the button text to DONE
        shareEnabled = YES;
        self.collectionView.allowsMultipleSelection = YES;
        self.upload_file.title=@"Publicar";
        [self.upload_file setStyle:UIBarButtonItemStyleDone];
        for(NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems) {
            // [self.collectionView selectItemAtIndexPath:indexPath animated:NO];
            [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
            
            NSString *selectedRecipe = [recipeImages[indexPath.section] objectAtIndex:indexPath.row];
            [selectedRecipes addObject:selectedRecipe];
            
            
        }
        
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [self deleteItems];
   
  
    [self.collectionView removeFromSuperview];
    [self.collectionView release];
      [self.view removeFromSuperview];
    [self release];
    [self removeFromParentViewController];
    
}



-(void)dosomthing
{
    //enviar las fotos 1x1 ciclo
    for (int i=0 ; i<[selectedRecipes count];i++){
        
        NSDictionary *datos = [files_[0] objectAtIndex:i];
        
        //crear un diccionario y asignando los valores
        
        NSString *nombre = [NSString stringWithFormat:@"%@",[datos valueForKey:@"fileName"]];
        NSString *evaluationid = [NSString stringWithFormat:@"%@",[datos valueForKey:@"evaluationId"]];
        [self sendFileToServer:nombre evaluationID:evaluationid];
        NSDate *future =[NSDate dateWithTimeIntervalSinceNow:10];
        [NSThread sleepUntilDate:future];
        NSLog(@"Subiendo Imagen  %d, siguiente en subir dentro de %@",i,future);
        
        //[datos release];
        //[nombre release];
        //[evaluationid release];
        //[future release];
        
    }
     [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert release];
    [self deleteItems];
   
   
       
   

}
-(void)deleteItems
{
    // Deselect all selected items
    /* for(NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
     [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
     
     
     }*/
    
    // Permission to delete the button is granted here.
    NSArray *selectedItemsIndexPaths = [self.collectionView indexPathsForVisibleItems];
    // int countItems=[self.collectionView.indexPathsForSelectedItems count];
    //for (int i=countItems ; i==0;i--)
    [evaluationsWeb removeAllObjects];
    //for(NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems)
    //{
        // Delete the items from the data source.
      //  [evaluationsWeb removeObjectAtIndex:indexPath.section];
    //}
    
    //[self.evaluationsWeb removeObjectsInArray:selectedItemsIndexPaths];
    // Now delete the items from the collection view.
    
    [self.collectionView deleteItemsAtIndexPaths:selectedItemsIndexPaths];
    // Remove all items from selectedRecipes array
    [selectedRecipes removeAllObjects];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        SEECHeadImageView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
       // NSString *title = [[NSString alloc]initWithFormat:@"Evidence", indexPath.section + 1];
       // headerView.title.text = title;
        //UIImage *headerImage = [UIImage imageNamed:@"header_banner.png"];
        //headerView.backgroundImage.image = headerImage;
        
        reusableview = headerView;
    }
    
        
    return reusableview;
}

-(IBAction)volverPantalla2:(id)sender
{
   [self dismissModalViewControllerAnimated:YES];
}
*/

/*metodo para subir los archivos*/
-(void) sendFileToServer:(NSString *)fileserver evaluationID:(NSString *) evaluationID {

    
    
    
    NSLog(@"EvidenceNotification ");
    
    //[self.popOverEvidences dismissPopoverAnimated:YES];
    
    NSLog(@"sending test image");
    
    //posting image
    
    // Images seem to have the following name in format: @"MDS-%0.0f"
    UIImage *testImage = [UIImage imageFromFileName:fileserver];
    
    self.title = @"Subiendo evidencia";
    
    //[self postImage:testImage withName:fileName user:user evaluationID:evaluationId];
    
    //make post of imagen
    [self postImage:testImage withName:fileserver user:@"1749" evaluationID:evaluationID];
    
   
   
    
    self.title = @"Evidencia lista";
    
    //borrar imagen
    [self deleteJsonEvidense:fileserver];
    
    self.title = @"Actualizar evidencias";
    

    }


/*metodo envio correcto de archivos*/
- (void)postImage:(UIImage *)capturedImage withName: (NSString *) imageName user:(NSString *)user evaluationID: (NSString *) evaluationID
{
    if (!capturedImage ||
        ![imageName length] ||
        ![user length] ||
        ![evaluationID length]) return;     // Avoiding empty or missing parameters
    
    NSURL *serverImageBaseURL = [NSURL URLWithString:kIMAGE_SERVICE_BASE];
    
    AFHTTPClient *clientForImage = [[AFHTTPClient alloc] initWithBaseURL:serverImageBaseURL];
    
    
    NSLog(@" base url is  %@", serverImageBaseURL);
    
    NSData *imageData = UIImagePNGRepresentation(capturedImage);
    
    //original
    //NSString *pathWithParameters = [NSString stringWithFormat:@"/ImagePwc/Upload/%@/%@/%@/%@", imageName, @"png", user, evaluationID];
    
    //new
    //ImagePwc/UploadService.svc/Upload
    NSString *pathWithParameters = [NSString stringWithFormat:@"imagepwc/UploadService.svc/Upload/%@/%@/%@/%@", imageName, @"png", user, evaluationID];
    
   // NSString *pathWithParameters = [NSString stringWithFormat:@"PWCImage/UploadService.svc/Upload/%@/%@/%@/%@", imageName, @"png", user, evaluationID];
    
    NSLog(@"the url to invoke is --------%@", pathWithParameters);
    
    
    NSMutableURLRequest *imagePostRequest = [clientForImage multipartFormRequestWithMethod:@"POST"
                                                                                      path:pathWithParameters
                                                                                parameters:nil
                                                                 constructingBodyWithBlock:^(id <AFMultipartFormData>formData) {
                                                                     [formData appendPartWithFileData:imageData name:imageName
                                                                                             fileName:[imageName stringByAppendingString:@".png"]
                                                                                             mimeType:@"image/png"];
                                                                 }];
    
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:imagePostRequest];
    

    
    
    [clientForImage enqueueHTTPRequestOperation:operation];
    
    if(imageData!=nil){imageData=nil;}
    if(imagePostRequest!=nil){imagePostRequest=nil;}
    if(clientForImage!=nil){[clientForImage release];}
    if(operation!=nil){[operation release];}
    
     
   
    
    
    NSLog(@"end test image");
    
}


/*metodo para actualizar json*/
-(void) deleteJsonEvidense: (  NSString *) FileName {
    //get all samples
    NSArray *response = [NSArray arrayFromFileName:@"seec_evidenceFile.json"];
    NSMutableArray *allEvidence = [[NSMutableArray alloc] init];//1738
    //NSError *error = nil;
    
    //NSLog(@" samples ........%@", response);
    
    NSMutableArray *targetArray = [NSMutableArray array];
    
    NSMutableArray *newArray = [NSMutableArray array];
    
    //Add new definitions
    NSDictionary *valor;
    
    if (response != nil)    // Previous captures exist
    {
        
        
        [targetArray addObjectsFromArray:response];
        
        NSLog(@"BUSCANDO ARCHIVO ->%@", FileName);
        
        for (int i=0; i<[targetArray count]; ++i)
        {
            
            NSDictionary *foto = [response objectAtIndex:i];
            
            
            if ([[foto valueForKey:@"fileName"] isEqualToString:FileName])
            {
                //remove item
                NSLog(@" Estado Actualizado . .  .");
                //[targetArray removeObject: i];
                valor=foto;
                
            }
            else{
                
                [newArray addObject:foto];
                
            }
            
        }
        
        //NSLog(@"Update removed file on  json %@",newArray);
        
        [newArray saveArrayWithFileName:@"seec_evidenceFile.json"];//Erase the inf
        
        //NSString *consecutive = [NSString stringWithFormat:@"%d", [response count]+1];
        //NSMutableArray *allEvidence = [[NSMutableArray alloc] init];//working perfect
        
        /*Updating the files*/
        NSArray *keys = @[@"lk_evidenceFileID",
                          @"fk_evaluationID",
                          @"fk_userID",
                          @"fileName",
                          @"evidenceFile",
                          @"contentType",
                          @"fileSize",
                          @"attachDate",
                          @"activefile",
                          @"status",
                          @"phase",
                          @"branchID",
                          @"activityId",
                          @"evaluationId"];
        
        
        NSArray *objects = @[[valor valueForKey:@"lk_evidenceFileID"],
                             [valor valueForKey:@"fk_evaluationID"],
                             [valor valueForKey:@"fk_userID"],
                             [valor valueForKey:@"fileName"],
                             [valor valueForKey:@"evidenceFile"],
                             @"image/png",
                             [valor valueForKey:@"fileSize"],
                             [valor valueForKey:@"attachDate"],
                             [valor valueForKey:@"activefile"],
                             @"1",
                             [valor valueForKey:@"phase"],
                             [valor valueForKey:@"branchID"],
                             [valor valueForKey:@"activityId"],
                             @"0" ];
        
        
        NSDictionary *currentImageDictionary = [NSDictionary dictionaryWithObjects:objects
                                                                           forKeys:keys];
        //Updating ...
        
        NSArray *arrayOfEvidence = [NSArray arrayFromFileName:@"seec_evidenceFile.json"];
        
        //NSLog(@"valores nuevos %@",arrayOfEvidence);
        if (arrayOfEvidence)
        {
            [allEvidence addObjectsFromArray:arrayOfEvidence];
        }
        
        [allEvidence addObject:currentImageDictionary];
        
        [allEvidence saveArrayWithFileName:@"seec_evidenceFile.json"];
        
        
        
    }
}








-(void)loadImages
{
        
     NSMutableArray *allEvidence = [NSMutableArray array];
     
     /*
     
     NSInteger numberOfViews = [evaluationsWeb count];
     
     NSMutableArray *finImage=[NSMutableArray array];
     
     NSDictionary *valor;
     
     
     
     for (int i = 0; i < numberOfViews; i++)
     {
     
     NSDictionary *foto = [images objectAtIndex:i];
     NSString *imagePath = [NSString stringWithFormat:@"%@",[foto valueForKey:@"fileName"]];
     
     
     if (imagePath)
     {
     //asignando el diccionario anterior a uno nuevo
     valor=foto;
     //crear un nuevo diccionario
    
    Reasignando los nuevos valores para, que estos puedan ser enviados y eliminados
           NSArray *keys = @[@"lk_evidenceFileID",
     @"fk_evaluationID",
     @"fk_userID",
     @"fileName",
     @"evidenceFile",
     @"contentType",
     @"fileSize",
     @"attachDate",
     @"activefile",
     @"status",
     @"phase",
     @"branchID",
     @"activityId",
     @"evaluationId"];
     
     
     NSArray *objects = @[[valor valueForKey:@"lk_evidenceFileID"],
     [valor valueForKey:@"fk_evaluationID"],
     [valor valueForKey:@"fk_userID"],
     [valor valueForKey:@"fileName"],
     [valor valueForKey:@"evidenceFile"],
     @"image/png",
     [valor valueForKey:@"fileSize"],
     [valor valueForKey:@"attachDate"],
     [valor valueForKey:@"activefile"],
     @"1",
     [valor valueForKey:@"phase"],
     [valor valueForKey:@"branchID"],
     [valor valueForKey:@"activityId"],
     @"0" ];
     
     
     NSDictionary *currentImageDictionary = [NSDictionary dictionaryWithObjects:objects
     forKeys:keys];
     
     
     
     
     
     
     [allEvidence addObject:currentImageDictionary];
     
     [finImage addObject:imagePath];//agrega el nombre del archivo
     }
     
     
     }*/
    
    
    
    NSInteger numberOfViews = [evaluationsWeb count];
    for (int i = 0; i < numberOfViews; i++)
    {
        NSDictionary *foto = [evaluationsWeb objectAtIndex:i];
        NSString *imagePath = [NSString stringWithFormat:@"%@",[foto valueForKey:@"fileName"]];
        
        if (imagePath)
        {
            [allEvidence addObject:imagePath];
        }
    }
     // Inicializa Array de imagenes
     NSArray *mainDishImages = [NSArray arrayWithArray:allEvidence];
     NSMutableArray *file_s= [NSMutableArray arrayWithArray:evaluationsWeb ];
     
     recipeImages = [[NSArray arrayWithObjects:mainDishImages, nil]retain];
     
     files_ = [[NSArray arrayWithObject:file_s]retain];
     UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
     collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
     
     selectedRecipes = [[NSMutableArray array]retain];
     
}




@end
