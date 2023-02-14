public class attachPDFToAccount {
    
    private final Account a; //Account object
    
    //constructor
    public attachPDFToAccount(ApexPages.StandardController standardPageController) {
        a = (Account)standardPageController.getRecord(); //instantiate the Account object for the current record
        PageReference pdfPage = Page.GeneratePDF; //create a page reference to our pdfDemo Visualforce page, which was created from the post https://interactiveties.com/blog/2015/render-visualforce-pdf.php
        Blob pdfBlob; //create a blob for the PDF content
        
        if (!Test.isRunningTest()) { //if we are not in testing context
            pdfBlob = pdfPage.getContent(); //generate the pdf blob
        } else { //otherwise, we are in testing context and getContent() gets funky so create the blob manually
            pdfBlob = Blob.valueOf('Some Text for a boring PDF file...');
        }
        
        //System.debug(value);
        Attachment attach = new Attachment(parentId = a.Id, Name = 'pdfAttachmentDemo2.pdf', body = pdfBlob); //create the attachment object
        insert attach; //insert the attachment
        
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S';
        cv.VersionData = pdfBlob;
        cv.Title = 'TestFile.pdf';
        cv.PathOnClient = 'TestFile.pdf';
        insert cv;
 
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id].ContentDocumentId;
        cdl.LinkedEntityId = a.Id;
        cdl.ShareType = 'V';
        insert cdl;
    }
    
    //method called from the Visualforce's action attribute
   public PageReference attachPDF() {
       /* String value = apexpages.currentPage().getParameters().get('render');
        system.debug(apexpages.currentPage().getParameters());
        system.debug(System.currentPageReference().getParameters());
        //generate and attach the PDF document
        PageReference pdfPage = Page.GeneratePDF; //create a page reference to our pdfDemo Visualforce page, which was created from the post https://interactiveties.com/blog/2015/render-visualforce-pdf.php
        Blob pdfBlob; //create a blob for the PDF content
        
        if (!Test.isRunningTest()) { //if we are not in testing context
            pdfBlob = pdfPage.getContent(); //generate the pdf blob
        } else { //otherwise, we are in testing context and getContent() gets funky so create the blob manually
            pdfBlob = Blob.valueOf('Some Text for a boring PDF file...');
        }
        
        System.debug(value);
        Attachment attach = new Attachment(parentId = a.Id, Name = 'pdfAttachmentDemo2.pdf', body = pdfBlob); //create the attachment object
        insert attach; //insert the attachment
         */
         
       /* ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S';
        cv.VersionData = pdfBlob;
        cv.Title = 'TestFile.pdf';
        cv.PathOnClient = 'TestFile.pdf';
        insert cv;
 
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id].ContentDocumentId;
        cdl.LinkedEntityId = a.Id;
        cdl.ShareType = 'V';
        insert cdl;
        */
        
        //redirect the user
       /* PageReference pageWhereWeWantToGo = new ApexPages.StandardController(a).view(); //we want to redirect the User back to the Account detail page
        pageWhereWeWantToGo.setRedirect(true); //indicate that the redirect should be performed on the client side
        return pageWhereWeWantToGo; //send the User on their way
        */
        return null;
    }

}