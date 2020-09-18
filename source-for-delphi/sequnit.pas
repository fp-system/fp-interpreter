unit sequnit;

interface

procedure initseqprims;

implementation

uses apiunit,
primunit;//noch mal neu!

// ----------------------
// ------- legacy -------
// ----------------------
procedure flength;//komplett? ,ifxprefix? ,ifxobject? ,etc
var n: cardinal;
begin repeat einf:=infix[etop];
             //ifxobject? ,position
             if      (einf>=xlimit) then begin
                n:=1;
                etop:=cell[etop].rest;
                repeat einf:=infix[etop];
                       if      (einf>=xlimit) then begin inc(n);
                                                         etop:=cell[etop].rest;
                                                         continue
                                                   end
                       //ifxnull?
                       //else if (einf=xlink)   then etop:=cell[etop].value
                       //else if (einf=xlazy)   then delazy
                       else if (einf=xerror)  then exit
                       else begin etop:=newreal(n); exit end//() ,atome
                until false//
             end
             else if (einf=xstring) then begin
                etop:=newreal(length(cell[etop].pstr^));
                exit
             end
             else if (einf=xarray)  then begin
                etop:=newreal(length(cell[etop].aref^));
                exit
             end
             //elseifxobject?
             //
             //else if (einf=xlink)   then etop:=cell[etop].value
             //else if (einf=xlazy)   then delazy
             else if (einf=xerror)  then exit
             //ifxnull?
             else begin etop:=newreal(0); exit end//() ,atom-länge???
      until false//
end;

// bitte length noch testen !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

//length

// ------- initialization -------

procedure initseqidents;
begin//idxlength...
end;

procedure initseqprims;
begin //
      initseqidents;
      //
      newidentproc('length',flength);
      //
end;

end.


// (CC-BY-3.0-DE) Fpstefan
