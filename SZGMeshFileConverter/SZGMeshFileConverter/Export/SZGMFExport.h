//
//  SZGMFExport.h
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#ifndef SZGMFExport_h
#define SZGMFExport_h

#import "SZGMFMesh.h"

/*!
 * @brief The export protocol, all different exports should conform this
 */
@protocol SZGMFExport <NSObject>

@required

- (void) exportFileWithPath: (NSString*)filePath mesh:(SZGMFMesh*)mesh;


@end

#endif /* SZGMFExport_h */
