# GORD Tables — навык Claude Code для таблиц в стиле GORD Agency

Навык (skill) для [Claude Code](https://claude.ai/code): собирает **Excel-таблицы и
Google Таблицы в фирменном стиле PR-агентства GORD** — сверху логотип GORD, шрифт
Geologica, красная линейка, серая шапка, статусы выпадающим списком с подсветкой.
Структура листов повторяет эталонную таблицу проекта агентства: дашборд, смета,
план подготовки, контакты, логистика, тайминг, чек-листы, гости, разбор проекта, а
также медиалист, список блогеров, road map и публикации для отчётов.

Основан на репозитории методологии агентства
[kofyonerook210/GORD_PR_AGENCY](https://github.com/kofyonerook210/GORD_PR_AGENCY)
(визуальный стандарт, шрифт Geologica) и разборе эталонной Google-таблицы.

## Установка (1 минута)

В любом проекте в Claude Code выполнить две команды:

```
/plugin marketplace add firelacri-art/GORD_TABLES
/plugin install gord-tables@gord-tables
```

После этого навык доступен во всех сессиях. Проверить: `/gord-tables` или просто
попросить «собери смету мероприятия в нашем стиле».

Обновить до свежей версии: `/plugin update gord-tables@gord-tables`.

### Альтернатива без плагина — скопировать папку навыка

```bash
git clone https://github.com/firelacri-art/GORD_TABLES.git
mkdir -p ~/.claude/skills && cp -r GORD_TABLES/skills/gord-tables ~/.claude/skills/
```

Или в конкретный проект: `cp -r GORD_TABLES/skills/gord-tables <проект>/.claude/skills/`.
То же самое делает `./install.sh` (личная установка) / `./install.sh --project`.

### Зависимости

```bash
pip install openpyxl Pillow
```

Для визуальной проверки (`--render`) дополнительно LibreOffice и `pip install pypdfium2`.

## Как пользоваться

Просто описать задачу Claude:

> Собери таблицу проекта для «Novikov: аукцион Yoomoota» в нашем стиле — дата
> 4 сентября, PR-менеджер Кристина, смета: фуд-фотограф 18 000, ведущий 150 000…

Claude напишет JSON-спецификацию, соберёт `.xlsx` генератором, проверит логотип,
шрифт и шапку на каждом листе и отдаст файл. Для Google Таблиц — импортировать
xlsx (Файл → Импортировать), стиль переносится без потерь; подробности в
[skills/gord-tables/references/google-sheets.md](skills/gord-tables/references/google-sheets.md).

Ручной запуск генератора:

```bash
python3 skills/gord-tables/scripts/build_gord_table.py --presets                      # список пресетов
python3 skills/gord-tables/scripts/build_gord_table.py --example event-project out.xlsx  # эталон из 11 листов
python3 skills/gord-tables/scripts/build_gord_table.py spec.json out.xlsx               # своя спецификация
python3 skills/gord-tables/scripts/verify_gord_table.py out.xlsx --render               # проверка + PNG
```

## Что внутри

```
GORD_TABLES/
├── .claude-plugin/
│   ├── plugin.json            # манифест плагина
│   └── marketplace.json       # чтобы репозиторий можно было добавить как marketplace
├── skills/gord-tables/
│   ├── SKILL.md               # инструкция для Claude: когда и как применять
│   ├── references/
│   │   ├── gord-table-style.md   # измеренная спецификация стиля (сетка, цвета, шрифты)
│   │   ├── sheet-catalog.md      # формат JSON и каталог пресетов листов
│   │   └── google-sheets.md      # перенос в Google Таблицы
│   ├── scripts/
│   │   ├── build_gord_table.py   # генератор xlsx
│   │   ├── verify_gord_table.py  # проверка стиля + рендер
│   │   └── examples/             # event-project, monthly-report, simple-plan
│   └── assets/
│       ├── gord-logo.png         # логотип (прозрачный PNG)
│       └── fonts/Geologica-VariableFont.ttf   # корпоративный шрифт (OFL)
├── install.sh
├── requirements.txt
└── LICENSE
```

## Стиль в двух словах

| Элемент | Значение |
| --- | --- |
| Логотип | `gord-logo.png` в A1–A2 каждого листа, ≈ 88×44 px (на дашборде 125×63) |
| Шрифт | Geologica: заголовок листа 14 Bold, шапка 10 Bold, ячейки 9 |
| Акцент | `#D72410` — линейка под логотипом или рамка названия проекта, один на лист |
| Шапка | заливка `#F3F3F3`, по центру, перенос, тонкие чёрные рамки |
| Статусы | выпадающий список + цвет: зелёный готово, жёлтый в работе, красный проблема |
| Числа / даты | `316 272 358`, `21.07.2026`, `19:30` |

Полная спецификация — [skills/gord-tables/references/gord-table-style.md](skills/gord-tables/references/gord-table-style.md).

## Лицензия

Код — MIT. Шрифт Geologica — [SIL Open Font License 1.1](skills/gord-tables/assets/fonts/OFL.txt).
Логотип GORD Agency принадлежит агентству и включён для оформления его документов.
