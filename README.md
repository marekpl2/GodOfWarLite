GodOfWarLite - Godot 4 prototype
==============================

Co dostaniesz:
- gotowy projekt Godot 4 (sceny, skrypty)
- prosta scena Main.tscn z graczem i spawnerem przeciwników
- skrypty: Player.gd, Enemy.gd, Spawner.gd
- instrukcje jak zbudować gotowy .exe lokalnie i jak automatyzować build przez GitHub Actions

WAŻNE: Ten pakiet NIE zawiera skompilowanego pliku .exe (nie mogę tworzyć binarek w tej sesji).
Poniżej znajdziesz proste instrukcje, jak otrzymać plik .exe bez instalacji na Twoim komputerze:
OPCJA A — Poproś wykonawcę (np. freelancer) aby:
  1. Sklonował repozytorium (albo rozpakował tę paczkę).
  2. Zainstalował Godot 4.x (edytor).
  3. Otworzył projekt i wyeksportował projekt do Windows (Export -> Windows Desktop -> .exe).
  4. Wysłał Ci wynikowy zip (exe + _data folder).

OPCJA B — Zautomatyzować build w chmurze (GitHub Actions):
  - Stwórz repo na GitHub i wypchnij pliki projektu.
  - Dodaj workflow GitHub Actions (.github/workflows/build.yml) (przykład poniżej).
  - Aktywuj Actions -> uruchom workflow -> pobierz artefakt (gotowe .zip z .exe).
  - Szczegóły i przykładowy workflow znajdziesz w pliku .github/workflows/build.yml w tym pakiecie.

Jak uruchomić lokalnie po otrzymaniu exe:
1. Rozpakuj otrzymany zip.
2. Kliknij dwukrotnie GodOfWarLite.exe — gra powinna się uruchomić.

Sterowanie:
- WASD: poruszanie
- Mysz: obrót kamery
- LPM: atak
- Spacja: skok
- Esc: wyjdź (wysuń kursor)

Chcesz, żebym przygotował także w pełni skonfigurowany workflow GitHub Actions i instrukcję krok-po-kroku jak utworzyć repo i pobrać artefakt? Napisz: "Tak, przygotuj workflow".
