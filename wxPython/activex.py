## This file reverse renames symbols in the wx package to give
## them their wx prefix again, for backwards compatibility.
##
## Generated by BuildRenamers in config.py

# This silly stuff here is so the wxPython.wx module doesn't conflict
# with the wx package.  We need to import modules from the wx package
# here, then we'll put the wxPython.wx entry back in sys.modules.
import sys
_wx = None
if sys.modules.has_key('wxPython.wx'):
    _wx = sys.modules['wxPython.wx']
    del sys.modules['wxPython.wx']

import wx.activex

sys.modules['wxPython.wx'] = _wx
del sys, _wx


# Now assign all the reverse-renamed names:
CLSID = wx.activex.CLSID
CLSIDPtr = wx.activex.CLSIDPtr
wxParamX = wx.activex.ParamX
wxParamXPtr = wx.activex.ParamXPtr
wxFuncX = wx.activex.FuncX
wxFuncXPtr = wx.activex.FuncXPtr
wxPropX = wx.activex.PropX
wxPropXPtr = wx.activex.PropXPtr
wxParamXArray = wx.activex.ParamXArray
wxParamXArrayPtr = wx.activex.ParamXArrayPtr
wxFuncXArray = wx.activex.FuncXArray
wxFuncXArrayPtr = wx.activex.FuncXArrayPtr
wxPropXArray = wx.activex.PropXArray
wxPropXArrayPtr = wx.activex.PropXArrayPtr
wxActiveXWindow = wx.activex.ActiveXWindow
wxActiveXWindowPtr = wx.activex.ActiveXWindowPtr
RegisterActiveXEvent = wx.activex.RegisterActiveXEvent
wxActiveXEvent = wx.activex.ActiveXEvent
wxActiveXEventPtr = wx.activex.ActiveXEventPtr
wxIEHtmlWindowBase = wx.activex.IEHtmlWindowBase
wxIEHtmlWindowBasePtr = wx.activex.IEHtmlWindowBasePtr


d = globals()
for k, v in wx.activex.__dict__.iteritems():
    if k.startswith('EVT'):
        d[k] = v
del d, k, v



