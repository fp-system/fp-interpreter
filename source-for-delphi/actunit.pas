unit actunit;

interface

uses SysUtils,//exception;
     Classes,//tstringlist;
     Dialogs,//messagedlg;inputBox;
     typeunit;//ustring

var idxreact:  cardinal = 0;

procedure initactprims;
procedure domonad;

implementation

uses apiunit, serveunit, vmunit;

var idxdefine: cardinal = xnil;
    idxshowgraph: cardinal = xnil;
    idxshowinfo: cardinal = xnil;
    idxprint: cardinal = xnil;
    idxinput: cardinal = xnil;
    idxloadtext: cardinal = xnil;
    idxsavetext: cardinal = xnil;
    idxrun: cardinal = xnil;

// ------- legacy -------
procedure mundef;
begin raise exception.create('m-function undefined.')// provi
end;

procedure mdefine;  // provi             ,def?
begin apiget(idxdefine,mdict,xself);
      //ifxundef
      epush(etop);
      apiget(idxdefine,mdict,xpara);
      //ifxundef,etc...dec()
      efun:=estack[eptr];  dec(eptr);//pull
      einf:=infix[efun];
      if ((einf=xident) or (einf=xprefix)) then begin
         if (cell[efun].value=xreserve) then begin
            cell[efun].value:=etop;
            etop:=mdict;//
         end
         else provisorium('define=reserved ... provisorium.')//
      end
      else provisorium('define<>ident/prefix, nur provisorium...');
      //
end;

procedure mredefine;                   // ,redef?
begin//
end;

// ------------------
// ----- legacy -----
// ------------------
procedure mshowgraph;
//procedure ioshowgraph;
var delta: longint;
begin apiget(idxshowgraph,mdict,xit);//umstellen auf monaden
      //servprint(tovalue(etop)+' //iget ''top');//for test
      trail:=etop;//???
      if ((uipaintbox<>nil) and (uipanel<>nil) and (uiform<>nil)) then begin
         if uipanel.visible then delta:=uipanel.height
                            else delta:=0;
         if (uipaintbox.height=0) then
            uipaintbox.height:=uiform.clientheight-delta-splitterheight;
         uipaintbox.repaint;
         etop:=xnil//provi!!!
      end
      else etop:=newerror(xundef,'device is not installed...');//provi!!!
      etop:=mdict//
end;

procedure mshowinfo;
begin apiget(idxshowinfo,mdict,xit);
      messagedlg(AnsiDequotedStr(tovalue(etop),qot2),mtinformation,[mbok],0);
      etop:=mdict;
      //xbind?
end;

procedure mprint;
begin apiget(idxprint,mdict,xit);
      serveprint(totable(etop));
      etop:=mdict;
      //xbind?
end;

procedure minput;
var s: ustring;
begin apiget(idxinput,mdict,xit);
      s:=AnsiDequotedStr(tovalue(etop),qot2);
      serveinput:=true;
      s:=inputbox('input',s,'');
      serveinput:=false;
      apiput(mdict,xit,newstring(s));//etop:=newstring(s)??? ,wie mit #var
      //xbind? ,error?
end;

procedure mloadtext;
var txtlist: tstringlist;
    i: longint;//groß genug?
    txt,crlf,fname: ustring;
begin apiget(idxloadtext,mdict,xit);
      fname:=AnsiDequotedStr(tovalue(etop),qot2);//path?,lokal;
      txtlist:=tstringlist.create;
      try if fileexists(fname) then begin
             txtlist.loadfromfile(fname);
             txt:='';  crlf:='';
             for i:=0 to txtlist.count-1 do begin
                 txt:=txt+crlf+txtlist.strings[i];
                 crlf:=#13#10
             end;
             txtlist.clear;
             apiput(mdict,xit,newstring(txt))
          end
          else begin apiput(mdict,xit,newstring('error bei loadtext...filenotfound'));
                     //fehler genauer behandeln
               end//
      finally txtlist.free
      end
end;

procedure msavetext;// provi ,para und self vertauscht! ,it?
var txtlist: tstringlist;
    txt,fname: ustring;
begin apiget(idxsavetext,mdict,xpara);
      if (infix[etop]<>xstring) then begin
         apiput(mdict,xit,newstring('error bei savetext...kein string'));
         //fehler genauer behandeln
         exit
      end;
      txt:=cell[etop].pstr^;//if nil?
      apiget(idxsavetext,mdict,xself);
      fname:=AnsiDequotedStr(tovalue(etop),qot2);
      //path?,lokal;
      txtlist:=tstringlist.create;
      try txtlist.text:=txt;  txt:='';
          txtlist.savetofile(fname);
          txtlist.clear;
          txtlist.free;
          apiput(mdict,xit,xtrue);//??? bessere lösung ...
      except txtlist.free;
             apiput(mdict,xit,xfalse);//??? bessere lösung ...
      end;
      //hier weiter machen
end;

procedure mrun;
begin apiget(idxrun,mdict,xit);
      serverun(AnsiDequotedStr(tovalue(etop),qot2));//try und _error...
      etop:=mdict;
      //
