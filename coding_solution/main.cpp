#include <unordered_map>
#include <string>
#include <vector>
#include <algorithm>

/* 
This function will calculate the shortest time to unload containers given a list of container names and a wait time integer.
Paramaters:
    containers: std::vector<std::string>&
    m: int
Constrains:
    containers: any valid reference of std::vector<std::string>
    m: (0 <= m <= 2^31 - 1)
Output:
    an 32-bit  integer representing the time needed to unload containers
*/
int smallestTime(std::vector<std::string> &containers, int m)
{
    //no containers to unload, so time is just 0
    if (containers.empty())
    {

        return 0;
    }

    std::unordered_map<std::string, int> hashmap;

    //these are used for finding the container with most frequency
    int largest = 0;
    std::string mostFrequentContainer = "";

    //recording number of containers for each type(name)
    for (std::string &str : containers)
    {

        hashmap[str]++;

        if (hashmap[str] > largest)
        {

            //update most frequent
            largest = hashmap[str];
            mostFrequentContainer = str;
        }
    }

    //maximum idle time is bounded by the most frequent container
    //It will look like this
    // A ... A ... A... A
    //other containers will fill the gap in between
    unsigned long long maxIdleTime = (largest - 1) * static_cast<int>(m);

    //fill the idle gap as much as possible with other containers
    for (auto entry : hashmap)
    {

        //skip the most frequent one
        if (entry.first == mostFrequentContainer)
            continue;

        //max idle time will decrease by this amount
        int fillGap = std::min(largest - 1, entry.second);
        maxIdleTime -= fillGap;
    }

    //maxIdleTime can go under 0, so take max of these two
    return std::max(containers.size(), containers.size() + maxIdleTime);
}
