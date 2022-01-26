/*
 * Copyright (c) 2006, Edwin van Rijkom, Nicolas Cannasse
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE HAXE PROJECT CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE HAXE PROJECT CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */
package systools;
import systools.Key;
#if hl
import systools.hl.HLSystools;
#end
class Misc {

	private static function keymapMac(c) {
		return switch( c ) {
		case LeftCtrl: 0x3B;
		case RightCtrl: 0x3B;
		case LeftShift: 0x38;
		case RightShift: 0x38;
		case Alt: 0x3A;
		case Custom(code): code;
		}
	}

	private static function keymapWin(c) {
		return switch( c ) {
		case LeftCtrl: 0xA2;
		case RightCtrl: 0xA3;
		case LeftShift: 0xA0;
		case RightShift: 0xA1;
		case Alt: 0x12;
		case Custom(code): code;
		}
	}


	public static function getKeyState( key: Key ) : Bool {
		var sysname = Sys.systemName();
		var goodKey:Int = switch( sysname ) {
			case "Mac": keymapMac(key);
			case "Windows": keymapWin(key);
			default: throw "Not supported "+sysname;
		}
		return #if hl HLSystoools.hlMiscGetKeyState(goodKey) #else _misc_get_key_state(goodKey) #end != 0 ;
	}
	#if !hl
	static var _misc_get_key_state = systools.Loader.load("systools","misc_get_key_state",1);
	#end
}

