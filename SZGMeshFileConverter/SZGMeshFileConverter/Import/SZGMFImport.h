//
//  SZGMFImport.h
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#ifndef SZGMFImport_h
#define SZGMFImport_h

#import "SZGMFMesh.h"

/*!
 * @brief The import protocol, all different imports should conform this
 */
@protocol SZGMFImport <NSObject>

@required

- (SZGMFMesh*) importFileWithPath:(NSString*)filePath;


@end


#endif /* SZGMFImport_h */
