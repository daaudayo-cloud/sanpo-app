-- 散歩記録アプリ用データベース
-- データベース作成（postgres など別のDBに接続して実行）:
--   CREATE DATABASE "sanpo-app";
-- 以下は "sanpo-app" に接続して実行する。

-- =========================================
-- テーブル作成（参照される側を先に作成）
-- =========================================

CREATE TABLE walk_days (
    id   SERIAL PRIMARY KEY,
    date DATE NOT NULL
);

CREATE TABLE walks (
    id           SERIAL PRIMARY KEY,
    steps        INTEGER,
    distance     NUMERIC(6,2),
    walk_days_id INTEGER NOT NULL REFERENCES walk_days(id),
    memo         TEXT
);

COMMENT ON COLUMN walks.distance IS '距離(km)';

-- =========================================
-- サンプルデータ投入
-- =========================================

INSERT INTO walk_days (date) VALUES
    ('2026-11-22'),
    ('2026-11-23'),
    ('2026-11-24');

INSERT INTO walks (steps, distance, memo, walk_days_id) VALUES
    (4200, 3.10, '朝の川沿いコース',       1),
    (2800, 2.05, '夕方に近所を一周',       1),
    (8500, 6.30, '公園まで足をのばした',   2),
    (3600, 2.60, '通勤ついでに一駅歩いた', 3),
    (1900, 1.40, '夜の軽い散歩',           3);

-- =========================================
-- 確認用：結合して一覧を取得
-- =========================================

SELECT d.date AS 日付, w.id AS walk_id, w.steps AS 歩数,
       w.distance AS "距離(km)", w.memo AS メモ
FROM walk_days d
JOIN walks w ON w.walk_days_id = d.id
ORDER BY d.date, w.id;
