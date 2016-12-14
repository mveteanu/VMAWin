unit FileOS;

interface

Function UseFile(name:String):boolean;              {Set name of LIBRARY file}
Function Lib_Reset(var fis:file;name: string):byte; {reset Library file to specified "KEY"}
Function Lib_FileSize:longint;
Function Lib_FileExist(name: string):boolean;

const Halt_Error   : string  = '';              { on exit, display an error message  }

implementation

const LIB_NAME  : string  ='';                  { name of LIBRARY file       }
      NEW_ID    : string  ='DFPv2';             { ID of library              }
      BLOCKSIZE = 60000;                        { blocksize to copy          }
      KEY_START : longint = 0;                  { start of current "FILE"    }
      KEY_SIZE  : longint = 0;                  { size of current "FILE"     }

{
/////////////////////////////////////////////////////////////////////////////////////////
//       Reset the library file to the start of the correct "FILE DATA"                //
//                                                                                     //
//        Expects: Name of file to search for in the library                           //
//        Returns: A error code wich is :  0  : no error                               //
//                                         1  : No file name specified                 //
//                                         2  : No key specified                       //
//                                         3  : Key to long, maximum of 8 characters   //
//                                         4  : Not a valid library file               //
//                                         5  : "KEY" not found                        //
/////////////////////////////////////////////////////////////////////////////////////////
}
FUNCTION LIB_RESET(var fis:file;name: string):byte;
VAR i          : integer;       {used as a counter}
    j          : integer;       {used as a second counter}
    match      : boolean;       {found a key ?}
    key        : string;        {Used to store the "directory" key}
    ID         : string[5];     {File ID, for checking the LIB file}
    ENTRY      : longint;       {amount of entries in the "directory"}
BEGIN
  LIB_RESET:=0;                 { no error as yet }
  if LIB_NAME=''           then begin LIB_RESET:=1; exit; end; {no library name}
  if name=''               then begin LIB_RESET:=2; exit; end; {no key specified}
  if length(name)>12       then begin LIB_RESET:=3; exit; end; {key to long}
  while length(name)<12 do name:=name+' ';  { make sure the key is 8 characters }
  for i:=1 to length(name) do name[i]:=upcase(name[i]);

  assign(fis , LIB_NAME); reset(fis,1);     {Open lib file}
  blockread(fis , ID[1], 5);                {Read the ID}
  id[0]:=#5;
  if id<>new_id then begin                  {Wrong ID}
       close(fis);                          {Close the file}
       LIB_RESET:=4;                        {not a VALID file}
       exit;                                {Exit this routine}
  end;
  blockread(fis , ENTRY, sizeof(entry));    {How many entries?}
  i:=1;
  repeat
      blockread(fis ,key[1], 12);                    {Let's see if we}
      blockread(fis, key_start, sizeof(key_start));  {can find the correct}
      blockread(fis, key_size,  sizeof(key_size));   {key...}
      key[0]:=#12;                                   {Length of the string}
      match:=true;
      if key<>name then match:=false;                {wrong key}
      inc(i);                                        {go to next key}
    until (i>entry) or match;
    if match then begin                          {Key found!}
       seek(fis,key_start);                      {Get positions}
    end else begin                               {Key not found}
       close(fis);                               {close the file}
       LIB_RESET:=5;                             {exit with an error}
    end;
END;


{
////////////////////////////////////////////////////////////////////
//        Set the file name of the LIBRARY file to use            //
//                                                                //
//        Expects: name of the library file                       //
//        Returns: TRUE if file exists, else FALSE                //
////////////////////////////////////////////////////////////////////
}
FUNCTION USEFILE(name:string):boolean;
VAR f : file;
BEGIN
 assign(f,name);                { open the file }
 {$I-}                          { set IO checking off }
  reset(f,1);                   { reset it }
 {$I+}                          { get IO checking back online }
 if ioresult<>0 then begin
    Halt_Error:='File not found. ('+name+')'; { Oops, no file found }
    USEFILE:=false;                           { UseFile is false }
 end else begin
    Usefile:=true;
    lib_name:=name;                           { set LIB_NAME correct }
    close(f);                                 { close the file }
 end;
END;

Function Lib_FileExist(name: string):boolean;
var f:file;
begin
 if Lib_Reset(f,name)<>0
  then Lib_FileExist:=false
  else begin Close(f);Lib_FileExist:=true;end;
end;


Function Lib_FileSize:longint;
begin
 Lib_FileSize:=KEY_SIZE;
end;

end.
