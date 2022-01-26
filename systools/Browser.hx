/*
 * Copyright (c) 2007, Edwin van Rijkom, Nicolas Cannasse, Lee McColl-Sylvester, Ian Thomas
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
#if hl
import systools.hl.HLSystools;
#end
class Browser {

	/** Launches the default browser and opens it at the target URL.
	    Mac or Windows only at present.
		@param targetURL
		@return true if successful
	*/
	public static function launch(targetURL:String):Bool
	{
	    var sys:String=Sys.systemName();
	    if ((sys!="Mac")&&(sys!="Windows"))
			throw "systools.Browser.launch() only works on Mac or Windows";
		#if hl
		return HLSystools.hlBrowserLaunch(targetURL);
		#else 
		return _browser_launch(targetURL);
		#end
	}
	#if !hl
	static var _browser_launch = systools.Loader.load("systools","browser_launch",1);
	#end
}
