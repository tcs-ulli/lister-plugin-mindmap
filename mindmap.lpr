library mindmap;

{$mode objfpc}{$H+}
{$include calling.inc}

uses
  Classes, sysutils, WLXPlugin,
  zipper;

procedure ListGetDetectString(DetectString:pchar;maxlen:integer); dcpcall;
begin
  StrCopy(DetectString, 'EXT="MMAP"|EXT="XMIND"|EXT="MM"');
end;

function ListGetText(FileToLoad:pchar;contentbuf:pchar;contentbuflen:integer):pchar; dcpcall;
var
  aFile: string;
begin
  aFile := FileToLoad;
  Result := '';
  case lowercase(ExtractFileExt(FileToLoad)) of
   '.mmap':
     begin

     end;
   '.mm': //Freemind
     begin

     end;
   '.xmind':
     begin

     end;
  end;
end;

function ListGetPreviewBitmapFile(FileToLoad:pchar;OutputPath:pchar;width,height:integer;
    contentbuf:pchar;contentbuflen:integer):pchar; dcpcall;
var
  UnZip: TUnZipper;
  FilePath: string;
  FileList: TStringList;
begin
  FilePath := OutputPath;
  UnZip := TUnZipper.Create;
  FileList := TStringList.Create;
  Result := '';
  case lowercase(ExtractFileExt(FileToLoad)) of
   '.mmap':
     begin
       try
         try
           FileList.Add('Preview.png');
           UnZip.OutputPath := FilePath;
           Unzip.UnZipFiles(FileToLoad,FileList);
         finally
           FreeAndNil(FileList);
           FreeAndNil(UnZip);
         end; //try
         Result := PChar(OutputPath+'Preview.png');
       except
       end;
     end;
   '.xmind':
     begin
       try
         try
           FileList.Add('Thumbnails/thumbnail.png');
           UnZip.OutputPath := FilePath;
           Unzip.UnZipFiles(FileToLoad,FileList);
         finally
           FreeAndNil(FileList);
           FreeAndNil(UnZip);
         end; //try
         Result := PChar(OutputPath+'Thumbnails'+DirectorySeparator+'thumbnail.png');
       except
       end;
     end;
  end;

  UnZip.Free;
  FileList.Free;
end;

exports
  ListGetDetectString,
  ListGetText,
  ListGetPreviewBitmapFile;

begin
end.

