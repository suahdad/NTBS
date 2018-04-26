VERSION 5.00
Begin VB.UserControl prvusrctrlDate 
   ClientHeight    =   690
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   2535
   BeginProperty Font 
      Name            =   "IBM3270 - 1254"
      Size            =   15
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   ScaleHeight     =   690
   ScaleWidth      =   2535
   ToolboxBitmap   =   "prvusrctrlDate.ctx":0000
   Begin VB.TextBox Text1 
      BackColor       =   &H8000000F&
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   1815
   End
End
Attribute VB_Name = "prvusrctrlDate"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Date Validation
'FLR March 3, 1999

Option Explicit
Dim blnBackspace As Boolean
Dim PreviousBackColor As Variant

'Event Declarations:
Event Change() 'MappingInfo=Text1,Text1,-1,Change
Attribute Change.VB_Description = "Occurs when the contents of a control have changed."
Event Click() 'MappingInfo=Text1,Text1,-1,Click
Attribute Click.VB_Description = "Occurs when the user presses and then releases a mouse button over an object."
Event DblClick() 'MappingInfo=Text1,Text1,-1,DblClick
Attribute DblClick.VB_Description = "Occurs when the user presses and releases a mouse button and then presses and releases it again over an object."
Event KeyDown(KeyCode As Integer, Shift As Integer) 'MappingInfo=Text1,Text1,-1,KeyDown
Attribute KeyDown.VB_Description = "Occurs when the user presses a key while an object has the focus."
Event KeyPress(KeyAscii As Integer) 'MappingInfo=Text1,Text1,-1,KeyPress
Attribute KeyPress.VB_Description = "Occurs when the user presses and releases an ANSI key."
Event KeyUp(KeyCode As Integer, Shift As Integer) 'MappingInfo=Text1,Text1,-1,KeyUp
Attribute KeyUp.VB_Description = "Occurs when the user releases a key while an object has the focus."
Event MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single) 'MappingInfo=Text1,Text1,-1,MouseDown
Attribute MouseDown.VB_Description = "Occurs when the user presses the mouse button while an object has the focus."
Event MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single) 'MappingInfo=Text1,Text1,-1,MouseMove
Attribute MouseMove.VB_Description = "Occurs when the user moves the mouse."
Event MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single) 'MappingInfo=Text1,Text1,-1,MouseUp
Attribute MouseUp.VB_Description = "Occurs when the user releases the mouse button while an object has the focus."

'Default Property Values:
Const m_def_DateCaption = ""
Const m_def_Month = ""
Const m_def_Day = 0
Const m_def_Year = 0
Const m_def_First = 0
Const m_def_Last = 0
'Property Variables:
Dim m_DateCaption As String
Dim m_Month As String
Dim m_Day As Long
Dim m_Year As Long
Dim m_First As Boolean
Dim m_Last As Boolean
Private Sub Text1_Change()

    Dim mnthval As Integer

    RaiseEvent Change
    
    If Len(Text1.Text) = 10 Then
        If Not IsDate(Text1.Text) Then
            MsgBox "Invalid Date, Please re-enter", vbExclamation + vbOKOnly, "Date Error"
            Text1.SelStart = 0
            Text1.SelLength = 10
            Text1.SetFocus
            Exit Sub
        End If
    End If
'**********
    
' ** Month
    If IsNumeric(Mid(Trim(Text1.Text), 6, 2)) Then
        mnthval = Val(Mid(Trim(Text1.Text), 6, 2))
        Select Case mnthval
            Case 1
                m_Month = "January"
            Case 2
                m_Month = "February"
            Case 3
                m_Month = "March"
            Case 4
                m_Month = "April"
            Case 5
                m_Month = "May"
            Case 6
                m_Month = "June"
            Case 7
                m_Month = "July"
            Case 8
                m_Month = "August"
            Case 9
                m_Month = "September"
            Case 10
                m_Month = "October"
            Case 11
                m_Month = "November"
            Case 12
                m_Month = "December"
            Case Else
                mnthval = 0
                m_Month = ""
        End Select
    
    Else
        mnthval = 0
        m_Month = ""
    End If
    
    ' ** Day
    If IsNumeric(Mid(Trim(Text1.Text), 9, 2)) Then
        m_Day = Val(Mid(Trim(Text1.Text), 9, 2))
    Else
        m_Day = 0
    End If
    
    If Len(m_Month) <> 0 Then
        If m_Day <> 0 And m_Day < 32 Then
            m_DateCaption = Trim(m_Month) & " " & Trim(Str(m_Day)) & ", " & Trim(m_Year)
        Else
            m_DateCaption = Trim(m_Month) & ", " & Trim(m_Year)
        End If
    Else
        m_DateCaption = ""
    End If
'**********
End Sub

