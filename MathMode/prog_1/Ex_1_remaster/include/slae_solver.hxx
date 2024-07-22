#ifndef SLAE_SOLVER_HXX
#define SLAE_SOLVER_HXX

#include "library.hxx"
#include "math_vector.hxx"

template<typename U = double>
class Gauss
{
    public:
        Gauss() = default;
        ~Gauss() = default;

        void transposition (const int size_sys, const int row, const int row_max, const int col_max, std::vector<std::vector<U>>& matrix, std::vector<double>& vec)
        {
            if(row != row_max)
            {
                for(int temp_col = row; temp_col < size_sys; temp_col++)
                {
                    std::swap(matrix[row][temp_col], matrix[row_max][temp_col]);
                }
                std::swap(vec[row], vec[row_max]);

            }
            if( row != col_max)
            {
                for( int temp_row = row; temp_row < size_sys; temp_row++)
                {
                    std::swap(matrix[temp_row][row], matrix[temp_row][col_max]);
                }
                std::swap(vec[row], vec[col_max]);
            }
        }

        std::vector<std::vector<U>> get_Solution( std::vector<std::vector<U>>& matrix,
                                                  std::vector<U>& vec)
        {
            const int size_sys = vec.size();
            for(int row = 0; row < size_sys - 1; row++)
            {
                auto max_value = fabs(matrix[0][0]);
                int row_max = row;
                int col_max = row;

                for(int i = row; i < size_sys; i++)
                {
                    for(int j = row; j < size_sys; j++)
                    {
                        auto max_elem = fabs(matrix[i][j]);
                        if(max_value < max_elem)
                        {
                            max_value = max_elem;
                            row_max = i;
                            col_max = j;
                        }
                    }
                }

               transposition(size_sys, row, row_max, col_max, matrix, vec);

               for(int temp_row = row + 1; temp_row < size_sys; temp_row++)
               {
                   auto coeff = matrix[temp_row][row] / matrix[row][row];
                   for(int temp_col = row; temp_col < size_sys; temp_col++)
                   {
                       matrix[temp_row][temp_col] = matrix[temp_row][temp_col] - coeff * matrix[row][temp_col];
                   }
                   vec[temp_row] = vec[temp_row] - coeff * vec[row];
               }
            }

        }

};

#endif // SLAE_SOLVER_HXX
