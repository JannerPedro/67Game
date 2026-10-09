# 6-7 ARCADE

> A 90s-arcade booth game: **how many 6-7s can you do in 30 seconds?**
> Your webcam and AI pose tracking count every 6-7. The top 5 players, with their photos, stay in the Hall of Fame.

Built for event booths and kiosks, but fun at home too. It runs entirely in the browser, **offline**, and nothing is ever uploaded.

Based on the idea of [67counter](https://github.com/mannygonzalezj7/67counter) (MediaPipe elbow and wrist tracking). See [CREDITS.md](CREDITS.md).

---

## Table of contents
1. [Features](#features)
2. [System requirements](#system-requirements)
3. [Installation](#installation)
4. [Running the game](#running-the-game)
5. [How to play](#how-to-play)
6. [Operator guide (Calibrate)](#operator-guide-calibrate)
7. [Keyboard shortcuts](#keyboard-shortcuts)
8. [Storage and privacy](#storage-and-privacy)
9. [Troubleshooting](#troubleshooting)
10. [Development](#development)
11. [Project layout](#project-layout)
12. [Credits and license](#credits-and-license)

---

## Features
- **Full game flow:** menu → username → automatic photo → preview → countdown → 30-second round → results → leaderboard.
- **Pose-tracked scoring** with MediaPipe PoseLandmarker. No special hardware, just a webcam.
- **Anti-cheat counting:** waving one arm scores nothing. Both hands must pump in opposite directions.
- **Calibrate screen** for the operator: live skeleton, tracking bars, framing hints, a live meter and sensitivity tuning.
- **Hall of Fame:** top 5 scores with photos. Only the top 5 photos are stored. Everyone else's photo is discarded.
- **90s arcade look:** pixel font, neon colours, scanlines, CRT glow and chiptune music.
- **Game feel:** floating 6/7 popups, "ON FIRE" combos, milestone callouts, "NEW HIGH SCORE" alert and a last-5-seconds timer.
- **Kiosk-ready:** one-click launcher, fullscreen, auto-return to menu when a player walks away.
- **Works offline** once installed. The model, font and music are all stored locally.

## System requirements

| | Minimum | Recommended |
|---|---|---|
| **OS** | Windows 10, macOS 12 or Linux (any modern OS with Chrome or Edge) | Windows 11 |
| **Browser** | Chrome or Edge 113+ | Latest Chrome or Edge |
| **CPU** | Dual-core, 2.0 GHz | Quad-core or better |
| **GPU** | Any with WebGL 2 (tracking falls back to CPU) | Dedicated or modern integrated GPU |
| **RAM** | 4 GB | 8 GB |
| **Camera** | Any webcam, 720p at 30 fps | 1080p, good low-light performance |
| **Display** | 1280×720 | 1920×1080 (the layout fills the screen) |
| **Audio** | Speakers (music and sound effects) | |
| **Disk** | About 400 MB (mostly `node_modules`) | |
| **Node.js** | 20 or newer (to install and build) | Latest LTS |

Notes:
- The camera only works on `localhost` or HTTPS. The included launcher uses `localhost`.
- Firefox and Safari are not tested. Use Chrome or Edge.
- No internet is needed to play, only to run `npm install` the first time.

**Space and lighting at the booth:**
- Player stands **1.5–2.5 m** from the camera, with the upper body and **both elbows in frame**.
- Light the player from the front. Avoid a bright window or light behind them.
- Avoid people walking behind the player. Only one person is tracked at a time.

## Installation

### 1. Install Node.js
Download the **LTS** version from <https://nodejs.org>, or on Windows:
```powershell
winget install OpenJS.NodeJS.LTS
```
Check it worked (open a new terminal first):
```
node --version
```

### 2. Get the code
```
git clone https://github.com/JannerPedro/67Game.git
cd 67Game
```
Or download the ZIP from GitHub and unzip it.

### 3. Install dependencies
```
npm install
```
This also copies the MediaPipe runtime into `public/mediapipe/wasm` automatically.

That's it. The pose model (`public/mediapipe/pose_landmarker_lite.task`) and the music (`public/audio/`) are already included in the repository.

## Running the game

### Option A: Booth / kiosk (Windows)
Double-click **`START-GAME.bat`**. It builds the game (a couple of seconds), starts a local server and opens the browser in full-screen kiosk mode.
Press `Alt+F4` to leave kiosk mode, and close the minimized "6-7 ARCADE server" window to stop the server.

### Option B: Any OS, from the terminal
```
npm run build
npm run preview
```
Then open <http://localhost:5173> in Chrome or Edge and press `F` for fullscreen.

### Option C: Development mode
```
npm run dev
```
The first time, the browser asks for **camera permission**. Click **Allow**.

> Click anywhere or press any key once after opening the game. Browsers block music until the first interaction.

## How to play

1. **Start Game** on the menu (Enter or click).
2. **Type your name** (2–12 characters) and press **Enter**.
3. **Strike a pose!** A 3-2-1 countdown runs, then a photo is taken automatically.
4. **Preview:** check your photo and name. Press **Retake** (`R`) or **Ready**. It starts by itself after 8 seconds.
5. **3-2-1-6-7!** The round begins. Your photo and name are shown in the top-right corner.
6. **Do as many 6-7s as you can in 30 seconds.**
7. **Results:** see your score, your rank (for example "#7 of 132"), your speed, and whether you made the top 5.
8. **Hall of Fame:** the top 5 with photos. If you didn't make it, your own row is shown below with how many more points you needed.

### What counts as a 6-7?
Hold both hands up, palms up, and pump them in opposite directions, like the meme:

```
  left hand UP, right hand DOWN   →  "6"
  right hand UP, left hand DOWN   →  "7"   = 1 point
  left hand UP again...           →  next "6"
```

- A point is scored each time you complete a **6 then 7**.
- Both hands must move. Waving just one arm does not score.
- Both arms must stay in the camera picture. If the tracker loses you, a **"SHOW BOTH ARMS!"** warning appears.
- Distance doesn't matter much. Movement is measured relative to your shoulder width.

### Bonuses and callouts
- **ON FIRE** when you hit 5 points within 2 seconds.
- Callouts at **10, 23, 40, 50, 67, 100 and 150** points.
- **NEW HIGH SCORE** the moment you pass the current #1.
- The timer turns red for the last 5 seconds.

## Operator guide (Calibrate)

Open **Calibrate** from the menu, or press `Ctrl+Shift+C` from any screen. Use it before an event to check the camera can see the 6-7 motion.

| Item | What it does |
|---|---|
| **Framing message** | Tells you if the player is placed well: COME CLOSER, STEP BACK, SHOW BOTH ARMS, or LOOKING GOOD. |
| **Skeleton overlay** | Shows what the AI sees. Arms are drawn in pink. |
| **Landmark bars** | Visibility of both shoulders, elbows and wrists. Green means tracked. |
| **Meter** | The live difference between hand heights. In Alternate mode the green marker must cross **both** yellow lines to score. |
| **Test count** | Counts 6-7s so you can test with a volunteer. **Reset count** clears it. |
| **Camera** | Choose which webcam to use. |
| **Mode** | *Alternate* (recommended) or *Classic* (the original 67counter rule: +1 when the right wrist rises above the right elbow). |
| **Threshold** | Lower is easier to score, higher is stricter. Default 0.30. If real players score too little, lower it. If it counts too much, raise it. |
| **Round length** | 15, 30, 45 or 60 seconds. |
| **Volume / Mirror** | Music and effects volume, and mirrored camera view. |
| **Reset leaderboard** | Deletes all scores and photos. Click twice to confirm. |

All settings are saved on the machine.

**Quick calibration routine:**
1. Open Calibrate and have a volunteer stand at the play position.
2. Wait for **LOOKING GOOD!** and all landmark bars green.
3. Ask them to do 10 slow 6-7s. The test count should read about 10.
4. Adjust the Threshold if needed. Check that waving one arm does not count.
5. Reset the leaderboard if you did test games, then go back to the menu.

## Keyboard shortcuts

| Key | Action |
|---|---|
| `Enter` | Confirm / press the focused button |
| Arrow keys | Move between buttons |
| `Esc` | Back to the menu |
| `F` | Toggle fullscreen |
| `M` | Mute / unmute |
| `R` | Retake photo (on the preview screen) |
| `Ctrl+Shift+C` | Open Calibrate from anywhere |

The name, preview and leaderboard screens time out back to the menu, so the booth resets itself if a player walks away.

## Storage and privacy
- Everything is stored in the browser's **localStorage** on the booth machine. **Nothing is uploaded**, and there are no accounts or servers.
- Only the **top 5** photos are kept (192×192 JPEG, about 15 KB each). When a new player pushes someone out of the top 5, that photo is deleted. Players who never reach the top 5 never have a photo saved. A score of 0 is never saved to the Hall of Fame.
- A small score-only history (no photos, up to 1000 entries) is kept to show "RANK #N OF M".
- The camera feed is processed in the browser and is never recorded or sent anywhere.
- To wipe everything, use **Reset leaderboard** in Calibrate, or clear the site data in the browser.

> Because data lives in one browser on one machine, always use the **same browser and the same address** (`http://localhost:5173`) so the Hall of Fame carries over between sessions.

## Troubleshooting

| Problem | Fix |
|---|---|
| **"CAMERA PERMISSION DENIED"** | Click the camera icon in the address bar, allow it, then reload. In kiosk mode, press `Alt+F4`, then start it again and allow the camera. |
| **"NO CAMERA FOUND"** | Plug in a webcam, then reload. Pick the right camera in Calibrate. |
| **"CAMERA IS BUSY"** | Close other apps using the webcam (Zoom, Teams, OBS, the Windows Camera app). |
| **No music** | Click or press a key once. Browsers block audio until the first interaction. Also check `M` (mute) and the volume in Calibrate. |
| **Tracking is slow or choppy** | Close other programs and browser tabs. Check the FPS in Calibrate. Under 15 fps shows a warning. Improve the lighting. |
| **Score too low / nothing counts** | Check Calibrate: all bars green? Is the player 1.5–2.5 m away? Lower the **Threshold**. Make sure both elbows are in frame. |
| **Counts when it shouldn't** | Raise the **Threshold**. Make sure only one person is in front of the camera. |
| **Wrong person tracked** | Only one person is tracked. Keep the background clear and let the player stand closest to the camera. |
| **Leaderboard is empty after restart** | You opened a different address or browser. Always use `http://localhost:5173` in the same browser. |
| **`npm` is not recognized** | Install Node.js, then open a **new** terminal. |
| **Port 5173 already in use** | Close the other server or the old "6-7 ARCADE server" window. |
| **Tracker never loads** | Make sure `public/mediapipe/wasm` exists. Run `npm install` again to recreate it. |

## Development
```
npm install        # install dependencies and copy the MediaPipe runtime
npm run dev        # dev server with hot reload, http://localhost:5173
npm run build      # production build into dist/
npm run preview    # serve the production build
npm run lint       # ESLint
npm test           # gesture detector + leaderboard tests
```

**Tech stack:** React 19, Vite, [MediaPipe Tasks Vision](https://ai.google.dev/edge/mediapipe) (PoseLandmarker lite), WebAudio for sound effects, plain CSS for the arcade look.

**Tests:** `npm test` runs automated tests covering the 6-7 detector (alternating hands, one-arm waving, jitter, far-away players, sensitivity, both modes) and the leaderboard (top-5 trimming, photo deletion, ranks, ties, personal best).

## Project layout
```
START-GAME.bat          one-click booth launcher (Windows)
public/
  mediapipe/            pose model (+ wasm, created by npm install)
  audio/                background music
scripts/                wasm copy script and tests
src/
  App.jsx               screen flow and global keys
  engine/
    gesture.js          pure 6-7 detector (unit-tested)
    tracker.js          one webcam + one PoseLandmarker shared by all screens
    storage.js          top 5, score history, settings
    audio.js            music and synthesized 8-bit sound effects
  screens/              Menu, Calibrate, NameEntry, PhotoCapture, Preview,
                        Game, Results, LeaderboardScreen
  components/           CameraView, PlayerCard, Leaderboard
  styles.css            90s arcade theme
```

## Credits and license
- Original idea: [67counter](https://github.com/mannygonzalezj7/67counter) by mannygonzalezj7 and team.
- Music: Locomule and Wolfgang_ via [OpenGameArt](https://opengameart.org) (CC0). Font: Press Start 2P (OFL). Pose tracking: Google MediaPipe (Apache 2.0).
- Full details in [CREDITS.md](CREDITS.md).

No license file is included yet. Add one (for example MIT) if you want others to be able to reuse the code.
