#/bin/bash
LOG_FILE=~/transmission-script.log
AUDIO_DEST=/Volumes/MediaStore/Audio/Library
MOVIE_DEST=/Volumes/MediaStore/Video/Unsorted
BACKUP_AUDIO_DEST=/Volumes/BitPit/music
BACKUP_MOVIE_DEST=/Volumes/BitPit/UnsortedMovies

echo "$TR_TIME_LOCALTIME Torent_Dir: $TR_TORRENT_DIR Torrent_Hash: $TR_TORRENT_HASH Torrent_Id: $TR_TORRENT_ID Torrent_Name: $TR_TORRENT_NAME" >> $LOG_FILE

# see if directory has 1 or more flac file
FLAC_COUNT=`find "$TR_TORRENT_DIR/$TR_TORRENT_NAME/." -iname "*.flac" | wc -l`
MP3_COUNT=`find "$TR_TORRENT_DIR/$TR_TORRENT_NAME/." -iname "*.mp3" | wc -l`
MP4_COUNT=`find "$TR_TORRENT_DIR/$TR_TORRENT_NAME/." -iname "*.mp4" | wc -l`
MKV_COUNT=`find "$TR_TORRENT_DIR/$TR_TORRENT_NAME/." -iname "*.mkv" | wc -l`
AVI_COUNT=`find "$TR_TORRENT_DIR/$TR_TORRENT_NAME/." -iname "*.avi" | wc -l`

echo "Searching for valid file types:"
echo "Flac Count: $FLAC_COUNT" >> $LOG_FILE
echo "MP3 Count: $MP3_COUNT" >> $LOG_FILE
echo "MP4 Count: $MP4_COUNT" >> $LOG_FILE
echo "MKV Count: $MKV_COUNT" >> $LOG_FILE
echo "AVI Count: $AVI_COUNT" >> $LOG_FILE

# copy torrent directory to music archive if it has at least one flac file in it
if [ $FLAC_COUNT -gt 0 ] || [ $MP3_COUNT -gt 0 ]
then
    cp -Rv "$TR_TORRENT_DIR/$TR_TORRENT_NAME" "$AUDIO_DEST" >> $LOG_FILE
    echo "Copy of audio files successful to primary drive." >> $LOG_FILE
    cp -Rv "$TR_TORRENT_DIR/$TR_TORRENT_NAME" "$BACKUP_AUDIO_DEST" >> $LOG_FILE
    echo "Copy of audio files successful to backup drive." >> $LOG_FILE
elif [ $MP4_COUNT -gt 0 ] || [ $MKV_COUNT -gt 0 ] || [ $AVI_COUNT -gt 0 ]
then
    cp -Rv "$TR_TORRENT_DIR/$TR_TORRENT_NAME" "$MOVIE_DEST" >> $LOG_FILE
    echo "Copy of movie files successful." >> $LOG_FILE
    cp -Rv "$TR_TORRENT_DIR/$TR_TORRENT_NAME" "$BACKUP_MOVIE_DEST" >> $LOG_FILE
    echo "Copy of movie files successful." >> $LOG_FILE
else
    echo "Unknown file types found for torrent. Skipping copy. $TR_TORRENT_NAME" >> $LOG_FILE
fi
