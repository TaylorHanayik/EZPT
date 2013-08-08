function plef(filename,s)
% PLEF "Print Last Error to File"
%
% plef prints the last error message issued by Matlab, including a complete
% backtrace of the call-sequence of functions that led to the error
% condition. Each line in the backtrace includes M-Filename and line number
% and allows you to open that file on the specified line by simply clicking
% on it with the mouse.
%
% plef is only supported on Matlab version 7 (Release 14 service pack 3) and later.
%
% Usage:
% plef     - Print last error, as contained in error structure 'psychlasterror'.
% plef(s)  - Print error and backtrace contained in error structure 's'.
%
% Copyright: This implementation of 'ple' is a slightly modified derivate of
% the original public domain implementation of ple.m by Malcolm Wood (the MathWorks).
%
% The original file can be downloaded from Matlab Central at:
% http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=
% 9525&objectType=file
%
% Thanks to David Fencsik for pointing us to this useful file and Malcolm
% Wood for writing it.
%

% History:
% 10/17/06 Derived from ple.m by MK.
% 4/27/12 Added the ability to print this info to file TH. DG.

% Error structure s provided?
dateoflog = fix(clock);
datestring=sprintf('%s%s%s%s%s%s',num2str(dateoflog(1)),num2str(dateoflog(2)),num2str(dateoflog(3)),num2str(dateoflog(4)),num2str(dateoflog(5)),num2str(dateoflog(6)));

if nargin<1
    filename = sprintf('ErrorLog%s.txt',datestring);
end
if nargin<2
    % No. Fetch it from psychlasterror.
    s = psychlasterror;
end
fid = fopen(filename, 'w');
if dateoflog(4)<12
    ampm='AM';
else
    ampm='PM';
end
if dateoflog(4)==13
    dateoflog(4)=1;
end
if dateoflog(4)==14
    dateoflog(4)=2;
end
if dateoflog(4)==15
    dateoflog(4)=3;
end
if dateoflog(4)==16
    dateoflog(4)=4;
end
if dateoflog(4)==17
    dateoflog(4)=5;
end
if dateoflog(4)==18
    dateoflog(4)=6;
end
if dateoflog(4)==19
    dateoflog(4)=7;
end
if dateoflog(4)==20
    dateoflog(4)=8;
end
if dateoflog(4)==21
    dateoflog(4)=9;
end
if dateoflog(4)==22
    dateoflog(4)=10;
end
if dateoflog(4)==23
    dateoflog(4)=11;
end
if dateoflog(4)==24
    dateoflog(4)=12;
end

if isempty(s.message)
   fprintf(1,'No error message stored\n');
   fprintf(fid,'No error message stored\n');   
   return;
end
fprintf(fid,'Date: %d-%d-%d || Time: %d:%d:%d %s',dateoflog(1),dateoflog(2),dateoflog(3),dateoflog(4),dateoflog(5),dateoflog(6),ampm);
fprintf(fid,'\n');
fprintf(fid,'\n');
fprintf(fid,'Last Error:');
fprintf(fid,'\n');
fprintf(fid,'___________');
fprintf(fid,'\n\n%s (%s)\n',s.message,s.identifier);
fprintf(fid,'\n');
fprintf(1,'Last Error: %s (%s)\n',s.message,s.identifier);


% Do we have a stack?
if ~isfield(s, 'stack')
    % Nope. This is not Matlab 7 or later. We're done.
    fprintf(1,'Error message does not contain a stack.\n');
    fprintf(fid,'Error message does not contain a stack.\n');
    return;
end

% Stack available. Pretty print a nice backtrace.
for i=1:numel(s.stack)
   e = s.stack(i);
   ff = which(e.file);
   [ignore_dir,command] = fileparts(ff);
   n = e.name;
   href = sprintf('matlab:opentoline(''%s'',%d)',ff,e.line);
   if strcmp(command,n)
       % main function in this file
       fprintf(fid,'Where the error occured:');
       fprintf(fid,'\n');
       fprintf(fid,'________________________');
       fprintf(fid,'\n');
       fprintf(fid,'\n');
       fprintf(fid,'%s line: %d\n',ff,e.line);
       fprintf(1,'<a href="%s">%s,%d</a>\n',href,ff,e.line);
   else
       % subfunction in this file
       fprintf(fid,'Where the error occured:');
       fprintf(fid,'\n');
       fprintf(fid,'\n');
       fprintf(fid,'\n');
       fprintf(fid,'%s\n %s line: %d\n',ff,n,e.line);
       fprintf(1,'<a href="%s">%s >%s,%d</a>\n',href,ff,n,e.line);
   end
end
fprintf(1,'\n');
fprintf(fid,'\n');