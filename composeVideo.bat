@echo off
cd videoParts
dir /b | findstr /r "audio[0123456789]*\.mp3" > temp.txt
node -e "const fs=require(\"fs\");let f=fs.readFileSync(\"temp.txt\");f=f.toString();while(f.indexOf(\"\r\n\")!=-1){f=f.replace(\"\r\n\",\" \");}while((/(?<!-i )audio\d*\.mp3/g).exec(f)!=null){f=f.replace((/(?<!-i )audio(?=\d*\.mp3)/g),\"-i audio\")};fs.writeFileSync(\"temp.txt\",f);"
set /p audioFiles=<temp.txt
del temp.txt
ffmpeg %audioFiles% -filter_complex amix=inputs=2:duration=longest audioMerged.mp3
ffmpeg -i withoutAudio.mp4 -i audioMerged.mp3 -c:v copy -c:a aac final.mp4
move final.mp4 ../final.mp4
del /Q *
cd ..
rmdir /Q videoParts