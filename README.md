# BROMS1D - tool to compile s1disasm
**BROMS1D** — это инструмент для компилирования Соника 1 для использования (В СУГОБО ОБРАЗОВАТЕЛЬНЫХ ЦЕЛЯХ!)
Основан на:
- [s1disasm](https://github.com/sonicretro/s1disasm) — дизассемблер исходного кода Sonic 1.
- [asm68k](https://github.com/GreyLimit/asm68k) — компилятор ассемблера для Motorola 68000.

## 📥 Установка
1. Клонируйте репозиторий:
   ```sh
    git clone https://github.com/sonicretro/s1disasm.git
    cd s1disasm
    git clone https://github.com/K2254IVV/BROMS1D.git
    # Копируем файлы из BROMS1D в корень s1disasm
    mv BROMS1D/buildROM.bat .
    mv BROMS1D/buildROM.lua .
    # Создаем папку build_tools, если её нет, и копируем asm68k
    mkdir -p build_tools
    mv BROMS1D/build_tools/asm68k/ build_tools/
    # Удаляем временную папку (опционально)
    rm -rf BROMS1D
    echo "Успешно установлено! Теперь можно запускать buildROM.bat"
   ```
это для линукс а теперь к Windows:
   ```bat
@echo off
SETLOCAL EnableDelayedExpansion

:: BROMS1D Installer for Windows
:: Автоматически клонирует s1disasm и BROMS1D, копирует нужные файлы

echo [*] Устанавливаем BROMS1D...
echo.

:: Проверяем наличие git
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Ошибка: Git не установлен или не добавлен в PATH
    echo     Скачайте здесь: https://git-scm.com/download/win
    pause
    exit /b 1
)

:: 1. Клонируем s1disasm
if not exist "s1disasm\" (
    echo [1] Клонируем s1disasm...
    git clone https://github.com/sonicretro/s1disasm.git
    if %errorlevel% neq 0 (
        echo [!] Ошибка при клонировании s1disasm
        pause
        exit /b 1
    )
)

cd s1disasm

:: 2. Клонируем BROMS1D
if not exist "BROMS1D\" (
    echo [2] Клонируем BROMS1D...
    git clone https://github.com/K2254IVV/BROMS1D.git
    if %errorlevel% neq 0 (
        echo [!] Ошибка при клонировании BROMS1D
        pause
        exit /b 1
    )
)

:: 3. Копируем файлы
echo [3] Копируем необходимые файлы...

if exist "BROMS1D\buildROM.bat" (
    copy /Y "BROMS1D\buildROM.bat" .
) else (
    echo [!] Файл buildROM.bat не найден в BROMS1D
    pause
    exit /b 1
)

if exist "BROMS1D\buildROM.lua" (
    copy /Y "BROMS1D\buildROM.lua" .
) else (
    echo [!] Файл buildROM.lua не найден в BROMS1D
    pause
    exit /b 1
)

:: Создаем папку build_tools, если её нет
if not exist "build_tools\" mkdir build_tools

if exist "BROMS1D\build_tools\asm68k\" (
    xcopy /E /I /Y "BROMS1D\build_tools\asm68k" "build_tools\asm68k\"
) else (
    echo [!] Папка asm68k не найдена в BROMS1D/build_tools/
    pause
    exit /b 1
)

:: 4. Очистка (опционально)
echo [4] Очистка...
rd /s /q BROMS1D 2>nul

echo.
echo [✓] Установка завершена успешно!
echo     Теперь можно запускать buildROM.bat
pause
   ```
