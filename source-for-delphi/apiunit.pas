unit apiunit;

interface

uses SysUtils,//exception   //delphi:maxstack=16777214;
     StdCtrls,//tmemo;
     //System.
     UITypes,//crHourGlass
     typeunit;//es,ustring,pustring

const //
      // -------errors apiunit -------
      enomemoryerror: es    = 'not enough memory for prop-cells...';//???
      enostringmemerror: es = 'not enough memory for strings...';
      enoarraymemerror: es  = 'not enough memory for arrays...';
      //
      //
      // ------- errors serveunit -------
      eserveprintexc: es            = 'print procedure not defined.';
      eservedrawtrailexc: es        = 'graphic procedure not defined.';
      eservedrawxynoreal: es        = 'for x,y two reals expected.';
      eservedrawpennobool: es       = 'for pen a bool operand expected.';
      eservedrawcolornoint: es      = 'for color an integer as operand expected.';
      eservedrawsizenoint: es       = 'for size an integer as operand expected.';
      eservedrawbrushnoint: es      = 'for brush an integer as operand expected.';
      eservedrawcirclenoreal: es    = 'for circle a real as operand expected.';
      eservedrawcirclematherror: es = 'circle calculation error.';
      eservedrawcircledrawerror: es = 'error occurred during drawing of circle.';
      eservedrawrectdrawerror: es   = 'error occurred during drawing of rect.';
      eservedrawprotocolerror: es   = 'error in the protocol.';
      eservedrawunexpect: es        = 'unexpected value in the trail.';
      //
      eimportnoexist: es           = 'import-file does not exist:';
      efilenotfound: es            = 'File not found.';//
      //
      // ------- errors precom -------
      ecomnosafestack: es      = 'precom: no stack value for safeinfix.';//???
      ecomnosafestring: es     = 'precom: no safe _string in infix.';//???
      ecomnosafearray: es      = 'precom: no safe _array in infix.';//???
      ecomnosafetype: es       = 'precom: no safe primtype in infix.';//???
      //
      ecomnoint: es            = 'precom: no integer value in brackets.';
      ecomnoprebracket: es     = 'precom: opening bracket missing.';
      ecomnopostbracket: es    = 'precom: closing bracket missing.';
      ecomnostringend: es      = 'precom: string has no ending (").';
      //table
      ecomtableunexpend: es  = 'precom: unexpected end in table.';
      ecomparentend: es        = 'precom: no opening "(" for ending ")".';
      ecomarrayend: es         = 'precom: no opening "{" for ending "}".';
      ecomddotnotoinfix: es    = 'precom: ddot (..) not allowed at infix position.';
      ecomforddotnoend: es     = 'precom: ddot (..) not used in the end.';
      //array
      ecomconstnoindex: es     = 'precom: constant-value is not index.';//???
      ecomarconsttaken: es     = 'precom: constant-value is defined before.';//???
      ecomfordotnoend: es      = 'precom: ddot (..) not used in the end.';//???
      ecomnorestexpect: es     = 'precom: indexes not fully processed.';
      ecomarplacetaken: es     = 'precom: place-value is defined before.';//???
      ecomdefnoindex: es       = 'precom: definition without index before.';//???
      ecomdoubleardef: es      = 'precom: doubled definition-sign in array.';
      ecomtypenoindex: es      = 'precom: for definition index expected.';
      ecomarrayunexpend: es    = 'precom: unexpected end in array.';
      ecomddotnotinarray: es   = 'precom: ddot (..) not allowed in array.';//???
      //quote
      ecomquoteunexpend: es    = 'precom: unexpected end in quote ('').';
      ecomquoteunexpddot: es   = 'precom: ddot (..) used in quote.';//???
      //ivar
      ecomvarunexpend: es      = 'unexpected end in ivar (#).';//???precom?
      ecomivarunexpddot: es    = 'ddot (..) used in ivar (#).';//???;precom?
      //
      ecomdefnoident: es       = 'precom: ddefinition without previous ident.';
      //
      //postcom...
      ecomdoubledef: es        = 'postcom: double definition sign.';//???
      ecomconstnoident: es     = 'postcom: constant name must be ident.';//???
      ecomconsttaken: es       = 'postcom: Constant is already defined';
      epostcomforddotnoend: es = 'postcom: ddot (..) not used in the end.';//???
      //
      // ------- errors interpreter -------
      eiproutofarray: es   = 'access is outside the array';
      eiprnotinrange: es      = 'access is out of table';//???table - sequence
      eiprnotable: es       = 'access requires table';//???table - sequence
      eiprunquoted: es        = 'type is not quoted';//?
      eiprfuncundef: es       = 'function is undefined';
      eipridentunbound: es    = 'ident is not bound';
      //
      // ------- errors primunit -------
      efuncundef: es         = 'function is not defined.';
      enoprocmemerror: es    = 'not enough memory for proc.';
      eselnotfound: es      = 'selector in (super-)class not found: ';//??? ,class?
      //neu anpassen!
      einfnoprop: es         = 'infix is no prop-syntax.';//???;
      efnnocons: es = 'list of cons expected.';//???
      efnnosafeinfix: es = 'infix is not safe.';//???
      //�ndern?
      efnconsexpect: es      = 'cons-list expected.';//oder einfnoprop nehmen?
      efnnocombine: es       = 'for function combine expected.';//?
      efnunabletype: es      = 'unable type.';//???
      //
      // ------- errors combiunit -------
      //
      eopaltexpect: es = 'alternal for operand[1] expected.';
      //noch n�tig?:
      eopconsexpect2: es     = 'cons-list for operand[1] expected.';
      //
      // ------- errors boolunit -------
      eltnocompare: es       = 'type compare not be able.';//???
      eltnostring: es        = 'idents are defect.';//???;
      efnnobound: es = 'for function ident or prefix expected.';//? prefix?
      //
      //nachfolgendes l�schen?
      etermnoprop: es        = 'term has no prop-syntax.';//???
      eactualnoformal: es    = 'actual parameter has no formal-syntax.';//???
      etypemismatch: es      = 'typemismatch: ...';//weiter ausbauen !!!
      eformalinfnobool: es   = 'formal infix is no bool.';//???
      //
      efnnobool: es          = 'for function bool expected.';
      eopnobool1: es         = 'bool for operand[0] expected.';
      eopnobool2: es         = 'bool for operand[1] expected.';
      //
      // ------- errors mathunit -------
      eopmatherror: es       = 'arithmetic error.';//???;
      eopnonum1: es          = 'number as operand[0] expected.';
      eopnonum2: es          = 'number as operand[1] expected.';
      eopnoint1: es          = 'integer as operand[0] expected.';
      eopnoint2: es          = 'integer as operand[1] expected.';
      eopnoreal2: es         = 'real as operand[1] expected.';
      //
      efdivbyzero: es        = 'division by zero (real).';
      eidivbyzero: es        = 'division by zero (integer).';
      //
      efnnonum: es           = 'for function number expected.';//?;
      efnnoreal: es          = 'for function real expected.';
      efnmatherror: es       = 'math error in function.';
      //
      //
      efnrounderror: es = 'round error in function.';//???
      //
      // ------- errors stringunit -------
      efnnostring1: es   = 'string as argument[0] expected.';
      efnnonum2: es      = 'number as argument[1] expected.';
      efnnonum3: es      = 'number as argument[2] expected.';
      efnstringnoval: es = 'string has no reference.';//???
      //
      eopnostring1: es       = 'for operand[0] string expected.';
      eopnostring2: es       = 'for operand[1] string expected.';
      //
      echarnotinrange: es = 'number between 0 and 65535 expected.';//???
      //
      efnstringnull: es = 'for function nonempty string expected.';
      //
      efnnostring: es    = 'for function string expected.';
      //
      // ------- react -------
      //
      ereactnobind: es = '_bind not found.';//???
      //
      //
      // ------- api-constants & types -------
      xnull    = 0;
      xinteger = 1;    // name wie in oberon
      xreal    = 2;
      //xcomplex = x;
      xstring  = 3;
      xmaxdata = xstring;
      xident   = 4;
      xprefix  = 5;    //?
      xindex   = 6;
      //xchar ?;
      xarray   = 7;    // ,vector-->oop ?
      xmaxatom = xarray;
      xerror   = 8;    // xexception zu lang
      xnil     = 9;    //null
      xlimit   = xnil; //xnil = xlimit//
      xcons    = 10;
      xsuper   = 11;
      //xexc    = ;
      xcombine = 12;   //name?
      xalter   = 13;   // alternal
      xobject  = 14;
      xquote   = 15;
      xivar    = 16;   //name?
      xcompose = 17;   // erm�glicht variablenfrei Programmierung (sequetiell)
      xact     = 18;   //sensitiv
      xneg     = 19;
      xsingle  = 20;
      xmark    = 21;
      xreserve = 22;
      xundef   = 23;
      xdef     = 24;   //sensitiv
      xddot    = 25;
      xtrue    = 26;
      xfalse   = 27;
      //
      xit      = 28;   // item?
      xself    = 29;
      xpara    = 30;
      xvar     = 31;   // _var?
      xbind    = 32;   // _bind
      xeff     = 33;   // _eff...
      //
      xpen     = 34;
      xcolor   = 35;
      xsize    = 36;
      xbrush   = 37;
      xcircle  = 38;
      xrect    = 39;
      //
      xcorepath   = 40;
      xuserpath   = 41;
      xcoreimport = 42;
      xuserimport = 43;//userimport?
      //
      xiput=44;// for test
      //xeinterp = 45;
      xmaxtype = xiput;//xeinterp;
      //
      prefix   = '@';
      compose  = unicodechar(176);// ='�';
      idy      = unicodechar(8801);// =...;
      def      = '==';// oder ':=' (?) 1-assign-constants/prefixes ':=='//
      ddot     = '..';
      qot1     = '''';
      qot2     = '"';
      sharp    = '#';
      minproc  = -500;
      maxproc  =  500;//

type //prop: infix,cell64,cebit   // cells
     pcardmem = ^cardmem;
     cell64   = record case cardinal of
                       xident,
                       xprefix:  (pname,value: cardinal);
                       xindex:   (rname,rnum: cardinal);// (r)ef
                       xinteger: (inum: int64);
                       xreal:    (fnum: double);// 64 bit
                       xstring:  (pstr: pustring);
                       xarray:   (aref: pcardmem);
                     //----------------------------------
                       xnull,
                       xcons:    (first,rest: cardinal);
                       xcombine: (term,arg: cardinal);// single-closure
                       xobject:  (cap,inst: cardinal);// multi-closure
                       //
                end;   // term und arg sind jetzt vertauscht
     cellmem  = array of cell64;
     cardmem  = array of cardinal;
     boolmem  = array of boolean;
     procmem  = array [minproc..maxproc] of fproc;
     //

var cell:   cellmem;
    infix:  cardmem;
    cebit:  boolmem;
    estack: cardmem;
    proc:   procmem;
    //
    maxcell:  cardinal = 0;
    maxstack: cardinal = 0;
    //Register:
    eptr: cardinal = 0;//maxstack
    //
    freelist: cardinal = xnil;
    identlist: cardinal = xnil;
    prefixlist: cardinal = xnil;
    indexdict: cardinal = xnil;
    freeid: cardinal = xnil;
    cstack: cardinal = xnil;
    cref: cardinal = xnil;
    etop: cardinal = xnil;
    efun: cardinal = xnil;
    einf: cardinal = xnil;
    mstack: cardinal = xnil;
    mdict: cardinal = xnil;
    trail: cardinal = xnil;
    //
    impref: cardinal = xnil;
    //
    idxsuper: cardinal = xnil;
    idxget: cardinal = xnil;
    idxput: cardinal = xnil;
    idxremove: cardinal = xnil;
    idxnew: cardinal = xnil;
    idxas: cardinal = xnil;
    idxipr: cardinal = xnil;
    //for serveunit und cursor
    uimemo: tmemo = nil;

procedure initapi(mc,ms: int64);
procedure finalapi;
procedure initapiprims;
//
procedure gc(f,inf,r: cardinal);
function prop(f,inf,r: cardinal): cardinal;
function newinteger(x: int64): cardinal;
function newreal(x: double): cardinal;
function newstring(s: ustring): cardinal;
function newident(s: ustring;v: cardinal): cardinal;
function newindex(s: ustring): cardinal;
function newarray(n: int64): cardinal;
function newerror(idx: cardinal;s: ustring): cardinal;
//legacy:
procedure epush(i: cardinal);
procedure apiget(ide,aggr,key: cardinal);
procedure apiput({ide}aggr,key,val: cardinal);
//
procedure provisorium(s: ustring);

implementation

uses vmunit;//for eval ,vmunit?

var freetop: cardinal = xnil;
    tinf:    cardinal = xnil;
    tlength: cardinal = 0;

// ------- memory management -------

//xtypes...
//traverse: erst markieren - dann durchlaufen (?);

procedure traversearray(p: pcardmem);
forward;

// ------------------
// ----- legacy -----
// ------------------
procedure traverse(i: cardinal);//ifxprefix...
begin if cebit[i] then exit;
      repeat cebit[i]:=true;
             tinf:=infix[i];
             if      (tinf>=xlimit)   then begin traverse(tinf);
                                                 traverse(cell[i].first);
                                                 i:=cell[i].rest
                                           end
             else if (tinf<=xmaxdata) then exit//xnull,xint,xfloat,xstring
             else if (tinf>xmaxatom)  then begin traverse(cell[i].first);
                                                 i:=cell[i].rest
                                           end//xlink,xlazy,xexc
             else if (tinf=xident)    then begin traverse(cell[i].pname);
                                                 i:=cell[i].value
                                           end
             else if (tinf=xprefix)   then begin traverse(cell[i].pname);
                                                 i:=cell[i].value
                                           end
             else if (tinf=xindex)    then i:=cell[i].rname
             else if (tinf=xarray)    then traversearray(cell[i].aref)
             else provisorium('provisorium in traverse (else)')
      until cebit[i]
end;

// ------------------
// ----- legacy -----
// ------------------
procedure traversearray(p: pcardmem);
var i: cardinal;
begin tlength:=length(p^);
      if (tlength=0) then exit;
      for i:=0 to pred(tlength) do traverse(p^[i])//wenn tlength verschweinert?
end;

//ifprefix f�r traverse...

//gc: etop,efun,einf,estack(eptr),freeid,cstack,cref,mstack,mdict,impref,
//identlist,prefixlist,indexdict,trail

// ------------------
// ----- legacy -----
// ------------------
procedure gc(f,inf,r: cardinal);//freeid,etop,efun,einf ,cstack,cref,
// ,mstack,mdict,trail,imref
//estack,eptr //freelist,identlist,indexdict
var i: cardinal;
c:cardinal;//provi (?)
begin //raise exception.create('gc:keine cellen mehr...');// provi
      //try?
      uimemo.cursor:=crAppStart;
      for i:=0 to maxcell do cebit[i]:=false;//nicht n�tig...
      for i:=0 to xmaxtype do traverse(i);
      //xnil:=true
      traverse(f);
      traverse(inf);
      traverse(r);
      traverse(freeid);
      traverse(etop);
      traverse(efun);
      traverse(einf);
      traverse(cstack);
      traverse(cref);
      traverse(mstack);
      traverse(mdict);
      traverse(trail);
      traverse(impref);
      traverse(identlist);
      traverse(prefixlist);//prefixlist;
      traverse(indexdict);
      for i:=0 to eptr do traverse(estack[i]);//estack
      //collect ab xmaxtype+1(?) siehe...
      freelist:=xnil;
      c:=0;
      for i:=maxcell downto xmaxtype+1 do
          if cebit[i] then cebit[i]:=false
          else with cell[i] do begin
                    tinf:=infix[i];
                    if (tinf=xstring) then dispose(cell[i].pstr);
                    if (tinf=xarray)  then begin
                       if (cell[i].aref<>nil) then cell[i].aref^:=nil;//begin?
                       dispose(cell[i].aref)//bei nil?
                    end;
                    infix[i]:=xcons;//strings und arrays freigeben...
                    inc(c);
                    first:=xnil;
                    rest:=freelist;
                    freelist:=i
               end;
      uimemo.cursor:=crDefault;
      //zuletzt: serveprint('[gc: free cells = '+inttostr(c)+']');
      //except von try?
      if (freelist=xnil) then raise exception.create('freelist is empty. break.')//provi
end;

{
procedure gc(f,inf,r: cardinal);
begin raise exception.create('gc: zellen sind verbraucht... abbruch.')//
end;
}

function prop(f,inf,r: cardinal): cardinal;
begin if (freelist=xnil) then gc(f,inf,r);
      freetop:=freelist;
      infix[freetop]:=inf;
      with cell[freetop] do begin freelist:=rest;
                                  first:=f;
                                  rest:=r
                            end;
      prop:=freetop
end;

function newinteger(x: int64): cardinal;
begin if (freelist=xnil) then gc(xnil,xnil,xnil);
      freetop:=freelist;
      with cell[freetop] do begin freelist:=rest;
                                  infix[freetop]:=xinteger;
                                  inum:=x
                            end;
      newinteger:=freetop
end;

function newreal(x: double): cardinal;
begin if (freelist=xnil) then gc(xnil,xnil,xnil);
      freetop:=freelist;
      with cell[freetop] do begin freelist:=rest;
                                  infix[freetop]:=xreal;
                                  fnum:=x
                            end;
      newreal:=freetop
end;

function newstring(s: ustring): cardinal;
var ps: pustring;
begin if (freelist=xnil) then gc(xnil,xnil,xnil);
      try new(ps);
          ps^:=s
      except //...
             raise exception.create(enostringmemerror)
      end;
      freetop:=freelist;
      with cell[freetop] do begin freelist:=rest;
                                  infix[freetop]:=xstring;
                                  pstr:=ps
                            end;
      newstring:=freetop
end;

function newident(s: ustring;v: cardinal): cardinal;
begin freeid:=v;
      freeid:=newstring(s);
      if (freelist=xnil) then gc(xnil,xnil,v);
      freetop:=freelist;
      with cell[freetop] do begin freelist:=rest;
                                  infix[freetop]:=xident;
                                  pname:=freeid;
                                  value:=v
                            end;
      freeid:=xnil;
      newident:=freetop;
      identlist:=prop(freetop,xcons,identlist)
end;

function newprefix(s: ustring;v: cardinal): cardinal;
begin freeid:=v;
      freeid:=newstring(s);
      if (freelist=xnil) then gc(xnil,xnil,v);
      freetop:=freelist;
      with cell[freetop] do begin freelist:=rest;
                                  infix[freetop]:=xprefix;
                                  pname:=freeid;
                                  value:=v
                            end;
      freeid:=xnil;
      newprefix:=freetop;
      prefixlist:=prop(freetop,xcons,prefixlist)
end;

function count(i: cardinal): cardinal;
var n: cardinal;
begin n:=0;
      while (infix[i]<>xnull) do begin inc(n);
                                       i:=cell[i].rest
                                 end;
      count:=n
end;

function newindex(s: ustring): cardinal;
begin freeid:=newstring(s);
      if (freelist=xnil) then gc(xnil,xnil,xnil);
      freetop:=freelist;
      with cell[freetop] do begin freelist:=rest;
                                  infix[freetop]:=xindex;
                                  rname:=freeid;
                                  rnum:=count(indexdict)
                            end;
      freeid:=freetop;
      newindex:=freetop;
      indexdict:=prop(newinteger(cell[freeid].rnum),freeid,indexdict);//indexprop(?)
      freeid:=xnil
end;

function newarray(n: int64): cardinal;
var ar: pcardmem; i: cardinal;
begin if (freelist=xnil) then gc(xnil,xnil,xnil);
      try new(ar);
          if (n=0) then ar^:=nil
          else begin setlength(ar^,n);
                     for i:=0 to pred(n) do ar^[i]:=xundef
               end;
      except raise exception.create(enoarraymemerror)
      end;
      freetop:=freelist;
      with cell[freetop] do begin freelist:=rest;
                                  infix[freetop]:=xarray;
                                  aref:=ar
                            end;
      newarray:=freetop
end;

function newerror(idx: cardinal;s: ustring): cardinal;//idx muss in indexdict sein
begin //freeid:=idx;
      freeid:=newstring(s);            //idx?
      freeid:=prop(freeid,xcons,xnil); //idx?
      if (freelist=xnil) then gc(idx,xnil,xnil);
      freetop:=freelist;
      with cell[freetop] do begin freelist:=rest;
                                  first:=idx;
                                  infix[freetop]:=xerror;
                                  rest:=freeid
                            end;
      freeid:=xnil;
      newerror:=freetop
end;

// ---------- cell initialization -------

procedure initfreelist;
var i: cardinal;
begin for i:=0 to xmaxtype do   //xnull=0
          with cell[i] do begin infix[i]:=xident;
                                pname:=xnil;
                                value:=xreserve;
                                cebit[i]:=false//?
                          end;
      infix[xnil]:=xnull;
      cell[xnil].first:=xnil;
      cell[xnil].rest:=xnil;
      cebit[xnil]:=false;//?
      freelist:=xnil;
      for i:=maxcell downto xmaxtype+1 do
          with cell[i] do begin infix[i]:=xcons;
                                first:=xnil;
                                rest:=freelist;
                                cebit[i]:=false;
                                freelist:=i
                          end;
end;

procedure setxident(id: cardinal;s: ustring);
begin cell[id].pname:=newstring(s);
      identlist:=prop(id,xcons,identlist)
end;

procedure initxidents;
begin identlist:=xnil;
      setxident(xnull,   '_null');
      setxident(xinteger,'_integer');
      setxident(xreal,   '_real');
      //xcomplex = x;
      setxident(xstring, '_string');
      setxident(xident,  '_ident');
      setxident(xprefix, '_prefix');
      setxident(xindex,  '_index');
      //xchar ?;
      setxident(xarray,  '_array');   //vector?
      setxident(xerror,  '_error');
      setxident(xcons,   ';');
      setxident(xsuper,  '_super');
      //xexc    = ;
      setxident(xcombine,'_combine');
      setxident(xalter,  '|');        // alternal
      setxident(xobject, '::');
      setxident(xquote,  '_q');
      setxident(xivar,   '_v');       //name?
      setxident(xcompose,compose);    //='�'
      setxident(xact,    '_act');
      setxident(xneg,    '_');        // platzhalter?
      setxident(xsingle, '_s');
      setxident(xmark,   '''mark');
      setxident(xreserve,'_reserve');
      setxident(xundef,  '_undef');
      setxident(xdef,    def);        //idy oder def
      setxident(xddot,   '''ddot');
      setxident(xtrue,   'true');
      setxident(xfalse,  'false');
      //
      setxident(xit,     '_it');       //item?  oder  _it ?
      setxident(xself,   '_self');
      setxident(xpara,   '_para');     //param?
      setxident(xvar,    'var');      //_var?
      setxident(xbind,   '_bind');    // _bind
      setxident(xeff,    '_eff');     // _eff...
      //
      setxident(xpen,    'pen');
      setxident(xcolor,  'color');
      setxident(xsize,   'size');
      setxident(xbrush,  'brush');
      setxident(xcircle, 'circle');
      setxident(xrect,   'rect');
      //
      setxident(xcorepath,  'corepath');
      setxident(xuserpath,  'userpath');
      setxident(xcoreimport,'coreimport');
      setxident(xuserimport,'userimport');//userimport?
      //
      setxident(xiput,   'iput');     // for test !!!
      //setxident(xeinterp,'einterpreter');//?
      //
end;

// ------- api misc -------

// legacy provisorium
procedure provisorium(s: ustring);
begin raise exception.create(s);
end;

const epushoverflow: es     = 'estack overflow.';//???;
// legacy provisorium
procedure epush(i: cardinal);
begin if (eptr>=maxstack) then raise exception.create(epushoverflow);
      inc(eptr);
      estack[eptr]:=i
end;

// ------------------
// ----- legacy -----
// ------------------
const // ----- errors apiunit ----- //auf apiget �ndern!!!!!!!!!!!!!!!!!!
      eigetunablekey: es    = 'apiget: unable key';//???
      eigetundef: es        = 'apiget: _undef ident (or no superclass in array)';//???
      eigetidentunbound: es = 'apiget: ident unbound (or class-ident has no value)';//??? text anders !!!
      eigetunabletype: es   = 'apiget: unable type.';//???
      eigetprimtype: es     = 'apiget: primitve type';//???
      //eigetsupernotfound: es = 'iget super not found';//???
      eigetisnoindex: es    = 'apiget: is no index for array';//???
      eigetarraynosuper: es = 'apiget: array has no super';//???
      //eigetkeynotfound: es = 'iget key not found';//???
//
//aus apiunit: //ifprefix?...

//
// ------- table pattern matching function (apiget) ,imatch? -------
//

//iget: noch nicht ganz fertig!
// oder apiget
//get f�r instancen-variablen
//ver�ndert alle e-register
procedure apiget(ide,aggr,key: cardinal);//result: etop   //matching
label ajump;
var index: cardinal;
    p: pcardmem;
    isnoindex: boolean;
begin etop:=aggr;//???
      einf:=infix[key];
      index:=0;  isnoindex:=false;
      if      (einf=xident) then isnoindex:=true
      else if (einf=xindex) then index:=cell[key].rnum
      else begin etop:=newerror(ide,eigetunablekey); exit end;
      epush(key);
      epush(xnil);
      repeat einf:=infix[etop];//ifxundef? position?
         if      (einf=xident)  then begin
            if (etop=xundef) then begin dec(eptr,2);
                                        etop:=newerror(ide,eigetundef);
                                        exit
                                  end;
            etop:=cell[etop].value;
            if (etop=xreserve) then begin dec(eptr,2);
                                          etop:=newerror(ide,eigetidentunbound);
                                          exit
                                    end
         end
         else if (einf>=xlimit) then begin
            estack[eptr]:=etop;//epush(etop);
            repeat einf:=infix[etop];//position?
               if      (einf>=xlimit) then begin//pointer-vergleich:
                  if (einf = key) then begin etop:=cell[etop].first;
                                             //ifxundef?
                                             dec(eptr,2);  exit
                                       end;
                  etop:=cell[etop].rest;  continue//
               end
               else if (einf=xnull)   then break
               else if (einf=xarray)  then begin goto ajump end//<--test//;dec(eptr,2);provisorium('provisorium in eget array im key-scan');end
               else if (einf=xident)  then begin
                  etop:=cell[etop].value;
                  if (etop=xreserve) then begin
                     dec(eptr,2);
                     etop:=newerror(ide,eigetidentunbound);
                     exit
                  end
               end//position?
               //else if (einf=xlink)   then etop:=cell[etop].value//if egetlinkunbound?
               //else if (einf=xlazy)   then delazy
               else if (einf=xerror)  then begin dec(eptr,2); exit end
               //else if (einf=x) then beginend
               else begin dec(eptr,2);
                          etop:=newerror(ide,eigetprimtype);
                          exit
                    end
            until false;
            etop:=estack[eptr];  //dec(eptr);
            repeat einf:=infix[etop];
               if      (einf>=xlimit) then begin//pointer-vergleich:
                  if (einf = xsuper) then begin etop:=cell[etop].first; break end;
                  etop:=cell[etop].rest;  continue//
               end
               else if (einf=xnull)   then begin dec(eptr,2); etop:=xundef; exit end//newexc(ide,eigetsupernotfound)
               else if (einf=xarray)  then begin;dec(eptr,2);provisorium('provisorium in eget array im super-scan');end
               else if (einf=xident)  then etop:=cell[etop].value//position? ,egetidentunbound?
               //else if (einf=xlink)   then etop:=cell[etop].value// ,egetlinkunbound
               //else if (einf=xlazy)   then delazy
               else if (einf=xerror)  then begin dec(eptr,2); exit end
               //else if (einf=x) then beginend
               else begin dec(eptr,2);
                          etop:=newerror(ide,eigetprimtype);
                          exit
                    end//
            until false//
         end
         else if (einf=xarray)  then begin
            ajump://<--test
            if isnoindex then begin dec(eptr,2);
                                    etop:=newerror(ide,eigetisnoindex);
                                    exit
                              end;
            p:=cell[etop].aref;
            if (index<length(p^)) then begin etop:=p^[index];
                                             if (etop<>xundef) then begin
                                                dec(eptr,2);
                                                exit
                                             end//en exit
                                       end;
            if (length(p^)=0) then begin dec(eptr,2);
                                         etop:=newerror(ide,eigetarraynosuper);
                                         exit
                                   end;
            etop:=p^[0]
         end//gin dec(eptr,2); provisorium('provisorium bei eget array im class-scan')end
         else if (einf=xnull)   then begin dec(eptr,2);etop:=xundef;exit end//newexc(ide,eigetkeynotfound)
         //else if (einf=xlink)   then etop:=cell[etop].value//if egetlinkunbound?
         //else if (einf=xlazy)   then delazy
         else if (einf=xerror)  then begin dec(eptr,2); exit end//eptr,exit
         else begin dec(eptr,2); etop:=newerror(ide,eigetunabletype); exit end//se break
      until false//
end;

// ----------------------
// ------- legacy -------
// ----------------------
procedure apiput({ide}aggr,key,val: cardinal);// result: etop //... provi !!! for test
begin etop:=aggr;
      einf:=key;
      efun:=val;
      etop:=prop(aggr,xcons,prop(prop(key,xcons,prop(val,xcons,xnil)),xcons,xnil));
      //servprint(tovalue(etop));//for test
      efun:=xiput;
      repeat eval;  if (ecall<>0) then proc[ecall]
      until equit;//loop?
end;

procedure apigetpre;
begin//
end;

procedure apiputpre;
begin//
end;

//iput

// ------- api initialization -------

procedure initapiprims;
begin //
      idxsuper:=newindex('super');
      idxget:=newindex('get');
      idxput:=newindex('put');
      idxremove:=newindex('remove');
      //
      idxnew:=newindex('new');
      idxas:=newindex('as');
      //
      idxipr:=newindex('interpreter');//???
      //
end;

procedure initapi(mc,ms: int64);//mp?
begin maxcell:=mc;
      maxstack:=ms;
      //
      freelist:=xnil;
      identlist:=xnil;
      prefixlist:=xnil;
      indexdict:=xnil;
      //
      freeid:=xnil;
      cstack:=xnil;
      cref:=xnil;
      etop:=xnil;
      efun:=xnil;
      einf:=xnil;
      mstack:=xnil;//position?
      mdict:=xnil;
      trail:=xnil;
      impref:=xnil;
      eptr:=0;   //maxstack
      //;
      try setlength(cell,maxcell+1);
          setlength(infix,maxcell+1);
          setlength(cebit,maxcell+1);
          setlength(estack,maxstack+1);
      except //...
             raise exception.create(enomemoryerror)//
      end;
      estack[0]:=xnil;   // eptr = 0 f�r default
      initfreelist;
      initxidents;
      //
end;

procedure freeallcells;
var i: cardinal;
begin for i:=0 to maxcell do begin
          tinf:=infix[i];
          if (tinf=xstring) then dispose(cell[i].pstr);
          if (tinf=xarray) then begin
             if (cell[i].aref<>nil) then cell[i].aref^:=nil;//begin?
             dispose(cell[i].aref)//bei nil?
          end;
          infix[i]:=xnull//
      end//
end;

procedure finalapi;
begin freeallcells;
      maxcell:=0;
      maxstack:=0;
      //
      cell:=nil;
      infix:=nil;
      cebit:=nil;
      estack:=nil;
      eptr:=0;
      //
      freelist:=xnil;
      identlist:=xnil;
      prefixlist:=xnil;
      indexdict:=xnil;
      //
      freeid:=xnil;
      cstack:=xnil;
      cref:=xnil;
      etop:=xnil;
      efun:=xnil;
      einf:=xnil;
      mstack:=xnil;//position?
      mdict:=xnil;
      trail:=xnil;
      impref:=xnil;
      //
end;

end.


// (CC-BY-3.0-DE) Fpstefan
