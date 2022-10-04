#include "walkthrough.h"

int main()
{
  for(int seed{0}; seed != 100; ++seed)
  {
    const Character character{GetBestCharacter()};
    const bool silent{true};
    const std::vector<int> route{GetWinningRoute()};
    Walkthrough w(seed, character,silent,route);
    const Character final{w.Run()};
    assert(!final.IsDead());
  }
}
