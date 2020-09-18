unit guiunit;

interface

uses Windows,Messages,SysUtils,Variants,Classes,Graphics,
     Controls,Forms,Dialogs,ImgList,Menus,ExtCtrls,
     StdCtrls,
     clipbrd,
     Types, Vcl.Buttons;//dcc32 Hinweis;

type
  TguiForm = class(TForm)
    backpanel: TPanel;
    banner: TPanel;
    logoimage: TImage;
    iopanel: TPanel;
    toolpanel: TPanel;
    iopaintbox: TPaintBox;
    iosplitter: TSplitter;
    iomemo: TMemo;
    opendialog: TOpenDialog;
    savedialog: TSaveDialog;
    fontdialog: TFontDialog;
    finddialog: TFindDialog;
    guitimer: TTimer;
    popupmenu: TPopupMenu;
    mdiImageList: TImageList;
    getmemo: TMemo;
    reloadbutton: TSpeedButton;
    doitbutton: TSpeedButton;
    dumpbutton: TSpeedButton;
    Bevel1: TBevel;
    cutbutton: TSpeedButton;
    copybutton: TSpeedButton;
    pastebutton: TSpeedButton;
    delbutton: TSpeedButton;
    Bevel2: TBevel;
    favorbutton: TSpeedButton;
    helpbutton: TSpeedButton;
    doititem: TMenuItem;
    dumpitem: TMenuItem;
    stopactitem: TMenuItem;
    N1item: TMenuItem;
    undoitem: TMenuItem;
    cutitem: TMenuItem;
    copyitem: TMenuItem;
    pasteitem: TMenuItem;
    delitem: TMenuItem;
    selallitem: TMenuItem;
    N2item: TMenuItem;
    openitem: TMenuItem;
    reloaditem: TMenuItem;
    saveitem: TMenuItem;
    inititem: TMenuItem;
    finditem: TMenuItem;
    fontitem: TMenuItem;
    quickitem: TMenuItem;
    docuitem: TMenuItem;
    helpitem: TMenuItem;
    websiteitem: TMenuItem;
    favoritem: TMenuItem;
    testitem: TMenuItem;
    toolitem: TMenuItem;
    N3item: TMenuItem;
    quititem: TMenuItem;
    procedure iomemoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure iomemoKeyPress(Sender: TObject; var Key: Char);
    procedure logoimageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure logoimageMouseEnter(Sender: TObject);
    procedure logoimageMouseLeave(Sender: TObject);
    procedure popupmenuPopup(Sender: TObject);
    procedure doititemClick(Sender: TObject);
    procedure dumpitemClick(Sender: TObject);
    procedure stopactitemClick(Sender: TObject);
    procedure undoitemClick(Sender: TObject);
    procedure cutitemClick(Sender: TObject);
    procedure copyitemClick(Sender: TObject);
    procedure pasteitemClick(Sender: TObject);
    procedure delitemClick(Sender: TObject);
    procedure selallitemClick(Sender: TObject);
    procedure openitemClick(Sender: TObject);
    procedure reloaditemClick(Sender: TObject);
    procedure saveitemClick(Sender: TObject);
    procedure inititemClick(Sender: TObject);
    procedure finditemClick(Sender: TObject);
    procedure fontitemClick(Sender: TObject);
    procedure quickitemClick(Sender: TObject);
    procedure docuitemClick(Sender: TObject);
    procedure helpitemClick(Sender: TObject);
    procedure websiteitemClick(Sender: TObject);
    procedure favoritemClick(Sender: TObject);
    procedure testitemClick(Sender: TObject);
    procedure toolitemClick(Sender: TObject);
    procedure quititemClick(Sender: TObject);
    procedure iopaintboxPaint(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure FormResize(Sender: TObject);
    procedure iomemoDblClick(Sender: TObject);
    procedure FormIdle(Sender: TObject; var Done: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var guiForm: TguiForm;

implementation

{$R *.dfm}

uses serveunit, errorunit, initunit, typeunit;

const pixelinpopupmenu = 12;//14;//in servunit;//0=linux?
      documents: es = 'documents\';
      corefiledef: es = 'prelude.txt';
      memofiledef: es = 'Document.txt';
      infofiledef: es = 'quickinfo.rtf';//bitte .pdf
      docufiledef: es = 'documentation.rtf';//bitte .pdf
      helpfiledef: es = 'reference.rtf';//bitte .pdf
      website_url: es = 'https://fp-system.github.io';//?
      testfiledef: es = 'test.txt';
      redefine: es = 'redefine';
      filenotfound: es = 'File not found.';
      noparamfilename: es ='No parameter file.';//param?;

var formcaption,exefilename,corefilename,paramfilename,memofilename: ustring;
    intxtfile: tstringlist = nil;//oder getmemo?;

//errorquit (!?)
procedure errordialog(s: ustring);
begin beep;
      errorForm.re_showerror(s)
end;

// ------- FP scriptor -------

procedure initgui;
var mc,ms: int64; txt: ustring;
begin with guiForm do
      try toolpanel.visible:=toolitem.checked;
          iopaintbox.height:=0;
          //iosplitter.height:=guiformheightsub;  //splitter geht nicht
          banner.color:=rgb(240,240,240);
          toolpanel.color:=rgb(240,240,240);
          iosplitter.color:=rgb(240,240,240);
          iomemo.text:=prompt;
          iomemo.selstart:=length(iomemo.text);
          iomemo.setfocus;
          formcaption:=caption;
          exefilename:=paramstr(0);
          corefilename:=extractslashpath(exefilename)+corefiledef;
          paramfilename:=paramstr(1);
          memofilename:=extractslashpath(exefilename)+memofiledef;
          mc:=servemaxcell;
          ms:=mc;//provi;
          initserve(mc,ms,iomemo,iopaintbox,toolpanel,guiForm);//mp?
          redef:=false;
          Application.OnIdle:=FormIdle;   //hier??? oder in onshow;
          //
          intxtfile:=tstringlist.create;
          setservecorepath(extractslashpath(corefilename));
          if fileexists(corefilename) then begin
             intxtfile.loadfromfile(corefilename);
             txt:=intxtfile.text;
             intxtfile.clear;
             tellserve(txt);
             caption:=' '+extractslashname(corefilename)+' - '+formcaption
          end;
          if (paramfilename<>'') then if fileexists(paramfilename) then begin
             setserveuserpath(extractslashpath(paramfilename));
             intxtfile.loadfromfile(paramfilename);
             txt:=intxtfile.text;
             intxtfile.clear;
             tellserve(txt);
             caption:=' '+extractslashname(paramfilename)+' - '+formcaption
          end;//else raise...;
          //
      except on e: exception do begin
                // quelltext ausgeben ...
                errordialog(e.message)
             end//
      end//
end;

procedure finalgui;
begin intxtfile.free;
      finalserve
end;

//redefine in den titel setzen (?)

procedure doit;
var txt: ustring;//?
begin with guiForm do begin
           if (iomemo.sellength>0) then txt:=iomemo.seltext
           else txt:=selectline(iomemo.text,iomemo.selstart);
           tellserve(txt);//mjform.iomemo.lines.append(prompt);
           redef:=true;
           caption:=' '+redefine+' - '+formcaption// (?)
           //adpanel.caption:='';
      end
end;

// ----- Fundamental Loop -----

procedure TguiForm.FormIdle(Sender: TObject; var Done: Boolean);
//FormIdle: servreaction ,Fundamental Loop ,(Event-Loop)
begin try servereact; Done:=serveidledone;
          if servequit then guiForm.close;//??? im komplexen zusammenspiel?...
      except //quelltexte ausgeben?
             on e: exception do begin
                {if onquit then mjform.close
                else }errordialog(e.message)
                //
             end//
      end// fios mit idle//
end;

// ----- service functions -----

procedure TguiForm.iomemoChange(Sender: TObject);
begin//
end;
procedure TguiForm.FormCreate(Sender: TObject);
begin//
end;

procedure TguiForm.FormShow(Sender: TObject);
begin initgui//in FormCreate?
end;

procedure TguiForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin finalgui
end;

procedure TguiForm.iomemoKeyPress(Sender: TObject; var Key: Char);
begin if (key=#13) then begin doit;
                              key:=#27;
                              //exit
                        end
end;

procedure TguiForm.logoimageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
var t: tpoint;
begin t:=logoimage.clienttoscreen(point(x,y));
      popupmenu.Popup(t.x-pixelinpopupmenu,t.y{-pixelinpopupmenu})
end;

procedure TguiForm.logoimageMouseEnter(Sender: TObject);
begin banner.color:=rgb(255,170,0);//=origin//,180,//rgb(248,185,22)//rgb(255,202,20)
end;//mint:=rgb(128,177,122);//lightbend:=rgb(253,153,41);

procedure TguiForm.logoimageMouseLeave(Sender: TObject);
begin banner.color:=rgb(240,240,240)
end;

procedure TguiForm.popupmenuPopup(Sender: TObject);
begin undoitem.enabled:=iomemo.canundo;
      cutitem.enabled :=(iomemo.sellength>0);
      copyitem.enabled:=(iomemo.sellength>0);
      pasteitem.enabled:=clipboard.hasformat(CF_TEXT);
      delitem.enabled:=(iomemo.sellength>0);
      //
      reloaditem.enabled:=(paramfilename<>'');
end;

procedure TguiForm.doititemClick(Sender: TObject);
begin doit
end;

procedure TguiForm.dumpitemClick(Sender: TObject);
begin serveidentdump
end;

procedure TguiForm.stopactitemClick(Sender: TObject);
begin servestopact
end;

procedure TguiForm.undoitemClick(Sender: TObject);
begin if iomemo.canundo then iomemo.undo
end;

procedure TguiForm.cutitemClick(Sender: TObject);
begin iomemo.cuttoclipboard
end;

procedure TguiForm.copyitemClick(Sender: TObject);
begin iomemo.copytoclipboard
end;

procedure TguiForm.pasteitemClick(Sender: TObject);
begin iomemo.pastefromclipboard
end;

procedure TguiForm.delitemClick(Sender: TObject);
begin iomemo.clearselection
end;

procedure TguiForm.selallitemClick(Sender: TObject);
begin iomemo.selectall
end;

procedure TguiForm.openitemClick(Sender: TObject);
var txt: ustring;
begin //imports müssen erst (?)
      try opendialog.initialdir:=extractslashpath(paramfilename);
          opendialog.filename:=extractslashname(paramfilename);
          if not(opendialog.execute) then exit;
          paramfilename:=opendialog.filename;
          if not(fileexists(paramfilename)) then
             raise exception.create('"'+paramfilename+'" - '+filenotfound);
          setserveuserpath(extractslashpath(paramfilename));
          intxtfile.loadfromfile(paramfilename);
          txt:=intxtfile.text;
          intxtfile.clear;
          tellserve(txt);
          redef:=true;//?
          caption:=' '+extractslashname(paramfilename)+' - '+formcaption//
      except on e: exception do begin
                //ausgeben?...
                errordialog(e.message)
             end
      end//
end;

procedure TguiForm.reloaditemClick(Sender: TObject);
var txt: ustring;
begin //imports müssen erst (?)
      try if (paramfilename='') then raise exception.create(noparamfilename);
          if not(fileexists(paramfilename)) then
             raise exception.create('"'+paramfilename+'" - '+filenotfound);
          setserveuserpath(extractslashpath(paramfilename));
          intxtfile.loadfromfile(paramfilename);
          txt:=intxtfile.text;
          intxtfile.clear;
          tellserve(txt);
          redef:=true;//?
          caption:=' '+extractslashname(paramfilename)+' - '+formcaption//
      except on e: exception do begin
                //ausgeben?...
                errordialog(e.message)
             end
      end//
end;

procedure TguiForm.saveitemClick(Sender: TObject);
begin try savedialog.initialdir:=extractslashpath(memofilename);
          savedialog.filename:=extractslashname(memofilename);
          if not(savedialog.execute) then exit;
          memofilename:=savedialog.filename;
          //if fileexists... //bei save wird auch ohne nachfragen gespeichert
          //encoding einstellen...
          iomemo.lines.savetofile(memofilename);
          caption:=' '+extractslashname(memofilename)+' - '+formcaption
      except on e: exception do errordialog(e.message)
      end//
end;

procedure TguiForm.inititemClick(Sender: TObject);
begin//
end;
procedure TguiForm.finditemClick(Sender: TObject);
begin//
end;

procedure TguiForm.fontitemClick(Sender: TObject);
begin fontdialog.font:=iomemo.font;
      if fontdialog.execute then iomemo.font:=fontdialog.font
end;

procedure TguiForm.quickitemClick(Sender: TObject);
begin try serverun(extractslashpath(exefilename)+documents+infofiledef)
      except on e: exception do errordialog(e.message)
      end//
end;

procedure TguiForm.docuitemClick(Sender: TObject);
begin try serverun(extractslashpath(exefilename)+documents+docufiledef)
      except on e: exception do errordialog(e.message)
      end//
end;

procedure TguiForm.helpitemClick(Sender: TObject);
begin try serverun(extractslashpath(exefilename)+documents+helpfiledef)
      except on e: exception do errordialog(e.message)
      end//
end;

procedure TguiForm.websiteitemClick(Sender: TObject);
begin try serverun(website_url)
      except on e: exception do errordialog(e.message)
      end//
end;

procedure TguiForm.favoritemClick(Sender: TObject);
begin//
end;

procedure TguiForm.testitemClick(Sender: TObject);
var fname,txt: ustring;
begin if (paramfilename='') then
         fname:=extractslashpath(corefilename)+testfiledef
      else fname:=extractslashpath(paramfilename)+testfiledef;
      try if not(fileexists(fname)) then
             raise exception.create('"'+fname+'" - '+filenotfound);
          setserveuserpath(extractslashpath(fname));//?
          intxtfile.loadfromfile(fname);
          txt:=intxtfile.text;
          intxtfile.clear;
          //redef:=true;//? besser nicht - erst cr für redefine
          tellserve(txt);
          caption:=' '+extractslashname(fname)+' - '+formcaption//
      except on e: exception do begin
                // quelltext ausgeben? ...
                errordialog(e.message)
             end
      end//
end;

procedure TguiForm.toolitemClick(Sender: TObject);
begin toolitem.checked:=not(toolitem.checked);
      toolpanel.visible:=toolitem.checked;
      // splitter anpassen !
end;

procedure TguiForm.quititemClick(Sender: TObject);
begin guiForm.close
end;

procedure TguiForm.iopaintboxPaint(Sender: TObject);
begin try if (iopaintbox.height>0) then servedrawtrail//
      except on e: exception do begin
                //ausgeben...
                errordialog(e.message)
                //
             end
      end
end;

procedure TguiForm.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
begin//
end;
procedure TguiForm.FormResize(Sender: TObject);
begin//
end;

procedure TguiForm.iomemoDblClick(Sender: TObject);
begin iomemo.lines.append(prompt)
end;

// Fundamental Loop... //
//procedure TguiForm.FormIdle(Sender: TObject; var Done: Boolean);
//begin//
//end;

end.


// (CC-BY-3.0-DE) Fpstefan
