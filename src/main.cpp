#include "walkthrough.h"

#include <cassert>
#include <iostream>

int main()
{
  // Best character: 8/1000 deaths
  // Worst character: 999/1000 deaths
  const int n_runs{1000};
  int n_dead{0};
  for(int seed{0}; seed != n_runs; ++seed)
  {
    const Character character{GetWorstCharacter()};
    const bool silent{true};
    const std::vector<int> route{GetWinningRoute()};
    Walkthrough w(seed, character,silent,route);
    const Character final{w.Run()};
    if (IsDead(final)) ++n_dead;
  }
  std::cout << n_dead << "/" << n_runs << '\n';
}
