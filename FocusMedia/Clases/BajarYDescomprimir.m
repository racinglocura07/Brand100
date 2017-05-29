//
//  BajarYDescomprimir.m
//  FocusMedia
//
//  Created by Administrador on 20/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "BajarYDescomprimir.h"

@implementation BajarYDescomprimir
@synthesize receivedData;

-(void) BajarArchivo:(NSString *)ruta{
    
//    NSString *urlString = [NSString stringWithFormat:@"%@/%@", URL_API, action];
//    
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:ourBlock] resume];

}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
    
    
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:[@"Recursos" stringByAppendingString:@".zip"]];
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [receivedData writeToFile:pdfPath atomically:YES];
}

@end
