-- 初期設定
FrameCount = 0
Score = 0
MAX_BULLETS = 20
MAX_ENEMIES = 15
SCREEN_WIDTH = 20
SCREEN_HEIGHT = 10
PlayerX = 10

BulletActive = {}
BulletY = {}
BulletXIndex = {}
EnemyX = {}
EnemyY = {}
EnemyAlive = {}

EnemyDirection = 1  -- +1:右へ, -1:左へ
GameTimeLimit = 30
RemainingTime = GameTimeLimit
GameStarted = false
CanStart = true


function initialize_game()
    FrameCount = 0
    Score = 0
    PlayerX = 10
    GameStarted = false
    CanStart = true
    RemainingTime = GameTimeLimit
    EnemyDirection = 1

    Controls.GameStart.String = "Game Start"

  APShoot = Component.New("ShootPlayer")
  APWin = Component.New("WinPlayer")
  APLose = Component.New("LosePlayer")
  APBGM = Component.New("BGMPlayer")

    for i = 1, MAX_BULLETS do
        BulletActive[i] = false
        BulletY[i] = 0
        BulletXIndex[i] = 0
    end

    for i = 1, MAX_ENEMIES do
        EnemyX[i] = ((i - 1) % 5) * 4 + 2
        EnemyY[i] = math.floor((i - 1) / 5) * 2 + 1
        EnemyAlive[i] = true
    end

    Controls.TextOutput.String = ""
    Controls.ScoreOutput.String = "SCORE: 0"
    Controls.TimerDisplay.String = tostring(GameTimeLimit)
    Controls.ResultDisplay.String = ""
    Controls.GameStart.String = "Game Start"
end

function shoot()
    if not GameStarted then return end
    for i = 1, MAX_BULLETS do
        if not BulletActive[i] then
            BulletActive[i] = true
            BulletY[i] = SCREEN_HEIGHT - 2
            BulletXIndex[i] = PlayerX
            break
        end
    end
end

function move_player(dir)
    if not GameStarted then return end
    if dir == "left" and PlayerX > 2 then
        PlayerX = PlayerX - 1
    elseif dir == "right" and PlayerX < 18 then
        PlayerX = PlayerX + 1
    end
end

function draw()
    local screen = {}
    local indent = string.rep(" ", 14)

    for y = 1, SCREEN_HEIGHT do
        screen[y] = indent .. string.rep(" ", SCREEN_WIDTH)
    end

  -- 宇宙背景の描画
  for y = 1, SCREEN_HEIGHT do
    screen[y] = indent .. string.rep(" ", SCREEN_WIDTH)
  end

  -- 星をランダムに移動させる -宇宙を表現-
  for y = 1, SCREEN_HEIGHT - 1 do
    for x = 1, SCREEN_WIDTH do
        if math.random() < 0.01 then -- 1%の確率で星を表示
            local row = screen[y]
            screen[y] = row:sub(1, x - 1) .. "*" .. row:sub(x + 1)
        end
    end
  end

    -- 敵再現
    for i = 1, MAX_ENEMIES do
        if EnemyAlive[i] then
            local x = EnemyX[i]
            local y = EnemyY[i]
            if x >= 1 and x <= SCREEN_WIDTH and y >= 1 and y <= SCREEN_HEIGHT then
                local row = screen[y]
                screen[y] = row:sub(1, x - 1) .. "M" .. row:sub(x + 1)
            end
        end
    end

    -- 弾再現
    for i = 1, MAX_BULLETS do
        if BulletActive[i] then
            local x = BulletXIndex[i]
            local y = BulletY[i]
            if x >= 1 and x <= SCREEN_WIDTH and y >= 1 and y <= SCREEN_HEIGHT then
                local row = screen[y]
                screen[y] = row:sub(1, x - 1) .. "|" .. row:sub(x + 1)
            end
        end
    end

    -- 自機再現
    if PlayerX >= 1 and PlayerX <= SCREEN_WIDTH then
        local row = screen[SCREEN_HEIGHT]
        screen[SCREEN_HEIGHT] = row:sub(1, PlayerX - 1) .. "A" .. (PlayerX < SCREEN_WIDTH and row:sub(PlayerX + 1) or "")
    end

    Controls.TextOutput.String = "\n" .. table.concat(screen, "\n")
    Controls.ScoreOutput.String = "SCORE: " .. tostring(Score)
end

function update()
    if not GameStarted then return end

    FrameCount = FrameCount + 1

    -- 弾移動と当たり判定
    for i = 1, MAX_BULLETS do
        if BulletActive[i] then
            BulletY[i] = BulletY[i] - 1
            if BulletY[i] <= 0 then
                BulletActive[i] = false
            else
                for j = 1, MAX_ENEMIES do
                    if EnemyAlive[j] then
                        local ex, ey = EnemyX[j], EnemyY[j]
                        local bx, by = BulletXIndex[i], BulletY[i]
                        if bx == ex and by == ey then
                            EnemyAlive[j] = false
                            BulletActive[i] = false
                            Score = Score + 100
                            break
                        end
                    end
                end
            end
        end
    end

    -- 敵移動（常時左右）
    local canMove = true
    for i = 1, MAX_ENEMIES do
        if EnemyAlive[i] then
            local newX = EnemyX[i] + EnemyDirection
            if newX < 1 or newX > SCREEN_WIDTH then
                canMove = false
                break
            end
        end
    end

    if canMove then
        for i = 1, MAX_ENEMIES do
            if EnemyAlive[i] then
                EnemyX[i] = EnemyX[i] + EnemyDirection
            end
        end
    else
        EnemyDirection = -EnemyDirection
    end

    -- タイマー処理
    if FrameCount % 10 == 0 then
        RemainingTime = RemainingTime - 1
        Controls.TimerDisplay.String = tostring(RemainingTime)
        if RemainingTime <= 0 then
            Controls.ResultDisplay.String = "Game Over!"
            stop_game()
        end
    end

    -- 勝利判定
    if Score >= 1500 then
        Controls.ResultDisplay.String = "YOU WIN!"
        stop_game()
    end

    draw()
end

function stop_game()
    GameStarted = false
end

-- タイマー設定
updateTimer = Timer.New()
updateTimer.EventHandler = function()
    update()
end
updateTimer:Start(0.1)

-- ボタンイベント
Controls.LeftButton.EventHandler = function()
    move_player("left")
end

Controls.RightButton.EventHandler = function()
    move_player("right")
end

Controls.ShootButton.EventHandler = function()
    shoot()
-----AudioPlayer Play trigger-----    
  APShoot.play:Trigger()
end 

Controls.GameStartButton.EventHandler = function()
    if CanStart and not GameStarted then
        GameStarted = true
        FrameCount = 0
        RemainingTime = GameTimeLimit
        Controls.GameStart.String = "Game is Starting now"
        CanStart = false
    end
end

Controls.ResetButton.EventHandler = function()
    initialize_game()
end

-- 初期化
initialize_game()
