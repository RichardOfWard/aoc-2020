using System;
using System.IO;

namespace day11
{
    class Program
    {
        private const int Rows = 97;
        private const int Cols = 91;

        static void Main(string[] args)
        {
            var prevSeats = LoadInitial();

            var seats = new char[Rows, Cols];

            while (Tick(prevSeats, seats))
            {
                var tmp = prevSeats;
                prevSeats = seats;
                seats = tmp;
            }

            Console.WriteLine(Count(seats));
        }

        private static bool Tick(char[,] prevSeats, char[,] seats)
        {
            var changed = false;
            for (var row = 0; row < Rows; row++)
            {
                for (var col = 0; col < Cols; col++)
                {
                    var prevSeat = prevSeats[row, col];

                    seats[row, col] = prevSeat;
                    var occupied = 0;
                    for (var nRow = Math.Max(row - 1, 0); nRow < Math.Min(Rows, row + 2); nRow++)
                    {
                        for (var nCol = Math.Max(col - 1, 0); nCol < Math.Min(Cols, col + 2); nCol++)
                        {
                            if (prevSeats[nRow, nCol] == '#')
                            {
                                occupied += 1;
                            }
                        }
                    }

                    switch (prevSeat)
                    {
                        case 'L':
                        {
                            if (occupied == 0)
                            {
                                seats[row, col] = '#';
                                changed = true;
                            }

                            break;
                        }
                        case '#':
                        {
                            if (occupied > 4)
                            {
                                seats[row, col] = 'L';
                                changed = true;
                            }

                            break;
                        }
                    }
                }
            }

            return changed;
        }

        private static char[,] LoadInitial()
        {
            var file = new StreamReader("./day11-input.txt");
            string line;
            var seats = new char[Rows, Cols];
            var row = 0;
            while ((line = file.ReadLine()) != null)
            {
                for (var col = 0; col < Cols; col++)
                {
                    seats[row, col] = line[col];
                }

                row += 1;
            }

            return seats;
        }

        private static int Count(char[,] seats)
        {
            var count = 0;
            for (var row = 0; row < Rows; row++)
            {
                for (var col = 0; col < Cols; col++)
                {
                    if (seats[row, col] == '#')
                    {
                        count += 1;
                    }
                }
            }

            return count;
        }
    }
}
