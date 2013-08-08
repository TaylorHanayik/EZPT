function MakeNewStudy(studyname)
%
%MakeNewStudy('studyname')
%
%**studyname must be a string**
%
%MakeNewStudy will take the input variable 'studyname'
%and make a directory with the path:
%
%WIN C:\Users\Research\Documents\Studies\'studyname'\
%
%MAC /Users/Research/Documents/Studies/'studyname'/
%
%It will  then create the subfolders:
%
%...\'studyname'\scripts
%...\'studyname'\pictures
%...\'studyname'\video
%...\'studyname'\audio
%...\'studyname'\data
%...\'studyname'\extra
%
%It may be necessary upon first use to change the default
%studydir in this file so that the file browser does not open every time.
%copy and paste the following to the command window to do so: edit MakeNewStudy
%
%This script also uses the 'filesep' function
%so that it is platform independent (will work on MAC and WIN).
%
%If you are curious as to why exist==7 read the following:
%
% EXIST('A') returns:
%       0 if A does not exist
%       1 if A is a variable in the workspace
%       2 if A is an M-file on MATLAB's search path.  It also returns 2 when
%            A is the full pathname to a file or when A is the name of an
%            ordinary file on MATLAB's search path
%       3 if A is a MEX-file on MATLAB's search path
%       4 if A is a MDL-file on MATLAB's search path
%       5 if A is a built-in MATLAB function
%       6 if A is a P-file on MATLAB's search path
%       7 if A is a directory
%       8 if A is a Java class
%
%Last edited 5/3/12 TH.
f=filesep;
studydir = '/Users/Research/Documents/Studies/'; % specific to your machine

if exist(studydir)==7
    newdir = sprintf('%s%s',studydir,studyname);
    mkdir(newdir);
    if exist(newdir)==7
        mkdir(sprintf('%s%sscripts',newdir,f));
        mkdir(sprintf('%s%spictures',newdir,f));
        mkdir(sprintf('%s%svideo',newdir,f));
        mkdir(sprintf('%s%saudio',newdir,f));
        mkdir(sprintf('%s%sdata',newdir,f));
        mkdir(sprintf('%s%sextra',newdir,f));
    end
else
    if ismac
        studydir=uigetdir('/Users/','Choose where to make the new study folder...');
    else
        studydir=uigetdir('C:\','Choose where to make the new study folder...');
    end
    newdir = sprintf('%s%s%s',studydir,studyname,f);
    mkdir(newdir);
    if exist(newdir)==7
        mkdir(sprintf('%s%sscripts',newdir,f));
        mkdir(sprintf('%s%spictures',newdir,f));
        mkdir(sprintf('%s%svideo',newdir,f));
        mkdir(sprintf('%s%saudio',newdir,f));
        mkdir(sprintf('%s%sdata',newdir,f));
        mkdir(sprintf('%s%sextra',newdir,f));
    end
end


