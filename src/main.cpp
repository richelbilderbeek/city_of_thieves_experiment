#include "walkthrough.h"

#include <cassert>
#include <iostream>

int main()
{
  const int n_runs{100};
  int n_dead{0};
  for(int seed{0}; seed != n_runs; ++seed)
  {
    const Character character{GetBestCharacter()};
    const bool silent{true};
    const std::vector<int> route{GetWinningRoute()};
    Walkthrough w(seed, character,silent,route);
    const Character final{w.Run()};
    if (final.IsDead()) ++n_dead;
  }
  std::cout << n_dead << "/" << n_runs << '\n';
}