Private Sub Text1_GotFocus()
    Text1.BackColor = &HFFFFFF
    Text1.SelStart = 0
    Text1.SelLength = Len(Text1.Text)
End Sub
Private Sub Text1_KeyPress(KeyAscii As Integer)
    RaiseEvent KeyPress(KeyAscii)
    If KeyAscii <> 8 Then
        If KeyAscii > 47 And KeyAscii < 58 Then
            If Text1.SelLength = 10 And (KeyAscii >= 48 And KeyAscii <= 57) Then
                Exit Sub
            End If
            If (Len(Text1.Text) = 10) Or (Not KeyAscii >= 48 And Not KeyAscii <= 57) Then
                KeyAscii = 0
                Beep
            End If
            Text1.SelStart = Len(Trim(Text1.Text))
        Else
            If KeyAscii = 13 Then
                SendKeys "{Tab}", True
            Else
                If KeyAscii = 27 Then
                    SendKeys "+{Tab}", True
                Else
                    Beep
                    KeyAscii = 0
                End If
            End If
        End If
    End If
End Sub
Private Sub Text1_LostFocus()
    If Len(Trim(Text1.Text)) <> 0 Then
        If Not IsDate(Text1.Text) Then
            MsgBox Trim(Text1.Text) & " is an Invalid Date, Please re-enter ", vbExclamation, "Date Error"
            Text1.SelStart = 0
            Text1.SelLength = Len(Text1.Text)
            Text1.SetFocus
        Else
            Text1.Text = Format(Text1.Text, "yyyy-mm-dd")
            Text1.BackColor = &H8000000F
        End If
    Else
        Text1.Text = Format(Text1.Text, "yyyy-mm-dd")
        Text1.BackColor = &H8000000F
    End If
End Sub
Private Sub UserControl_Initialize()
Text1.Height = UserControl.Height
Text1.Width = UserControl.Width
blnBackspace = False
End Sub
Private Sub UserControl_Resize()
Text1.Height = UserControl.Height
Text1.Width = UserControl.Width
End Sub
'MappingInfo=Text1,Text1,-1,BackColor
Public Property Get BackColor() As OLE_COLOR
Attribute BackColor.VB_Description = "Returns/sets the background color used to display text and graphics in an object."
    BackColor = Text1.BackColor
End Property

Public Property Let BackColor(ByVal New_BackColor As OLE_COLOR)
    Text1.BackColor() = New_BackColor
    PropertyChanged "BackColor"
End Property
'MappingInfo=Text1,Text1,-1,ForeColor
Public Property Get ForeColor() As OLE_COLOR
Attribute ForeColor.VB_Description = "Returns/sets the foreground color used to display text and graphics in an object."
    ForeColor = Text1.ForeColor
End Property
Public Property Let ForeColor(ByVal New_ForeColor As OLE_COLOR)
    Text1.ForeColor() = New_ForeColor
    PropertyChanged "ForeColor"
End Property
'MappingInfo=Text1,Text1,-1,Enabled
Public Property Get Enabled() As Boolean
Attribute Enabled.VB_Description = "Returns/sets a value that determines whether an object can respond to user-generated events."
    Enabled = Text1.Enabled
End Property

Public Property Let Enabled(ByVal New_Enabled As Boolean)
    Text1.Enabled() = New_Enabled
    PropertyChanged "Enabled"
End Property
'MappingInfo=Text1,Text1,-1,Font
Public Property Get Font() As Font
Attribute Font.VB_Description = "Returns a Font object."
Attribute Font.VB_UserMemId = -512
    Set Font = Text1.Font
End Property
Public Property Set Font(ByVal New_Font As Font)
    Set Text1.Font = New_Font
    PropertyChanged "Font"
End Property
'MappingInfo=Text1,Text1,-1,BorderStyle
Public Property Get BorderStyle() As Integer
Attribute BorderStyle.VB_Description = "Returns/sets the border style for an object."
    BorderStyle = Text1.BorderStyle
End Property
Public Property Let BorderStyle(ByVal New_BorderStyle As Integer)
    Text1.BorderStyle() = New_BorderStyle
    PropertyChanged "BorderStyle"
End Property
'MappingInfo=Text1,Text1,-1,Refresh
Public Sub Refresh()
Attribute Refresh.VB_Description = "Forces a complete repaint of a object."
    Text1.Refresh
End Sub
Private Sub Text1_Click()
    RaiseEvent Click
End Sub
Private Sub Text1_DblClick()
    RaiseEvent DblClick
