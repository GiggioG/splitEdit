@echo off
mkdir videoParts
ffprobe rawVideo.mkv -show_entries format=nb_streams -v 0 -of compact=p=0:nk=1 > temp.txt
set /p tr=<temp.txt
del temp.txt
set /a tr=%tr%-1
echo %tr% audio tracks found
:loops
ffmpeg -i rawVideo.mkv -vn -map 0:%tr% videoParts\audio%tr%.mp3
set /a tr=%tr%-1
if %tr% lss 1 goto exit
goto loops
:exit
ffmpeg -i rawVideo.mkv -an videoParts\withoutAudio.mp4