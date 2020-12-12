//usr/bin/env true && clang++ -Werror -Wall -O3 -o day9 $0 && ./day9 ; rm -f day9 ; exit
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <cassert>
#include <vector>
#include <stdexcept>

typedef unsigned long long int Num;

unsigned long long int part1(std::vector<Num> &nums);

std::vector<Num> readNums();

unsigned long long int part2(const std::vector<Num> &nums, unsigned long long int part1Solution);

int main() {
    std::vector<Num> nums = readNums();
    auto part1Solution = part1(nums);
    std::cout << part1Solution << std::endl;
    auto part2Solution = part2(nums, part1Solution);
    std::cout << part2Solution << std::endl;
}

std::vector<Num> readNums() {
    std::ifstream file("day9-input.txt");

    if (!file.is_open())
        throw std::runtime_error("no solution found!");

    std::vector<Num> nums;
    for (std::string line; std::getline(file, line);) {
        std::istringstream str(line);
        Num n = 0;
        str >> n;
        nums.push_back(n);
    }
    return nums;
}

template<size_t MAX_SIZE = 25, typename N=Num>
class XmasRing {
public:
    bool push(N n) {
        if (!isValid(n))
            return false;
        currentSize = std::min(currentSize + 1, MAX_SIZE);
        position = (position + 1) % MAX_SIZE;
        content[position] = n;
        return true;
    }

private:
    bool isValid(N n) {
        if (currentSize < MAX_SIZE)
            return true;

        for (int i = 0; i < MAX_SIZE; i++)
            for (int j = 0; j < MAX_SIZE; j++)
                if (content[i] + content[j] == n)
                    return true;

        return false;
    }

    size_t currentSize = 0;
    size_t position = 0;
    N content[MAX_SIZE]{};
};

Num part1(std::vector<Num> &nums) {
    XmasRing<25, Num> xmasRing;
    for (auto &n: nums) {
        if (!xmasRing.push(n)) {
            return n;
        }
    }
    throw std::runtime_error("no solution found!");
}

unsigned long long int part2(const std::vector<Num> &nums, unsigned long long int part1Solution) {
    for (size_t i = 0; i < nums.size(); ++i) {
        Num sum = 0;
        for (size_t j = 0; i < nums.size() - i && sum < part1Solution; j++) {
            sum += nums[i + j];
            if (sum == part1Solution) {
                Num min = INT64_MAX, max = 0;
                for (size_t k = 0; k <= j; k++) {
                    min = std::min(min, nums[i + k]);
                    max = std::max(max, nums[i + k]);
                }
                return min+max;
            }
        }
    }
    throw std::runtime_error("no solution found!");
}