End Sub
Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)
    
    Dim mnthval As Integer
    RaiseEvent KeyDown(KeyCode, Shift)
    If KeyCode <> 8 Then
        If Len(Trim(Text1.Text)) = 4 Then
            Text1.Text = Trim(Text1.Text) & "-"
            Text1.SelStart = 5
            m_Year = Mid(Trim(Text1.Text), 1, 4)
        End If
        If Len(Trim(Text1.Text)) = 7 Then
            Text1.Text = Trim(Text1.Text) & "-"
            Text1.SelStart = 8
        End If
        
        If IsNumeric(Mid(Trim(Text1.Text), 6, 2)) Then
            mnthval = Val(Mid(Trim(Text1.Text), 6, 2))
            Select Case mnthval
                Case 1
                    m_Month = "January"
                Case 2
                    m_Month = "February"
                Case 3
                    m_Month = "March"
                Case 4
                    m_Month = "April"
                Case 5
                    m_Month = "May"
                Case 6
                    m_Month = "June"
                Case 7
                    m_Month = "July"
                Case 8
                    m_Month = "August"
                Case 9
                    m_Month = "September"
                Case 10
                    m_Month = "October"
                Case 11
                    m_Month = "November"
                Case 12
                    m_Month = "December"
                Case Else
                    mnthval = 0
                    m_Month = ""
            End Select
        Else
            mnthval = 0
            m_Month = ""
        End If
        If IsNumeric(Mid(Trim(Text1.Text), 9, 2)) Then
            m_Day = Val(Mid(Trim(Text1.Text), 9, 2))
        Else
            m_Day = 0
        End If
        If Len(m_Month) <> 0 Then
            If m_Day <> 0 And m_Day < 32 Then
                m_DateCaption = Trim(m_Month) & " " & Trim(Str(m_Day)) & ", " & Trim(m_Year)
            Else
                m_DateCaption = Trim(m_Month) & ", " & Trim(m_Year)
            End If
        Else
            m_DateCaption = ""
        End If
    End If
 End Sub

Private Sub Text1_KeyUp(KeyCode As Integer, Shift As Integer)
    RaiseEvent KeyUp(KeyCode, Shift)
End Sub

Private Sub Text1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    RaiseEvent MouseDown(Button, Shift, X, Y)
End Sub

Private Sub Text1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    RaiseEvent MouseMove(Button, Shift, X, Y)
End Sub

Private Sub Text1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    RaiseEvent MouseUp(Button, Shift, X, Y)
End Sub
'MappingInfo=Text1,Text1,-1,Alignment
Public Property Get Alignment() As Integer
Attribute Alignment.VB_Description = "Returns/sets the alignment of a CheckBox or OptionButton, or a control's text."
    Alignment = Text1.Alignment
End Property
Public Property Let Alignment(ByVal New_Alignment As Integer)
    Text1.Alignment() = New_Alignment
    PropertyChanged "Alignment"
End Property
'MappingInfo=Text1,Text1,-1,Text
Public Property Get Text() As String
Attribute Text.VB_Description = "Returns/sets the text contained in the control."
    Text = Text1.Text
End Property
Public Property Let Text(ByVal New_Text As String)
    Text1.Text() = New_Text
    PropertyChanged "Text"
End Property
'Load property values from storage
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)

    Text1.Enabled = PropBag.ReadProperty("Enabled", True)
    Set Text1.Font = PropBag.ReadProperty("Font", Ambient.Font)
    Text1.BorderStyle = PropBag.ReadProperty("BorderStyle", 1)
    Text1.Alignment = PropBag.ReadProperty("Alignment", 0)
    Text1.Text = PropBag.ReadProperty("Text", "")
    Text1.MaxLength = PropBag.ReadProperty("MaxLength", 0)
    Text1.SelLength = PropBag.ReadProperty("SelLength", 0)
    Text1.SelStart = PropBag.ReadProperty("SelStart", 0)
    m_First = PropBag.ReadProperty("First", m_def_First)
    m_Last = PropBag.ReadProperty("Last", m_def_Last)
    m_Month = PropBag.ReadProperty("Month", m_def_Month)
    m_Day = PropBag.ReadProperty("Day", m_def_Day)
    m_Year = PropBag.ReadProperty("Year", m_def_Year)
    m_DateCaption = PropBag.ReadProperty("DateCaption", m_def_DateCaption)
End Sub
'Write property values to storage
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
    Call PropBag.WriteProperty("Enabled", Text1.Enabled, True)
    Call PropBag.WriteProperty("Font", Text1.Font, Ambient.Font)
    Call PropBag.WriteProperty("BorderStyle", Text1.BorderStyle, 1)
    Call PropBag.WriteProperty("Alignment", Text1.Alignment, 0)
    Call PropBag.WriteProperty("Text", Text1.Text, "")
    Call PropBag.WriteProperty("MaxLength", Text1.MaxLength, 0)
    Call PropBag.WriteProperty("SelLength", Text1.SelLength, 0)
    Call PropBag.WriteProperty("SelStart", Text1.SelStart, 0)
    Call PropBag.WriteProperty("First", m_First, m_def_First)
    Call PropBag.WriteProperty("Last", m_Last, m_def_Last)
    Call PropBag.WriteProperty("Month", m_Month, m_def_Month)
    Call PropBag.WriteProperty("Day", m_Day, m_def_Day)
    Call PropBag.WriteProperty("Year", m_Year, m_def_Year)
    Call PropBag.WriteProperty("DateCaption", m_DateCaption, m_def_DateCaption)
