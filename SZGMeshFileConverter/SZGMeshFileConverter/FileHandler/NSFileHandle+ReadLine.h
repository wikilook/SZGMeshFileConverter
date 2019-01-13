//
//  NSFileHandle+ReadLine.h
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A category for the filehandle so we can read line by line
 */
@interface NSFileHandle (ReadLine)

/*!
 * @brief Reads a line from the file
 * @return the line 
 */
-(NSString*) readLine;

@end

NS_ASSUME_NONNULL_END
