/////////////////////////////////////////////////////////////////////////////
// Name:        _control.i
// Purpose:     SWIG interface defs for wxControl and other base classes
//
// Author:      Robin Dunn
//
// Created:     10-June-1998
// RCS-ID:      $Id$
// Copyright:   (c) 2003 by Total Control Software
// Licence:     wxWindows license
/////////////////////////////////////////////////////////////////////////////

// Not a %module


//---------------------------------------------------------------------------

MAKE_CONST_WXSTRING(ControlNameStr);

//---------------------------------------------------------------------------
%newgroup;


DocStr(wxControl,
"This is the base class for a control or 'widget'.

A control is generally a small window which processes user input
and/or displays one or more item of data.", "");

MustHaveApp(wxControl);

class wxControl : public wxWindow
{
public:
    %pythonAppend wxControl         "self._setOORInfo(self)"
    %pythonAppend wxControl()       ""
    %typemap(out) wxControl*;    // turn off this typemap

    DocCtorStr(
        wxControl(wxWindow *parent,
                  wxWindowID id=-1,
                  const wxPoint& pos=wxDefaultPosition,
                  const wxSize& size=wxDefaultSize,
                  long style=0,
                  const wxValidator& validator=wxDefaultValidator,
                  const wxString& name=wxPyControlNameStr),
        "Create a Control.  Normally you should only call this from a subclass'
__init__ as a plain old wx.Control is not very useful.", "");

    DocCtorStrName(
        wxControl(),
        "Precreate a Control control for 2-phase creation", "",
        PreControl);

    // Turn it back on again
    %typemap(out) wxControl* { $result = wxPyMake_wxObject($1, $owner); }


    DocDeclStr(
        bool , Create(wxWindow *parent,
                      wxWindowID id=-1,
                      const wxPoint& pos=wxDefaultPosition,
                      const wxSize& size=wxDefaultSize,
                      long style=0,
                      const wxValidator& validator=wxDefaultValidator,
                      const wxString& name=wxPyControlNameStr),
        "Do the 2nd phase and create the GUI control.", "");
    

    DocDeclStr(
        int , GetAlignment() const,
        "Get the control alignment (left/right/centre, top/bottom/centre)", "");
    

    DocDeclStr(
        wxString , GetLabelText() const,
        "Get just the text of the label, without mnemonic characters ('&')", "");
    

    
    DocDeclStr(
        void , Command(wxCommandEvent& event),
        "Simulates the effect of the user issuing a command to the item.

:see: `wx.CommandEvent`
", "");
   

//     DocDeclStr(
//         bool , GetAdjustMinSizeFlag(),
//         "Returns whether the minsize should be adjusted for this control when
// `SetLabel` or `SetFont` are called.", "");
    
//     DocDeclStr(
//         void , SetAdjustMinSizeFlag(bool adjust),
//         "By default controls will readjust their size and minsize when
// `SetLabel` or `SetFont` are called.  This flag will allow you to
// control this behavior.", "

// :see: `GetAdjustMinSizeFlag`
// ");

 
    DocDeclStr(
        static wxString , RemoveMnemonics(const wxString& str),
        "removes the mnemonics characters", "");

    
// Link error...
//     DocDeclStr(
//         static wxString , EscapeMnemonics(const wxString& str),
//         "escapes the mnemonics characters ('&') by doubling them", "");
    
     
    static wxVisualAttributes
    GetClassDefaultAttributes(wxWindowVariant variant = wxWINDOW_VARIANT_NORMAL);

    %property(Alignment, GetAlignment, doc="See `GetAlignment`");
    %property(LabelText, GetLabelText, doc="See `GetLabelText`");

};


//---------------------------------------------------------------------------
%newgroup;




DocStr(wxItemContainer,
"The wx.ItemContainer class defines an interface which is implemented
by all controls which have string subitems, each of which may be
selected, such as `wx.ListBox`, `wx.CheckListBox`, `wx.Choice` as well
as `wx.ComboBox` which implements an extended interface deriving from
this one.

It defines the methods for accessing the control's items and although
each of the derived classes implements them differently, they still
all conform to the same interface.

The items in a wx.ItemContainer have (non empty) string labels and,
optionally, client data associated with them.
", "");

class wxItemContainer
{
public:
    // wxItemContainer()  ** It's an ABC
    

    %extend {
        DocStr(Append,
               "Adds the item to the control, associating the given data with the item
if not None.  The return value is the index of the newly added item
which may be different from the last one if the control is sorted (e.g.
has wx.LB_SORT or wx.CB_SORT style).", "");
        int Append(const wxString& item, PyObject* clientData=NULL) {
            if (clientData) {
                wxPyClientData* data = new wxPyClientData(clientData);
                return self->Append(item, data);
            } else
                return self->Append(item);
        }
    }
    
    DocDeclAStrName(
        void , Append(const wxArrayString& strings),
        "AppendItems(self, List strings)",
        "Apend several items at once to the control.  Notice that calling this
method may be much faster than appending the items one by one if you
need to add a lot of items.", "",
        AppendItems);

    
    %extend {
        DocStr(Insert,
               "Insert an item into the control before the item at the ``pos`` index,
optionally associating some data object with the item.", "");
        int Insert(const wxString& item, /*unsigned*/ int pos, PyObject* clientData=NULL) {
            if (clientData) {
                wxPyClientData* data = new wxPyClientData(clientData);
                return self->Insert(item, pos, data);
            } else
                return self->Insert(item, pos);
        }
    }

    
    DocDeclAStrName(
        int , Insert(const wxArrayString& items, /*unsigned*/ int pos),
        "InsertItems(self, List strings, int pos) --> int",
        "Inserts several items at once into the control.  Returns the index of
the last item inserted.", "",
        InsertItems);

    
    DocDeclAStr(
        void , Set(const wxArrayString& items),
        "Set(self, List strings)",
        "Replace all the items in the control", "");
    
    
    
    DocDeclStr(
        virtual void , Clear(),
        "Removes all items from the control.", "");
    
    DocDeclStr(
        virtual void , Delete(/*unsigned*/ int n),
        "Deletes the item at the zero-based index 'n' from the control. Note
that it is an error (signalled by a `wx.PyAssertionError` exception if
enabled) to remove an item with the index negative or greater or equal
than the number of items in the control.", "");
    


     %extend {
        DocStr(GetClientData,
               "Returns the client data associated with the given item, (if any.)", "");
        PyObject* GetClientData(/*unsigned*/ int n) {
            wxPyClientData* data = (wxPyClientData*)self->GetClientObject(n);
            if (data) {
                Py_INCREF(data->m_obj);
                return data->m_obj;
            } else {
                Py_INCREF(Py_None);
                return Py_None;
            }
        }

        DocStr(SetClientData,
               "Associate the given client data with the item at position n.", "");
        void SetClientData(/*unsigned*/ int n, PyObject* clientData) {
            wxPyClientData* data = new wxPyClientData(clientData);
            self->SetClientObject(n, data);
        }
    }


    DocDeclStr(
        bool , HasClientData() const,
        "", "");
    
    
    
    DocDeclStr(
        virtual /*unsigned*/ int , GetCount() const,
        "Returns the number of items in the control.", "");
    
    DocDeclStr(
        bool , IsEmpty() const,
        "Returns True if the control is empty or False if it has some items.", "");
    
    DocDeclStr(
        virtual wxString , GetString(/*unsigned*/ int n) const,
        "Returns the label of the item with the given index.", "");
    
    DocDeclStr(
        wxArrayString , GetStrings() const,
        "", "");

    
    DocDeclStr(
        bool , IsSorted() const,
        "", "");
    
    DocDeclStr(
        virtual void , SetString(/*unsigned*/ int n, const wxString& s),
        "Sets the label for the given item.", "");
    
    DocDeclStr(
        virtual int , FindString(const wxString& s) const,
        "Finds an item whose label matches the given string.  Returns the
zero-based position of the item, or ``wx.NOT_FOUND`` if the string was not
found.", "");
    

    DocDeclStr(
        virtual void , SetSelection(int n),
        "Sets the item at index 'n' to be the selected item.", "");
    
    DocDeclStr(
        virtual int , GetSelection() const,
        "Returns the index of the selected item or ``wx.NOT_FOUND`` if no item
is selected.", "");
    

    bool SetStringSelection(const wxString& s);

    DocDeclStr(
        wxString , GetStringSelection() const,
        "Returns the label of the selected item or an empty string if no item
is selected.", "");
    

    DocDeclStr(
        void , Select(int n),
        "This is the same as `SetSelection` and exists only because it is
slightly more natural for controls which support multiple selection.", "");
    

    %pythoncode {
        def GetItems(self):
            """Return a list of the strings in the control"""
            return [self.GetString(i) for i in xrange(self.GetCount())]
            
        def SetItems(self, items):
            """Clear and set the strings in the control from a list"""
            self.Clear()
            for i in items:
                self.Append(i)        
    }
    
    %property(Count, GetCount, doc="See `GetCount`");
    %property(Items, GetItems, SetItems, doc="See `GetItems` and `SetItems`");
    %property(Selection, GetSelection, SetSelection, doc="See `GetSelection` and `SetSelection`");
    %property(StringSelection, GetStringSelection, SetStringSelection, doc="See `GetStringSelection` and `SetStringSelection`");
    %property(Strings, GetStrings, doc="See `GetStrings`");
    
};


//---------------------------------------------------------------------------
%newgroup;

DocStr(wxControlWithItems,
"wx.ControlWithItems combines the ``wx.ItemContainer`` class with the
wx.Control class, and is used for the base class of various controls
that have items.", "");

class wxControlWithItems : public wxControl, public wxItemContainer
{
public:
};

//---------------------------------------------------------------------------
%newgroup;


class wxTextEntry
{
public:
    // wxTextEntry() { m_eventsBlock = 0; }  ****  It's an ABC, can't instantiate
    virtual ~wxTextEntry();


    DocDeclStr(
        virtual void , SetValue(const wxString& value),
        "Set the value in the text entry field.  Generates a text change event.", "");
    
    DocDeclStr(
        virtual void , ChangeValue(const wxString& value),
        "Set the value in the text entry field.  Generates a text change event.", "");
    

    DocDeclStr(
        virtual void , WriteText(const wxString& text),
        "Insert text at the current insertion point in the text field,
replacing any text that is currently selected.", "");
    
    DocDeclStr(
        virtual void , AppendText(const wxString& text),
        "Add text to the end of the text field, without removing any existing
text.  Will reset the selection if any.", "");
    

    DocDeclStr(
        virtual wxString , GetValue(),
        "Returns the current value in the text field.", "");
    
    DocDeclStr(
        virtual wxString , GetRange(long from, long to) const,
        "Returns a subset of the value in the text field.", "");

    // Just for backwards compatibility
    %pythoncode { GetString = wx._deprecated(GetRange, "Use `GetRange` instead.") }
    
    DocDeclStr(
        bool , IsEmpty() const,
        "Returns True if the value in the text field is empty.", "");
    


    DocDeclStr(
        virtual void , Replace(long from, long to, const wxString& value),
        "Replaces the text between two positions with the given text.", "");
    
    DocDeclStr(
        virtual void , Remove(long from, long to),
        "Removes the text between two positions in the text field", "");
    
    DocDeclStr(
        virtual void , Clear(),
        "Clear all text from the text field", "");
    


    // clipboard operations
    // --------------------

    DocDeclStr(
        virtual void , Copy(),
        "Copies the selected text to the clipboard.", "");
    
    DocDeclStr(
        virtual void , Cut(),
        "Copies the selected text to the clipboard and removes the selection.", "");
    
    DocDeclStr(
        virtual void , Paste(),
        "Pastes text from the clipboard to the text field.", "");
    

    DocDeclStr(
        virtual bool , CanCopy() const,
        "Returns True if the text field has a text selection to copy to the
clipboard.", "");
    
    DocDeclStr(
        virtual bool , CanCut() const,
        "Returns True if the text field is editable and there is a text
selection to copy to the clipboard.", "");
    
    DocDeclStr(
        virtual bool , CanPaste() const,
        "Returns True if the text field is editable and there is text on the
clipboard that can be pasted into the text field.", "");
    

    // undo/redo
    // ---------

    DocDeclStr(
        virtual void , Undo(),
        "Undoes the last edit in the text field", "");
    
    DocDeclStr(
        virtual void , Redo(),
        "Redoes the last undo in the text field", "");
    

    DocDeclStr(
        virtual bool , CanUndo() const,
        "Returns True if the text field is editable and the last edit can be
undone.", "");
    
    DocDeclStr(
        virtual bool , CanRedo() const,
        "Returns True if the text field is editable and the last undo can be
redone.", "");
    



    DocDeclStr(
        virtual void , SetInsertionPoint(long pos),
        "Sets the insertion point in the combobox text field.", "");
    
    DocDeclStr(
        virtual long , GetInsertionPoint() const,
        "Returns the insertion point for the combobox's text field.", "");
    

    DocDeclStr(
        virtual void , SetInsertionPointEnd(),
        "Move the insertion point to the end of the current value.", "");
    

    DocDeclStr(
        virtual long , GetLastPosition() const,
        "Returns the last position in the combobox text field.", "");



    DocDeclStr(
        virtual void , SetSelection(long from, long to),
        "Selects the text starting at the first position up to (but not
including) the character at the last position.  If both parameters are
-1 then all text in the control is selected.", "");
    
    DocDeclStr(
        virtual void , SelectAll(),
        "Select all text in the text field.", "");
    
    DocDeclStr(
        bool , HasSelection() const,
        "Returns True if there is a non-empty selection in the text field.", "");
    
    DocDeclStr(
        virtual wxString , GetStringSelection() const,
        "Returns the selected text.", "");
    

    DocDeclAStr(
        virtual void, GetSelection(long* OUTPUT, long* OUTPUT) const,
        "GetSelection() -> (from, to)",
        "If the return values from and to are the same, there is no selection.", "");
    

    // auto-completion
    // ---------------

    // these functions allow to auto-complete the text already entered into the
    // control using either the given fixed list of strings, the paths from the
    // file system or, in the future, an arbitrary user-defined completer
    //
    // they all return true if completion was enabled or false on error (most
    // commonly meaning that this functionality is not available under the
    // current platform)

    virtual bool AutoComplete(const wxArrayString& choices);
    virtual bool AutoCompleteFileNames();


    // status
    // ------

    virtual bool IsEditable() const;
    virtual void SetEditable(bool editable);


    DocDeclStr(
        virtual void , SetMaxLength(long len),
        "Set the max number of characters which may be entered in a single line
text control.", "");
    


    %property(InsertionPoint, GetInsertionPoint, SetInsertionPoint);
    %property(LastPosition, GetLastPosition);
    %property(Value, GetValue, SetValue);
    
};


    
DocStr(wxTextAreaBase,
"multiline text control specific methods","");           

class wxTextAreaBase
{
public:
//    wxTextAreaBase();  // ****   An ABC
    virtual ~wxTextAreaBase() ;

    // lines access
    // ------------

    virtual int GetLineLength(long lineNo) const;
    virtual wxString GetLineText(long lineNo) const;
    virtual int GetNumberOfLines() const;


    // file IO
    // -------

    bool LoadFile(const wxString& file, int fileType = wxTEXT_TYPE_ANY);
    bool SaveFile(const wxString& file = wxEmptyString,
                  int fileType = wxTEXT_TYPE_ANY);

    // dirty flag handling
    // -------------------

    virtual bool IsModified() const;
    virtual void MarkDirty();
    virtual void DiscardEdits();
    void SetModified(bool modified);


    // styles handling
    // ---------------

    // text control under some platforms supports the text styles: these
    // methods allow to apply the given text style to the given selection or to
    // set/get the style which will be used for all appended text
    virtual bool SetStyle(long start, long end, const wxTextAttr& style);
    virtual bool GetStyle(long position, wxTextAttr& style);
    virtual bool SetDefaultStyle(const wxTextAttr& style);
    virtual const wxTextAttr& GetDefaultStyle() const;


    // coordinates translation
    // -----------------------

    // translate between the position (which is just an index in the text ctrl
    // considering all its contents as a single strings) and (x, y) coordinates
    // which represent column and line.
    virtual long XYToPosition(long x, long y) const;
    DocDeclA(
        virtual /*bool*/ void, PositionToXY(long pos, long *OUTPUT, long *OUTPUT) const,
        "PositionToXY(long pos) -> (x, y)");

    virtual void ShowPosition(long pos);

    DocDeclAStr(
        virtual wxTextCtrlHitTestResult, HitTest(const wxPoint& pt,
                                                 long* OUTPUT, long* OUTPUT) const,
        "HitTest(Point pt) -> (result, col, row)",
        "Find the row, col coresponding to the character at the point given in
pixels. NB: pt is in device coords but is not adjusted for the client
area origin nor scrolling.", "");


    DocDeclAStrName(
        virtual wxTextCtrlHitTestResult , HitTest(const wxPoint& pt, long *OUTPUT) const,
        "HitTestPos(Point pt) -> (result, position)",
        "Find the character position in the text coresponding to the point
given in pixels. NB: pt is in device coords but is not adjusted for
the client area origin nor scrolling. ", "",
        HitTestPos);


    %property(DefaultStyle, GetDefaultStyle, SetDefaultStyle);
    %property(NumberOfLines, GetNumberOfLines);
};

    
DocStr(wxTextCtrlIface,
"This class defines the wx.TextCtrl interface", "");
class  wxTextCtrlIface : public wxTextAreaBase,
                         public wxTextEntry
{
public:
    // wxTextCtrlIface();   ****  An ABC

};

    
//---------------------------------------------------------------------------

