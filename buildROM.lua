-- buildROM.lua
-- Автоматическая сборка Sonic 1 с asm68k от GreyLimit

local config = {
    asm68k_path = "build_tools/asm68k/asm68k.c",  -- Исполняемый файл (без .exe, если Linux/Mac)
    source_asm  = "sonic.asm",                  -- Главный ASM-файл
    output_rom  = "sonic1_built.bin",           -- Выходной ROM
    log_file    = "build_log.txt"               -- Файл логов
}

print("[Sonic 1 ASM Builder]")
print("Using GreyLimit's ASM68K")

-- Проверяем, существует ли ASM68K
local function file_exists(path)
    local f = io.open(path, "r")
    if f then
        f:close()
        return true
    end
    return false
end

if not file_exists(config.asm68k_path) then
    print("\nERROR: ASM68K not found at '" .. config.asm68k_path .. "'!")
    print("Download it from: https://github.com/GreyLimit/asm68k")
    os.exit(1)
end

-- Запускаем ассемблер
print("\nAssembling " .. config.source_asm .. "...")
local cmd = string.format('"%s" "%s" -o="%s"', config.asm68k_path, config.source_asm, config.output_rom)
print("CMD: " .. cmd)

-- Перенаправляем вывод в лог-файл
local exit_code = os.execute(cmd .. " > " .. config.log_file .. " 2>&1")

if exit_code ~= 0 then
    print("\nERROR: Assembly failed! (Code: " .. exit_code .. ")")
    print("Check " .. config.log_file .. " for details.")
    os.exit(1)
else
    print("\nSUCCESS! ROM saved as: " .. config.output_rom)
    os.exit(0)
end