End Sub

Public Property Get MaxLength() As Long
Attribute MaxLength.VB_Description = "Returns/sets the maximum number of characters that can be entered in a control."
    MaxLength = Text1.MaxLength
End Property
Public Property Let MaxLength(ByVal New_MaxLength As Long)
    Text1.MaxLength() = New_MaxLength
    PropertyChanged "MaxLength"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=Text1,Text1,-1,MultiLine
Public Property Get MultiLine() As Boolean
Attribute MultiLine.VB_Description = "Returns/sets a value that determines whether a control can accept multiple lines of text."
    MultiLine = Text1.MultiLine
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=Text1,Text1,-1,SelLength
Public Property Get SelLength() As Long
Attribute SelLength.VB_Description = "Returns/sets the number of characters selected."
    SelLength = Text1.SelLength
End Property

Public Property Let SelLength(ByVal New_SelLength As Long)
    Text1.SelLength() = New_SelLength
    PropertyChanged "SelLength"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=Text1,Text1,-1,SelStart
Public Property Get SelStart() As Long
Attribute SelStart.VB_Description = "Returns/sets the starting point of text selected."
    SelStart = Text1.SelStart
End Property

Public Property Let SelStart(ByVal New_SelStart As Long)
    Text1.SelStart() = New_SelStart
    PropertyChanged "SelStart"
End Property

Private Sub UserControl_KeyDown(KeyCode As Integer, Shift As Integer)
Select Case KeyCode
    Case 40
        If m_Last = 0 Then
            SendKeys "{Tab}", True
        End If
    Case 38
        If m_First = 0 Then
            SendKeys "+{Tab}", True
        End If
End Select
End Sub
'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MemberInfo=0,0,0,0
Public Property Get First() As Boolean
    First = m_First
End Property

Public Property Let First(ByVal New_First As Boolean)
    m_First = New_First
    PropertyChanged "First"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MemberInfo=0,0,0,0
Public Property Get Last() As Boolean
    Last = m_Last
End Property

Public Property Let Last(ByVal New_Last As Boolean)
    m_Last = New_Last
    PropertyChanged "Last"
End Property

'Initialize Properties for User Control
Private Sub UserControl_InitProperties()
    m_First = m_def_First
    m_Last = m_def_Last
    m_Month = m_def_Month
    m_Day = m_def_Day
    m_Year = m_def_Year
    m_DateCaption = m_def_DateCaption
End Sub

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MemberInfo=13,0,0,January
Public Property Get Month() As String
    Month = m_Month
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MemberInfo=8,0,0,0
Public Property Get Day() As Long
    Day = m_Day
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MemberInfo=8,0,0,1999
Public Property Get Year() As Long
    Year = m_Year
End Property
'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MemberInfo=13,0,0,
Public Property Get DateCaption() As String

Dim mnthval As Integer
' ** Month
    If IsNumeric(Mid(Trim(Text1.Text), 6, 2)) Then
        mnthval = Val(Mid(Trim(Text1.Text), 6, 2))
        Select Case mnthval
            Case 1
                m_Month = "January"
            Case 2
                m_Month = "February"
            Case 3
                m_Month = "March"
            Case 4
                m_Month = "April"
            Case 5
                m_Month = "May"
            Case 6
                m_Month = "June"
            Case 7
                m_Month = "July"
            Case 8
                m_Month = "August"
            Case 9
                m_Month = "September"
            Case 10
                m_Month = "October"
            Case 11
                m_Month = "November"
            Case 12
                m_Month = "December"
            Case Else
                mnthval = 0
                m_Month = ""
        End Select
    
    Else
        mnthval = 0
        m_Month = ""
    End If
    
    ' ** Day
    If IsNumeric(Mid(Trim(Text1.Text), 9, 2)) Then
        m_Day = Val(Mid(Trim(Text1.Text), 9, 2))
    Else
        m_Day = 0
    End If
    
    If Len(m_Month) <> 0 Then
        If m_Day <> 0 And m_Day < 32 Then
            m_DateCaption = Trim(m_Month) & " " & Trim(Str(m_Day)) & ", " & Trim(m_Year)
        Else
            m_DateCaption = Trim(m_Month) & ", " & Trim(m_Year)
        End If
    Else
        m_DateCaption = ""
    End If
'**********



    DateCaption = m_DateCaption
End Property