end;

procedure mquit;
begin etop:=mdict;
      servequit:=true;//position? ,bedingungen? ,etc?;
      //
end;

var aindex: int64 = 0;

// ------------------
// ----- legacy -----
// ------------------
procedure domonadpre;
begin //adict:=etop;
      if (infix[etop]<>xact) then raise exception.create('domonad isno _act');//provi-test
      mstack:=prop(etop,xcons,mstack);//etop auf den astack legen ...
      mdict:=cell[etop].rest;
      etop:=cell[etop].first;
      repeat einf:=infix[etop];
             if (einf=xinteger)    then begin
                aindex:=cell[etop].inum;
                if (aindex>0) then begin if (aindex<=maxproc) then proc[aindex]
                                         else provisorium('domonad first >maxproc');
                                         break
                                   end
                else provisorium('domonad first neg_int')
             end
             else if (einf=xident) then begin;provisorium('domonad infirst _ident');end
             //ifxindex?
             else if (einf=xact)   then begin;provisorium('domonad infirst _act');end
             else if (einf=xnull)  then begin;provisorium('domonad infirst _null');end//position?
             //else if (einf=xlink)  then etop:=cell[etop].value
             //else if (einf=xlazy)  then delazy
             else if (einf=xerror) then exit//???
             else begin;provisorium('domonad infirst <else>');end//se break//???
      until false;
      //bind... in servreaction?
end;

procedure domonad;
begin if (infix[etop]=xact) then begin
         //_bind,mstack?
         //mstack:=prop(etop,xcons,mstack);//for test
         //
         with cell[etop] do begin mdict:=rest; etop:=first end;
         //mstack:=prop(prop(xnil,xact,mdict),xcons,mstack);
         einf:=infix[etop];
         if      (einf=xinteger) then begin
            aindex:=cell[etop].inum;
            if      (aindex<=0)       then begin provisorium('int<=0 in _act')end
            else if (aindex<=maxproc) then begin
               proc[aindex];
               mdict:=etop;
               apiget(idxreact,mdict,xbind);//wird mdict verändert? //ifxundef?
               //ifxundef...
               //ifxerror...
               efun:=etop;
               etop:=mdict;
               repeat eval;  if (ecall<>0) then proc[ecall]
               until equit;
            end
            else begin provisorium('int>maxproc in _act')end
         end
         else if (einf=xindex)   then begin
            mstack:=prop(mdict,xcons,mstack);//(prop(,xact,))?
            epush(etop);//besser anders...
            apiget(idxreact,mdict,xeff);//iferror? //ifxundef? ,idxreact?
            if (etop=xundef) then provisorium('keine effektgruppe gefunden in _act');//find effect
            //ifxerror...
            efun:=estack[eptr];  dec(eptr);
            apiget(idxreact,etop,efun);//ifxerrror ,ifxundef ,idxreact?
            if (etop=xundef) then provisorium('keinen einzeleffekt gefunden in _act');
            if(infix[etop]=xerror)then provisorium('einzeleffekt fehler in _act='+tovalue(etop));
            //serveprint('mdict='+tovalue(mdict));
            efun:=etop;
            etop:=mdict;
            repeat eval;  if (ecall<>0) then proc[ecall]
            until equit;
            //serveprint('eval='+tovalue(etop));etop:=mdict;
            //nt();//endeget();//
         end
         else if (einf=xact)     then begin provisorium('_act(box) in _act') end
         else if (einf=xnull)    then begin provisorium('xnil in _act')end
         //elseif()thenbeginend//ifxerror? ,ifxident?wiexindex ,ifxnull?
         else if (einf=xerror)   then begin provisorium('_error im _act')end//oder in _bind umleiten?
         else begin provisorium('provi: unable type in _act');//provi???
         end;
         einf:=xnil
      end
      else provisorium('domonad isno _act')//provi???
      //wo _bind bearbeiten?
end;

//backtrack --> xnil _act ...
//error
//return
//define
//redefine
//showgraph
//showinfo
//print
//input
//loadtext [error]
//savetext [error]
//run(?)
//quit(?)
//time, date, etc.

// ------- act initialization -------

procedure initactprims;
var i: longint;
begin for i:=0 to maxproc do proc[i]:=mundef;
      idxreact:=newindex('react');//position?
      idxdefine:=newindex('define');
      //
      idxshowgraph:=newindex('showgraph');
      idxshowinfo:=newindex('showinfo');
      idxprint:=newindex('print');
      idxinput:=newindex('input');
      idxloadtext:=newindex('loadtext');
      idxsavetext:=newindex('savetext');
      //
      idxrun:=newindex('run');
      //
      proc[3] :=mdefine;
      //proc[4] :=mredefine;
      proc[5] :=mshowgraph;
      proc[6] :=mshowinfo;
      proc[7] :=mprint;
      proc[8] :=minput;
      proc[9] :=mloadtext;
      proc[10]:=msavetext;
      proc[11]:=mrun;
      proc[12]:=mquit;
      //
end;

end.


// (CC-BY-3.0-DE) Fpstefan
