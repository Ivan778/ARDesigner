//
//  Converter.m
//  ARDesignerConverter
//
//  Created by Иван on 18.03.2018.
//  Copyright © 2018 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Converter.h"

void convert(NSString *command) {
    system([command UTF8String]);
}
