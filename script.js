// Example functionality for tickets button (you can replace with real functionality)
document.querySelectorAll('button').forEach(button => {
    button.addEventListener('click', () => {
        console.log('Button clicked');
    });
});


const audioPlayer = document.getElementById('audio-player');
const playBtn = document.getElementById('play-btn');
const prevBtn = document.getElementById('prev-btn');
const nextBtn = document.getElementById('next-btn');
const currentSongElement = document.getElementById('current-song');

let songList = [
    "Nettspend-Nothing_Like_UuuThat One Song.mp3",
    "Kali_Uchis-After_The_Storm_ft._Tyler,_The Creator,_Bootsy Collins.mp3",
    "Chris Brown_-_No_Guidance_(Official Video)_ft._Drake.mp3"
];
let currentSongIndex = 0;

// Load a song and update the UI
function loadSong(index) {
    if (songList.length > 0) {
        audioPlayer.src = songList[index];
        currentSongElement.textContent = `Now Playing: ${songList[index].split('/').pop()}`;
        audioPlayer.load(); // Ensure the audio is loaded before playing
    }
}

// Play or pause the current song
function togglePlayPause() {
    if (audioPlayer.paused) {
        audioPlayer.play();
        playBtn.textContent = "Pause";
    } else {
        audioPlayer.pause();
        playBtn.textContent = "Play";
    }
}

// Play previous song
function playPreviousSong() {
    currentSongIndex = (currentSongIndex - 1 + songList.length) % songList.length;
    loadSong(currentSongIndex);
    audioPlayer.play();
    playBtn.textContent = "Pause";
}

// Play next song
function playNextSong() {
    currentSongIndex = (currentSongIndex + 1) % songList.length;
    loadSong(currentSongIndex);
    audioPlayer.play();
    playBtn.textContent = "Pause";
}

// Event listeners for buttons
playBtn.addEventListener('click', togglePlayPause);
prevBtn.addEventListener('click', playPreviousSong);
nextBtn.addEventListener('click', playNextSong);

// Handle end of song to automatically play the next one
audioPlayer.addEventListener('ended', playNextSong);

// Initially load the first song
loadSong(currentSongIndex);

// Set initial button text depending on whether the song is playing
audioPlayer.addEventListener('play', () => {
    playBtn.textContent = "Pause";
});

audioPlayer.addEventListener('pause', () => {
    playBtn.textContent = "Play";
});
