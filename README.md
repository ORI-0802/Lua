# InvaderGame on QSYS!!

A classic-style Invader Game implemented entirely on Q-SYS using Lua scripting and Q-SYS Designer!  
Enjoy the retro arcade feel with touch-panel interaction, sound effects, and a space-themed interface – all inside a Q-SYS environment.

## 🎮 Features

- Touch panel controls for **Left**, **Right**, and **Shoot**
- Timer-based gameplay (30 seconds)
- Score tracking and win/loss conditions
- Game start and reset buttons
- Sound effects and background music
- Can be Space-themed visuals with Star Wars-style icons 👾🐸

## 🛠 Requirements

- **Q-SYS Designer v9.13.0** or later
- **TSC-G3 series touch panel** (e.g., TSC-101-G3)
- TextController components for UI and game logic
- Audio Player components for BGM/SE (optional)
- Lua scripting enabled in Q-SYS

## 📦 Included Files

- `InvaderGame.qsys` – Main Q-SYS project file
- `InvaderGame_QSYS.lua` – Main game logic (if separate)
- `README.md` – This file

## 🔧 How to Use

1. Open `InvaderGame.qsys` in **Q-SYS Designer v9.13.0**.
2. Deploy the design to a Q-SYS Core with a connected TSC touch panel.
3. On the touch panel:
   - Press **Game Start** to begin.
   - Use **Left**, **Right**, and **Shoot** to play.
4. Game ends when:
   - Score reaches **1500** (You Win!)
   - Or timer reaches **0** (Game Over)

## 📋 Game Controls (on UCI)

| Control Name     | Description                      |
|------------------|----------------------------------|
| `LeftButton`     | Move the player left 🡐          |
| `RightButton`    | Move the player right 🡒         |
| `ShootButton`    | Fire a shot                      |
| `GameStartButton`| Begin a new game                 |
| `ResetButton`    | continue the game state             |
| `TimerDisplay`   | Shows remaining time             |
| `ScoreOutput`    | Displays current score           |
| `TextOutput`     | Game field (enemy/player layout) |

## 🚀 Future Plans

- Multi-level support
- Sound toggle option
- High score tracking

## 📸 Screenshot (optional)
<img width="364" alt="Game" src="https://github.com/user-attachments/assets/a922fc5f-4dcd-425b-a4bb-985e7090679c" />
> ![image](https://github.com/user-attachments/assets/1c131a7d-2945-4b44-90ef-37f7a73083b9)


## 📄 License

License.txt

---

Created with ❤️ by [MotokiOrikasa]

