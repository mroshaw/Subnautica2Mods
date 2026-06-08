# Beginners Guide C++ Cheat Mod

Source code for the example C++ mod created with the Beginners Guide to Modding Subnautica 2.

## Building

You'll need Visual Studio and associated tooling to compile this mod. Everything is documented in the [Beginners Guide](https://subnautica2modding.github.io/beginners-guide/):

1. Follow the [setup instructions](https://subnautica2modding.github.io/beginners-guide/setting-up/) to install and configure:

   - UE4SS
   - Visual Studio
   - Rust

2. Open `BeginnersGuideCppCheatMod\CMakeLists.txt` in a text editor.

3. Amend the `GAME_MODS_DIR` property to point to your Subnautica 2 UE4SS mods folder. For example:

   ```
   set(GAME_MODS_DIR "E:/Games/Steam/steamapps/common/Subnautica2/Subnautica2/Binaries/Win64/ue4ss/Mods")
   ```

4. Save the changes to `CMakeLists.txt`

5. Run `scripts\refresh-solution.bat`

6. Open the `BeginnersGuideCppMod.slnx` Visual Studio solution file in `\Output`\

7. Right click the `BeginnersGuideCppCheatMod` project and select "Build"

