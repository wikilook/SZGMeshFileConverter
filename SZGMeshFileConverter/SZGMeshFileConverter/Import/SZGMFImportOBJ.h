//
//  SZGMFImportOBJ.h
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZGMFImport.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief OBJ Importer, conforms to the SZGMFImport protocol
 */
@interface SZGMFImportOBJ : NSObject <SZGMFImport>
{
    /// Holds the vertices read from the file for easy access
    NSMutableArray* vertices;
    
    /// Holds the uv vertices read from the file for easy access
    NSMutableArray* uvs;
    
    /// Holds the normal vertices read from the file for easy access
    NSMutableArray* normals;
    
    /// Holds the faces read from the file for easy access
    NSMutableArray* faces;
}

@end

NS_ASSUME_NONNULL_END
