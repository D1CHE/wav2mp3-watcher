# wav2mp3-watcher
wav2mp3-watcher is a program that watches a folder for wav files and converts them to mp3 files.

Use like this:</br>
<code>./init <watchfolder_path> <path_to_check> <logfile_path></code>

<code><watchfolder_path></code> is the watchfolder that's being scanned for wav files.</br>
<code><path_to_check></code> is a portion of the path a file should start with before being processed. This feature was created to make sure no file outside the specified <watchfolder_path> is processed.</br>
<code><logfile_path></code> is the location of the logfile that will be written.