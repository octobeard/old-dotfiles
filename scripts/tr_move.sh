#/bin/bash
LOG_FILE=~/transmission-script.log
TORRENT_DEST=~/Desktop

echo "$TR_TIME_LOCALTIME Torent_Dir: $TR_TORRENT_DIR Torrent_Hash: $TR_TORRENT_HASH Torrent_Id: $TR_TORRENT_ID Torrent_Name: $TR_TORRENT_NAME" >> $LOG_FILE

# see if directory has 1 or more flac file
FLAC_COUNT=`find "$TR_TORRENT_DIR/$TR_TORRENT_NAME/." -iname "*.flac" | wc -l`
MP3_COUNT=`find "$TR_TORRENT_DIR/$TR_TORRENT_NAME/." -iname "*.mp3" | wc -l`

echo "Flac Count: $FLAC_COUNT" >> $LOG_FILE
echo "MP3 Count: $MP3_COUNT" >> $LOG_FILE

# copy torrent directory to music archive if it has at least one flac file in it
if [ $FLAC_COUNT -gt 0 ] || [ $MP3_COUNT -gt 0 ]
then
    cp -Rv "$TR_TORRENT_DIR/$TR_TORRENT_NAME" "$TORRENT_DEST" >> $LOG_FILE
    echo "Copy successful." >> $LOG_FILE
else
    echo "No audio files found for torrent. $FLAC_COUNT $MP3_COUNT Skipping copy. $TR_TORRENT_NAME" >> $LOG_FILE
fi

